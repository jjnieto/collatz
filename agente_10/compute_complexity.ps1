# compute_complexity.ps1
# Calcula p*_N(k) para la funcion de complejidad ponderada de Collatz/Syracuse.
#
# Definicion: p*_N(k) = #{u in {0,1}^k : exists n <= N, w(n)|k = u, T^k(n) < n}
#
# Por biyeccion de Terras n -> w(n)|k mod 2^k, cuando upper = min(N, 2^k) cumple
# upper >= 2^k (esto es 2^k <= N) cada palabra u tiene su representante en
# [1, 2^k], y p*_N(k) = |{n in [1,2^k] : T^k(n) < n}|. Cuando 2^k > N,
# todos los n <= N pertenecen a clases distintas (porque difieren por menos de 2^k),
# asi que p*_N(k) = |{n in [1,N] : T^k(n) < n}| (exacto, no cota inferior).
#
# Tomamos int64 (n <= 10^8, intermedios < 2^63).
#
# Para N=10^8 y k=30,40, el enumerador exacto costaria 10^8 * k pasos ~ 3-4*10^9
# operaciones bigint en PowerShell (mas de 1 hora). Usamos muestreo aleatorio
# uniforme con S=200000 puntos; estimamos p*_N(k) ~= (hits/S) * N y reportamos
# error 1-sigma sqrt(p(1-p)/S) * N.

function Count-Pstar-Exact([int64]$N, [int]$k) {
    if ($k -ge 62) { $upper = $N } else {
        $mod = [int64]1 -shl $k
        $upper = if ($N -lt $mod) { $N } else { $mod }
    }
    [int64]$hits = 0
    $checkpoint = [int64]([math]::Max(1, [math]::Floor([double]$upper / 5)))
    for ([int64]$n = 1; $n -le $upper; $n++) {
        $x = $n
        for ($i = 0; $i -lt $k; $i++) {
            if (($x -band 1L) -eq 0L) { $x = $x / 2L } else { $x = (3L * $x + 1L) / 2L }
        }
        if ($x -lt $n) { $hits++ }
        if ($n % $checkpoint -eq 0) {
            Write-Host ("  progreso: " + $n + " / " + $upper + ", hits: " + $hits)
        }
    }
    return [pscustomobject]@{ value = $hits; method = 'exacto'; meta = "upper=$upper" }
}

function Count-Pstar-Sample([int64]$N, [int]$k, [int]$S) {
    $rng = New-Object System.Random 1729
    [int64]$hits = 0
    for ($i = 0; $i -lt $S; $i++) {
        $r1 = [int64]$rng.Next()
        $r2 = [int64]$rng.Next()
        [int64]$n = ($r1 * 32768L + $r2) % $N + 1L
        $x = $n
        for ($j = 0; $j -lt $k; $j++) {
            if (($x -band 1L) -eq 0L) { $x = $x / 2L } else { $x = (3L * $x + 1L) / 2L }
        }
        if ($x -lt $n) { $hits++ }
    }
    $rate = [double]$hits / [double]$S
    [int64]$est = [int64]([math]::Round($rate * [double]$N))
    $sigma = [math]::Sqrt($rate * (1 - $rate) / $S) * [double]$N
    return [pscustomobject]@{ value = $est; method = 'muestreo'; meta = ("S=" + $S + ",rate=" + [math]::Round($rate,5) + ",sigma=" + [math]::Round($sigma,0)) }
}

$results = @()
$start = Get-Date
$EXACT_LIMIT = [int64]5000000

foreach ($Npair in @(@{tag='10^6'; val=[int64]1000000}, @{tag='10^8'; val=[int64]100000000})) {
    foreach ($k in @(10, 20, 30, 40)) {
        Write-Host ("=== N=" + $Npair.tag + ", k=" + $k + " ===")
        $t0 = Get-Date
        if ($k -ge 62) { $upper = $Npair.val } else {
            $mod = [int64]1 -shl $k
            $upper = if ($Npair.val -lt $mod) { $Npair.val } else { $mod }
        }
        if ($upper -le $EXACT_LIMIT) {
            $res = Count-Pstar-Exact $Npair.val $k
        } else {
            $res = Count-Pstar-Sample $Npair.val $k 200000
        }
        $dt = ((Get-Date) - $t0).TotalSeconds
        Write-Host ("  resultado: p* = " + $res.value + " (" + $res.method + ", " + [math]::Round($dt,1) + "s)")
        $results += [pscustomobject]@{ N = $Npair.tag; k = $k; p_star = $res.value; method = $res.method; meta = $res.meta; seconds = [math]::Round($dt,1) }
    }
}

$results | Export-Csv -Path "C:\Users\jjnie\collatz\agente_10\complexity_table.csv" -NoTypeInformation -Encoding utf8
Write-Host ("Total: " + ((Get-Date) - $start).TotalSeconds + "s")
$results | Format-Table -AutoSize

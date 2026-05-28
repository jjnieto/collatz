# compute_pstar_large.ps1 — enumeracion exacta para N=10^8, k=40.
# Bug previo: PowerShell es case-insensitive y $n == $N. Uso $Ntot como limite.

[int64]$Ntot = 100000000

foreach ($K in @(40)) {
    Write-Host ("=== N=10^8, k=" + $K + " ===")
    $sw = [System.Diagnostics.Stopwatch]::StartNew()
    [int64]$hits = 0
    [int64]$checkpoint = 5000000
    for ([int64]$ii = 1; $ii -le $Ntot; $ii++) {
        $x = $ii
        for ($j = 0; $j -lt $K; $j++) {
            if (($x -band 1L) -eq 0L) { $x = $x / 2L } else { $x = (3L * $x + 1L) / 2L }
        }
        if ($x -lt $ii) { $hits++ }
        if ($ii % $checkpoint -eq 0) {
            Write-Host ("  progreso: " + $ii + "/" + $Ntot + " hits=" + $hits + " t=" + [math]::Round($sw.Elapsed.TotalSeconds,0) + "s")
        }
    }
    $sw.Stop()
    Write-Host ("  RESULTADO: p*_10^8(" + $K + ") = " + $hits + " (exacto, " + [math]::Round($sw.Elapsed.TotalSeconds,1) + "s)")
}

// compute_sigma.js — agente_05, sprint 2
// Productor de la tubería COMPUTACIONAL-LÓGICA (Collatz).
//
// Mide sigma(n) = tiempo de parada total de la iteración Collatz
// usando la función T(n) = n/2 si par, (3n+1)/2 si impar (operador Syracuse).
// Por convención σ(n) cuenta pasos de T hasta alcanzar 1.
//
// NOTA: usamos memoización con un cache acotado en cima de un esquema
// "termina cuando bajamos por debajo del n original", para acelerar; pero
// para reportar σ(n) absoluto recorremos toda la órbita hasta 1.
//
// Salidas:
//   sigma_data.csv             (muestra estratificada y outliers)
//   sigma_outliers.csv         (top-K outliers por sigma(n)/log2(n))
//   sigma_summary.json         (C_emp, sd, rango, n)
//   sigma_histogram.csv        (bins de sigma/log2 n)
//
// Uso: node compute_sigma.js [Nmax_exponent]
//   Nmax_exponent (entero), barrido sobre n=1..2^Nmax_exponent.
//   Default: 24  -> 2^24 = 16_777_216

'use strict';
const fs = require('fs');
const path = require('path');

const NMAX_EXP = parseInt(process.argv[2] || '24', 10);
const NMAX = 2 ** NMAX_EXP;
const TOP_K = 1000;          // outliers
const HIST_BINS = 50;
const SAMPLE_EVERY = Math.max(1, Math.floor(NMAX / 50000)); // muestra ~50k filas para CSV

console.log(`Barrido Collatz: n = 1..${NMAX} (2^${NMAX_EXP}). Top-K=${TOP_K}.`);

// Memoización: cache[n] = sigma(n) si n < CACHE_LIMIT.
// Para NMAX=2^24, un Int32Array de 2^25 ocuparía 128MB. Lo restringimos.
const CACHE_LIMIT = Math.min(NMAX + 1, 1 << 25); // 32M entries -> 128MB Int32Array
let cache;
try {
  cache = new Int32Array(CACHE_LIMIT);
} catch (e) {
  console.error('No se pudo asignar Int32Array de tamaño', CACHE_LIMIT, ':', e.message);
  cache = new Int32Array(1 << 22);
}
cache[1] = 0;

// Para evitar overflow: durante la iteración, si n excede Number.MAX_SAFE_INTEGER,
// pasamos a BigInt. Con n0 <= 2^24, el récord de "max value en órbita" es modesto;
// el máximo conocido para n<2^32 ronda 7e21 (no cabe en double seguro), así que
// usamos BigInt cuando n > 2^45 como umbral conservador.
const SAFE_LIMIT = 2 ** 45;

function sigma(n0) {
  // Devuelve σ(n0): número de pasos de Syracuse T hasta alcanzar 1.
  // T(n)= n/2 si par; T(n)=(3n+1)/2 si impar.
  // (Algunos autores usan T'(n)=3n+1 sin dividir; nuestra convención es Syracuse.)
  if (n0 === 1) return 0;
  let n = n0;
  let steps = 0;
  // primero usando double mientras sea seguro
  while (n !== 1) {
    if (n < CACHE_LIMIT && cache[n] !== 0) {
      // cache[n] guarda σ(n) (puede ser 0 sólo si n==1, ya cubierto)
      return steps + cache[n];
    }
    if (n > SAFE_LIMIT) {
      // cambiamos a BigInt para el resto
      let m = BigInt(n);
      const ONE = 1n, TWO = 2n, THREE = 3n;
      while (m !== ONE) {
        if ((m & ONE) === 0n) {
          m >>= ONE;
        } else {
          m = (THREE * m + ONE) >> ONE;
        }
        steps++;
        if (m < BigInt(CACHE_LIMIT)) {
          const mi = Number(m);
          if (cache[mi] !== 0 || mi === 1) {
            return steps + (mi === 1 ? 0 : cache[mi]);
          }
        }
      }
      return steps;
    }
    if ((n & 1) === 0) {
      n = n / 2;
    } else {
      n = (3 * n + 1) / 2;
    }
    steps++;
  }
  return steps;
}

// Top-K heap (min-heap por ratio σ/log2 n)
class MinHeap {
  constructor(k) { this.k = k; this.arr = []; }
  push(item) {
    if (this.arr.length < this.k) {
      this.arr.push(item); this._siftUp(this.arr.length - 1);
    } else if (item.ratio > this.arr[0].ratio) {
      this.arr[0] = item; this._siftDown(0);
    }
  }
  _siftUp(i) {
    while (i > 0) {
      const p = (i - 1) >> 1;
      if (this.arr[p].ratio > this.arr[i].ratio) {
        [this.arr[p], this.arr[i]] = [this.arr[i], this.arr[p]]; i = p;
      } else break;
    }
  }
  _siftDown(i) {
    const n = this.arr.length;
    while (true) {
      const l = 2 * i + 1, r = 2 * i + 2;
      let s = i;
      if (l < n && this.arr[l].ratio < this.arr[s].ratio) s = l;
      if (r < n && this.arr[r].ratio < this.arr[s].ratio) s = r;
      if (s === i) break;
      [this.arr[s], this.arr[i]] = [this.arr[i], this.arr[s]]; i = s;
    }
  }
  sorted() { return [...this.arr].sort((a, b) => b.ratio - a.ratio); }
}

const heap = new MinHeap(TOP_K);

// Estadísticos
let count = 0;
let sumRatio = 0, sumRatio2 = 0;
let maxSigma = 0, maxSigmaN = 0;
let maxRatio = 0, maxRatioN = 0;

// Histograma de σ/log2(n) en [0, 10] (50 bins de ancho 0.2)
const HIST_LO = 0, HIST_HI = 10;
const histStep = (HIST_HI - HIST_LO) / HIST_BINS;
const hist = new Int32Array(HIST_BINS + 1); // último bin = overflow

// Muestra para CSV: cada SAMPLE_EVERY añadimos línea n,sigma,ratio
const sampleRows = [];

const LOG2 = Math.log(2);
const t0 = Date.now();
let lastReport = t0;

for (let n = 2; n <= NMAX; n++) {
  const s = sigma(n);
  if (n < CACHE_LIMIT) cache[n] = s;
  const ratio = s / (Math.log(n) / LOG2);
  count++;
  sumRatio += ratio;
  sumRatio2 += ratio * ratio;
  if (s > maxSigma) { maxSigma = s; maxSigmaN = n; }
  if (ratio > maxRatio) { maxRatio = ratio; maxRatioN = n; }
  heap.push({ n, sigma: s, ratio });
  // histograma
  let bi;
  if (ratio >= HIST_HI) bi = HIST_BINS;
  else { bi = Math.floor((ratio - HIST_LO) / histStep); if (bi < 0) bi = 0; }
  hist[bi]++;
  if (n % SAMPLE_EVERY === 0) sampleRows.push([n, s, ratio]);
  if ((n & 0xFFFFF) === 0) {
    const now = Date.now();
    if (now - lastReport > 5000) {
      lastReport = now;
      const pct = (n * 100 / NMAX).toFixed(1);
      console.log(`  n=${n} (${pct}%), maxσ=${maxSigma}@${maxSigmaN}, maxRatio=${maxRatio.toFixed(4)}@${maxRatioN}`);
    }
  }
}

const tElapsed = (Date.now() - t0) / 1000;
const mean = sumRatio / count;
const variance = (sumRatio2 / count) - mean * mean;
const sd = Math.sqrt(Math.max(0, variance));
const C_emp = maxRatio; // mínimo C tal que sigma(n) <= C * log2(n) en el rango medido

console.log(`\nBarrido completado en ${tElapsed.toFixed(1)} s.`);
console.log(`N=${count}, media(σ/log2 n)=${mean.toFixed(4)}, sd=${sd.toFixed(4)}, max=C_emp=${C_emp.toFixed(6)} (n=${maxRatioN}).`);

// Escribir salidas en agente_05/
const OUT_DIR = __dirname;
function writeCSV(filename, header, rows) {
  const lines = [header.join(',')];
  for (const r of rows) lines.push(r.join(','));
  fs.writeFileSync(path.join(OUT_DIR, filename), lines.join('\n') + '\n');
}

writeCSV('sigma_data.csv',
  ['n', 'sigma', 'ratio_sigma_log2n'],
  sampleRows.map(r => [r[0], r[1], r[2].toFixed(6)]));

const outliers = heap.sorted();
writeCSV('sigma_outliers.csv',
  ['n', 'sigma', 'ratio_sigma_log2n'],
  outliers.map(o => [o.n, o.sigma, o.ratio.toFixed(6)]));

writeCSV('sigma_histogram.csv',
  ['bin_lo', 'bin_hi', 'count'],
  Array.from({ length: HIST_BINS + 1 }, (_, i) => {
    const lo = HIST_LO + i * histStep;
    const hi = (i === HIST_BINS) ? Infinity : HIST_LO + (i + 1) * histStep;
    return [lo.toFixed(2), (i === HIST_BINS ? 'inf' : hi.toFixed(2)), hist[i]];
  }));

const summary = {
  schema_version: 1,
  agente: 'agente_05',
  sprint: 2,
  operator: 'Syracuse: T(n)=n/2 if even else (3n+1)/2',
  sigma_definition: 'count of T-steps until first reaching 1; sigma(1)=0',
  range: { n_min: 2, n_max: NMAX, n_max_exp: NMAX_EXP, count: count },
  stats: {
    mean_ratio: mean,
    sd_ratio: sd,
    max_sigma: { value: maxSigma, n: maxSigmaN },
    C_emp: { value: C_emp, n: maxRatioN, definition: 'sup over measured range of sigma(n)/log2(n)' }
  },
  elapsed_seconds: tElapsed,
  files: {
    sample: 'sigma_data.csv',
    outliers: 'sigma_outliers.csv',
    histogram: 'sigma_histogram.csv'
  }
};
fs.writeFileSync(path.join(OUT_DIR, 'sigma_summary.json'), JSON.stringify(summary, null, 2));
console.log('Escritos: sigma_data.csv, sigma_outliers.csv, sigma_histogram.csv, sigma_summary.json');

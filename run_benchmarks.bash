#!/bin/bash

/bench/BandCholesky/build/band_cholesky_test --benchmark_time_unit=ms --benchmark_report_aggregates_only=true --benchmark_filter=BM_par_pbtrf --benchmark_out=/bench/task_par.log

/bench/BandCholesky/build_mkl/band_cholesky_test --benchmark_time_unit=ms --benchmark_report_aggregates_only=true --benchmark_filter=BM_Lapacke --benchmark_out=/bench/mkl_par.log

python3 parse_benchmark_logs.py

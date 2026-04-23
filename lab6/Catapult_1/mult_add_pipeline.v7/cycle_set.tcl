
# Loop constraints
directive set /mult_add_pipeline/core/core:rlp CSTEPS_FROM {{. == 1}}
directive set /mult_add_pipeline/core/core:rlp/main CSTEPS_FROM {{. == 6} {.. == 1}}

# IO operation constraints
directive set /mult_add_pipeline/core/core:rlp/main/gain:io_read(gain:rsc.@) CSTEPS_FROM {{.. == 1}}
directive set /mult_add_pipeline/core/core:rlp/main/product:io_read(a) CSTEPS_FROM {{.. == 0}}
directive set /mult_add_pipeline/core/core:rlp/main/product:io_read(b) CSTEPS_FROM {{.. == 0}}
directive set /mult_add_pipeline/core/core:rlp/main/sum:io_read(c) CSTEPS_FROM {{.. == 0}}
directive set /mult_add_pipeline/core/core:rlp/main/CHECK:io_read(gain_adjust:rsc.@) CSTEPS_FROM {{.. == 1}}
directive set /mult_add_pipeline/core/core:rlp/main/io_write(result) CSTEPS_FROM {{.. == 5}}

# Sync operation constraints

# Real operation constraints
directive set /mult_add_pipeline/core/core:rlp/main/product:mul CSTEPS_FROM {{.. == 2}}
directive set /mult_add_pipeline/core/core:rlp/main/sum:acc CSTEPS_FROM {{.. == 3}}
directive set /mult_add_pipeline/core/core:rlp/main/operator*<10,2,true,AC_TRN,AC_WRAP,26,false>:mul CSTEPS_FROM {{.. == 4}}
directive set /mult_add_pipeline/core/core:rlp/main/CHECK:mux CSTEPS_FROM {{.. == 5}}

# Probe constraints

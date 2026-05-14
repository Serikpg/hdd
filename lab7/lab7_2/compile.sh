#!/bin/sh

if [ -z "${MGC_HOME}" ]; then
  echo "MGC_HOME not set.  You must set \$MGC_HOME to the Catapult install tree."
  exit;
fi

if [ ! -f src/lpf_AC.cpp ]; then
  echo "lpf_AC.cpp not found.  You must run this script from the ./module3/ directory."
  exit;
fi

echo "compiling files..."
$MGC_HOME/bin/g++ -c -o src/csvparser.o $MGC_HOME/shared/include/csvparser.c >&2
$MGC_HOME/bin/g++ -c -o src/lpf_AC.o src/lpf_AC.cpp -I"$MGC_HOME/shared/include"
$MGC_HOME/bin/g++ -c -o src/lpf_AC_tb.o src/lpf_AC_tb.cpp -I"$MGC_HOME/shared/include"
$MGC_HOME/bin/g++ -o lpf_AC_tb src/csvparser.o src/lpf_AC.o src/lpf_AC_tb.o 

echo "Compilation complete.  Execute 'lpf_AC_tb' to run the FIR filter"


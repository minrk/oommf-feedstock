#!/bin/bash

TCLTKVERSION=8.5

# Compile OOMMF.
export OOMMF_TCL_CONFIG=${PREFIX}/lib/tclConfig.sh
export OOMMF_TK_CONFIG=${PREFIX}/lib/tkConfig.sh
make build-with-dmi-extension-all

# Copy all OOMMF sources and compiled files into $PREFIX/opt/.
install -d ${PREFIX}/opt/
install -d ${PREFIX}/bin/
cp -r ${SRC_DIR}/oommf ${PREFIX}/opt/

# Create an executable called 'oommf' in ${PREFIX}/bin which
# calls the OOMMF executable in $PREFIX/opt/.
oommf_command=$(cat <<EOF
#! /bin/bash
export OOMMF_TCL_CONFIG=$PREFIX/lib/tclConfig.sh
export OOMMF_TK_CONFIG=$PREFIX/lib/tkConfig.sh
$PREFIX/bin/tclsh${TCLTKVERSION} $PREFIX/opt/oommf/oommf.tcl "\$@"
EOF
)
echo "$oommf_command" > ${PREFIX}/bin/oommf
chmod a+x ${PREFIX}/bin/oommf

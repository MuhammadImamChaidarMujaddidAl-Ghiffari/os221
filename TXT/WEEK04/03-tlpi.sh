#!/bin/bash
# 41:08AAE022
# REV02: Mon 07 Mar 2022 13:30:00 WIB
# REV01: Sun 26 Sep 2021 14:03:13 WIB
# START: Thu 18 Mar 2021 06:13:06 WIB

SEQ="03"

if   [ -f  98-include.sh ] ; then
    .  ./98-include.sh
elif [ -f  $HOME/bin/98-include.sh ] ; then
    .  $HOME/bin/98-include.sh
else
    echo "98-include.sh not found"
    exit
fi

# ZCZC START #### #### #### ####
FILE="$WEEKDIR/WEEK$WEEK-$SEQ-TLPI.txt"
DIR="tlpi-dist/"
[ -f $FILE      ] && /bin/rm -f $FILE
[ -d $HOME/bin/ ] || mkdir -pv $HOME/bin/
[ -d $WEEKDIR/  ] || mkdir -pv $WEEKDIR/


echo ""
echo "==== ==== Do not forget to read tlpi-dist/README and tlpi-dist/BUILDING ==== ===="
echo ""
sleep 3
[ -f $TARBALL ] || error NoTARBALL $TARBALL

tmpVAR=$(tar xfv $TARBALL|sed -E -e 's/[[:blank:]]+/\n/g'|cut -d'/' -f2|sort -u)
fecho TLPIBALL $(echo $tmpVAR)
[ -d $DIR ] || error NO TLPIDIR

cd $DIR
fecho "PWD $(pwd)"
fecho "MAKE"
make clean
tmpVAR=$(ls -R | wc -l)
make
fecho "DIRSIZE $(ls -alR|wc -l)"
fecho "FILE1 $(ls -la README)"
fecho "FILE2 $(ls -la time/calendar_time.c)"
fecho "FILE3 $(ls -la time/calendar_time)"
fecho "calendar_time $(time/calendar_time)"
tmpVAR="$tmpVAR $(ls -R | wc -l)"
fecho "make clean"
make  clean
tmpVAR="$tmpVAR $(ls -R | wc -l)"
cd ..
fecho SCRIPT    $(head -3 $0 | tail -1)
fecho STAMPX    $(mkSTAMP)
fecho VERSUM    $(versum $0)
fecho WEEKSQ    $WEEK $SEQ
fecho VERDSK    $(verdisk)
fecho VERLNX    $(verkernel)
fecho PATHXX    $(echo $PATH|grep -Eo \/home\/$(whoami)\/bin) IS OK
fecho hoBIN $(ls $HOME/bin/)
fecho TLPISIZE  $tmpVAR
fecho ===== ===== RESULT IN $FILE ===== =====
echo ""
echo "===== ===== Do not forget to read tlpi-dist/README and tlpi-dist/BUILDING ===== ====="
echo ""
sleep 3
exit
exit

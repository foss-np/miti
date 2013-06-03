#!/bin/bash
### LICENSE
# Copyright (C) 2013 crazyNeo <shalil9130@gmail.com>

# A class to convert Bikram Samwat (B.S.) to A.D. and vice versa.

# Usage:

# Range:
# 1944 A.D. to 2033 A.D.
# 2000 B.S. to 2089 B.S.

# bs_date.json : a dictionary in json format that contains the number of days in each month of the B.S. year
# bs_equiv, ad_equiv  : The B.S. and A.D. equivalent dates for counting and calculation

# (bs_equiv, ad_equiv) = ((2000,9,17),(1944,1,1))
bs_equiv=(2000 9 17)
ad_equiv=(1944 1 1)

function Usage {
    echo -e "Usage: \tnepdate.sh [OPTIONS]"
    echo -e "\t--ad2bs\tConvert from A.D. to B.S."
    echo -e "\t--bs2ad\tConvert from B.S. to A.D."
}

function leap_year {
    # flag is 1 for leap year & 0 for normal year
    if [ $((month%400)) == 0 ]; then
	flag_leap_year=1
    elif [ $((month%100)) !=0 && $((month%4)) == 0 ]; then
	flg_leap_year=1
    else
	flag_leap_year=0
    fi
}

function count_ad_days {
    # Calculates the number of days between the two given A.D. dates.

    # begin_ad_date : An array in the format (year, month, day) that specify
    delta_days=$(($(($(date -d "${bs_equiv[0]}-${bs_equiv[1]}-${bs_equiv[2]}" "+%s") - $(date -d "${ad_date[0]}-${ad_date[1]}-${ad_date[2]}" "+%s"))) / 86400))

# echo $(($(($(date -d "${bs_equiv[0]}-${bs_equiv[1]}-${bs_equiv[2]}" "+%s") - $(date -d "${ad_date[0]}-${ad_date[1]}-${ad_date[2]}" "+%s"))) / 86400))
    echo $delta_days
}

function add_bs_days_to_ad {
    a=9
    bs_days=$(date -d "2010-01-29 +9 days" +%Y-%m-%d)
    # date -d "2010-01-29 +9 days" +%Y-%m-%d
    echo $bs_days
}



#checking arguments
if [ $# -eq 0 ]; then
    Usage;
    exit 1;
fi

TEMP=$(getopt --long ad2bs:,bs2ad\
		-n "nepdate" -- "$@")

if [ $? != "0" ]; then
    exit 1
fi

eval set -- "$TEMP"

case $1 in
    # ad2bs part
    --ad2bs)
	ad_date=$2
	;;
    # bs2ad part
    --bs2ad)
	bs_date=$2
	;;
    *)
	Usage
	;;

esac


month=2000
ad_date=(2000 1 1)
# a = 9
# date -d "2010-01-29 +$a days" +%Y-%m-%d
#
# subtract days
# echo $(($(($(date -d "2010-06-01" "+%s") - $(date -d "2010-05-15" "+%s"))) / 86400))

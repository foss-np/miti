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

function add_days_to_ad {
    # STILL WORKING ON
    bs_days=$(date -d "2010-01-29 +$delta_days days" +%Y-%m-%d)
    # date -d "2010-01-29 +9 days" +%Y-%m-%d
    echo $bs_days
}

function add_days_to_bs {
        # Adds the given number of days to the given B.S. date and returns it as a tuple in the format (year,month,day)

        # bs_date : a tuple in the format (year,month,day)
        # delta_days : Number of days to add to the given date

        # Algorithm:
        # 1) Add the total number of days to the original days

        # 2) Until the number of days becomes applicable to the current month, subtract the days by the number of days in the current month and increase the month

        # 3) If month reaches 12, increase the year by 1 and set the month to 1

        # Note:
        # Tuple in the dictionary starts from 0

    year=${bs_equiv[0]}
    month=${bs_equiv[1]}
    day=${bs_equiv[2]}
    #1) Add the total number of days to the original days
    $day=$day+$delta_days
    #2) Until the number of days becomes applicable to the current month, subtract the days by the number of days in the current month and increase the month
    while $day>$(jshon -e $year -e (($month-1)) < bs_date.json); do
	delta
	day=day-$(jshon -e $year -e (($month-1)) < bs_date.json)
	month++
	#3) If month reaches 12, increase the year by 1 and set the month to 1
        if month > 12; then
            month=1
            $year++
	fi
    done
    echo $year -$month - $day
}


function count_bs_days {
        # Returns the number of days between the two given B.S. dates.

        # begin_ad_date : A tuple in the format (year,month,day) that specify the date to start counting from.
        # end_ad_date : A tuple in the format (year,month,day) that specify the date to end counting.

        # Algorithm:

        # Its not the piece of algorithm, but it works for this program..

        # 1) First add total days in all the years

        # 2) Subtract the days from first (n-1) months of the beginning year

        # 3) Add the number of days from the last month of the beginning year

        # 4) Subtract the days from the last months from the end year

        # 5) Add the beginning days excluding the day itself

        # 6) Add the last remaining days excluding the day itself


        # NOTE:
        # Tuple in the dictionary starts from 0
        # The range(a,b) function starts from a and ends at b-1
    delta_days=0
    #1) First add total days in all the years
    for ((year=bs_equiv[0]; year<=bs_date[0]; year++)) {
    	for ((month=0; month<12 ; month++)) {
	    month_day=$(jshon -e $year -e $month < bs_date.json)
    	    ((delta_days=$delta_days+$month_day))
    	}
    }
    #2) Subtract the days from first (n-1) months of the beginning year
    for ((month=0; month<bs_equiv[1]; month++)) {
	month_day=$(jshon -e $bs_equiv[0] -e $month <bs_date.json)
	((delta_days=$delta_days-$month_day))
    }
    #3) Add the number of days from the last month of the beginning year
    ((delta_days=$delta_days+$(jshon -e $bs_equiv[0] -e 11 <bs_date.json)))
    #4) Subtract the days from the last months from the end year
    for ((month=bs_date[1]; month<11; month++)) {
	month_day=$(jshon -e $bs_equiv[0] -e $month <bs_date.json)
	((delta_days=$delta_days-$month_day))
    }
    #5) Add the beginning days excluding the day itself
    delta_days=$delta_days-$bs_equiv[2] - 1
}


function bs2ad {
    Returns the A.D. equivalent date as a tuple in the format yyyy-mm-dd if the date is within range, else returns None
    if $
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
	ad2bs
	;;
    # bs2ad part
    --bs2ad)
	bs_date=$2
	bs2ad
	;;
    *)
	Usage
	;;

esac

month=2000
ad_date=(2000 1 1)
bs_date=(2050 1 1)
add_days_to_ad
# a = 9
# date -d "2010-01-29 +$a days" +%Y-%m-%d
#
# subtract days
# echo $(($(($(date -d "2010-06-01" "+%s") - $(date -d "2010-05-15" "+%s"))) / 86400))

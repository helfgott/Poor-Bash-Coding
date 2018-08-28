#!/bin/bash
# miguel.ortiz
# Problem: https://www.codewars.com/kata/567501aec64b81e252000003

wallpaper() {
#total surface m2
wallpaper='5.2'                                                 # wallpaper m2 (this is a fixed value)
axisx=`echo "$1 * $3 * 2" | bc -l`                              # long wall in m2 (x2)
axisy=`echo "$2 * $3 * 2" | bc -l`                              # width wall in m2 (x2)
surface=`echo "$axisx + $axisy" | bc -l`                        # all walls total in m2
wpamount=`echo "$surface / $wallpaper" |bc -l`                  # exact ammount of wallpaper
wpamountotal=`echo "$wpamount * 15 / 100 + $wpamount" | bc -l`  # increase 15% (in case of a bad handyman)

#wptotal=`LC_ALL=C printf '%.0f' "$wpamountotal"`               # round number, use LOCALE C to ignore user's locale
                                                                # does not work because printf round automatically
                                                                # ty Carmen for pointing that out :)

wptotal=`echo "$wpamountotal" | awk '{print ($0-int($0)>0)?int($0)+1:int($0)}'`         # round number to ceil
                                                                                        # just because we always will need more

#English Translation

# our array with numbers and words
numbers=('1,one' '2,two' '3,three' '4,four' '5,five' '6,six' '7,seven' '8,eight' '9,nine' '0,zero' '10,ten' '11,eleven' \
        '12,twelve' '13,thirteen' '14,fourteen' '15,fifteen' '16,sixteen' '17,seventeen' '18,eighteen' '19,nineteen' '20,twenty')

match=(${numbers[@]#$wptotal,*})                                # get our match number (word) with parameter expansion
                                                                # by removing the <NUMBER><,> and leaving only the number (word)

for i in "${match[@]}" ; do                                     # parse the array

        if [[ $i =~ , ]];                                       # if there's a <,> isn't our match
        then
                :
        else
                if [ "$axisx" == '0' ] || [ "$axisy" == '0' ]   # if there's no wall ( -_- ) ?
                then
                        echo 'zero'
                else
                        echo $i                                 # bingo
                fi
        fi
done

}
wallpaper $1 $2 $3


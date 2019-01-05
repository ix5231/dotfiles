#!/bin/sh

BAT_DIR="/sys/class/power_supply"

if [ -z "$(ls $BAT_DIR/BAT* 2> /dev/null)" ]; then
    exit
fi

IFS="
"
while true; do
    max=0
    charging=false
    for b in "$BAT_DIR"/BAT*; do
        p=$(cat "$b"/capacity)
        if [ "$p" -gt "$max" ]; then
            max=$p
        fi
        if grep -q "Charging" < "$b"/status; then
            charging=true
        fi
    done

    if [ "$max" -le 5 ] && ! "$charging"; then
        notify-send -u critical "WARNING: Low battery: $max!"
    elif [ "$max" -le 20 ] && ! "$charging"; then
        notify-send "Low battery: $max"
    fi

    sleep 300
done

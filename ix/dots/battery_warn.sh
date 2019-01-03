#!/bin/sh

IFS="
"
while true; do
    max=0
    charging=false
    for b in $(acpi -b); do
        p=$(echo "$b" | grep -o -e "[0-9]*%" | grep -o -e "[0-9]*")
        if [ "$p" -gt "$max" ]; then
            max=$p
        fi
        if echo "$b" | grep -q "Charging" ; then
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

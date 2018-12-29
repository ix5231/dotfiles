#!/bin/sh

while true; do
    IFS="
    "
    max=0
    cflg=false
    for b in $(acpi -b); do
        p=$(echo "$b" | grep -o -e "[0-9]*%" | grep -o -e "[0-9]*")
        if [ "$p" -gt "$max" ]; then
            max=$p
        fi
        if ! echo "$b" | grep -q "Charging" ; then
            cflg=true
        fi
    done

    if [ "$max" -lt 10 ] && [ ! $cflg ]; then
        notify-send "Low battery: $max"
    elif [ "$max" -lt 5 ] && [ ! $cflg ]; then
        notify-send -u critical "WARNING: Low battery: $max!"
    fi

    sleep 300
done

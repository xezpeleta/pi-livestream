#! /bin/bash
set -e

APP="mjpg_streamer"
APPDIR="/root/mjpg-streamer"

# load module
modprobe bcm2835-v4l2

if [ -d "$APPDIR" ]; then
    cd $APPDIR
else
    echo "ERROR, cannot find mjpg streamer"
    exit 1
fi

if [ -a /dev/video0 ]; then
    export LD_LIBRARY_PATH="$APPDIR"
    ./$APP -i "$APPDIR/input_uvc.so -f 10 -r 640x320 -n -y" \
           -o "$APPDIR/output_http.so -w $APPDIR/www -l 0.0.0.0 -p 80"
fi

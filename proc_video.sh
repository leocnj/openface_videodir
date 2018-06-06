#!/bin/bash
# proc_video.sh
#
# loop a dir
# for each video
#     base name to new name
#     call FFMPEG to convert to mp4 640x480 w/ audio (-an)
#          force FPS to 30 
# ref http://bit.ly/2KM9RG8
root=$1

one_mp4() {
    video=$(basename $1 .mp4)
    video_dst=fps10/$1
    echo $video_dst
    ffmpeg -y -i $1 -s 640x480 -r 10 -c:v libx264 $video_dst
}
export -f one_mp4

ls $root/*.mp4 > $$.tmp
parallel -j 4 one_mp4 < $$.tmp
rm -f $$.tmp
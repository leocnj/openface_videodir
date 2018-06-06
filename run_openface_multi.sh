#!/bin/bash
#
#
one_video() {
  video=$(basename $1 .mp4)
  # skip processed videos if their csv files exist
  if [ ! -f $root/processed/$video.csv ]; then
      echo $video
      docker exec ofv2 /opt/OpenFace/build/bin/FeatureExtraction -f ${video}.mp4 \
      -q \
      -pose -aus -gaze -tracked
  fi
}
# https://unix.stackexchange.com/questions/271134/how-to-make-a-function-available-to-the-command-parallel-gnu
export -f one_video

root=$1
# run docker in a daemon mode
docker run --name ofv2 --rm -v $(pwd)/$root:/data -w '/data' -d -it openface_v1.0
ls $root/*.mp4 > videos.tmp
parallel -j 8 one_video < videos.tmp
rm -f videos.tmp
docker stop ofv2
#!/bin/bash
#
#
one_video() {
  video=$(basename $1 .mp4)
  echo $video
  docker exec openpose ./build/examples/openpose/openpose.bin \
  --video /data/${video}.mp4\
  --write_video /data/op_videos/${video}.avi \
  --write_keypoint_json /data/op_poses \
  --no_display
  # --face --hand  enabling this will increase 30% running time
}
# https://unix.stackexchange.com/questions/271134/how-to-make-a-function-available-to-the-command-parallel-gnu
export -f one_video

data_dir=/workspace/lchen/works/data/engagement/fps10
root=$1    # train vs validation
# run docker in a daemon mode
docker run --runtime=nvidia --name openpose --rm -v ${data_dir}/${root}:/data -d -it garyfeng/densepose:latest
cd ${data_dir}/${root}
ls *.mp4 > videos.tmp
parallel -j 1 one_video < videos.tmp
rm -f videos.tmp
docker stop openpose
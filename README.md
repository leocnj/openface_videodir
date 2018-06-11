
Video Processing on Engagement Challenge Data
=======

# video standarization

The video files downloaded from OneDrive have the following issues:

- different formats
- different resolutions
- different sampling rate; some videos have a very strangely high FPS to 1,000

`proc_video.sh` to standarize all videos to

- .mp4 foramt
- 640x480 resolution
- without audio track since auido was not used in the annotation process
- 10 FPS

# open-face

First, install OpenFace V1.0 in a docker by using [Lei's docker file](https://github.com/leocnj/docker-images/blob/master/openface-cambridge/openface-cambridge.dockerfile)

Next, use `run_openface_multi.sh` to run openface in a parallel way

# open-pose 

OpenPose needs a GPU to run the body pose tracking in a reasonably fast speed.

First, on AWS machine (svlab03), install docker by following [this guide](https://medium.com/@Grigorkh/how-to-install-docker-on-ubuntu-16-04-3f509070d29c)

Next, install nvidia-docker (so that we can use GPU in a docker) by following [NVIDIA's official guide](https://github.com/nvidia/nvidia-docker/wiki/Installation-(version-2.0))

Then, install [Gary Feng's openpose docker image](https://github.com/garyfeng/docker-openpose)

After the above installations, we now can run openpose tracking on svlab03 machine. See `run_openpose.sh` for details. Note that K80 is a weak GPU and cannot support real-time tracking. For faster tracking, we now only enabled body pose tracking.

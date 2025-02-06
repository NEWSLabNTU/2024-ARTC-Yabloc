# 2024-ARTC-Yabloc

## Description
This repository is for 2024 ARTC project, where we evaluate the performance of Yabloc, a localization component from Autoware, in a standalone scheme.

## Prerequisite
- OS: Ubuntu 22.04
- [ROS2 Humble](https://docs.ros.org/en/humble/Installation/Alternatives/Ubuntu-Development-Setup.html)
- [Autoware](https://autowarefoundation.github.io/autoware-documentation/main/installation/autoware/source-installation/)(Branch: 2023.10)
We only need map_loader packages, you can use the commands below to build the autoware packages, it will save much time.
```sh
git clone https://github.com/autowarefoundation/autoware.git
cd autoware
git checkout 2023.10
vcs import src < autoware.repos
# if you don't have vcstool, use 'sudo apt install python3-vcstool' to install it.
source /opt/ros/humble/setup.bash
rosdep install -y --from-path src --ignore-src --rosdistro $ROS_DISTRO
colcon build --symlink-install --packages-up-to map_loader map_projection_loader
```
- [CARLA 0.9.14](https://carla.readthedocs.io/en/0.9.14/start_quickstart/)
(Hardware requirements: GPU 2080ti+ / VRAM 6GB+ / Disk 170GB+)

## Build
```sh
git clone https://github.com/NEWSLabNTU/2024-ARTC-Yabloc
cd 2024-ARTC-Yabloc/
git submodule update --init --recursive
make prepare
make build
```

## Usage
- Running Yabloc sample launch file. (You can find ros bag from [here](https://drive.google.com/drive/folders/1ADNInLOsWBpyns6xQdVlkyr3R1q3POVQ)) 
```sh
# Terminal 1
source /path_to_autoware/install/setup.bash
cd /path_to_2024-ARTC-Yabloc
make simple_eval

# Terminal 2
source install/setup.bash
ros2 bag play town10_1/  --remap /tf_s:=/tf_static /carla/ego_vehicle/imu:=/sensing/imu/tamagawa/imu_raw /carla/ego_vehicle/rgb_front/camera_info:=/sensing/camera/traffic_light/camera_info /out/compressed:=/sensing/camera/traffic_light/image_raw/compressed /initialpose3:=initialpose
```
## Bag Record with CARLA
- Set up CARLA server first, then activate the `carla_ros_bridge` with manual control. After that, you can record youw own bag for Yabloc evaluation.
```sh
# Terminal 1
cd /path/to/CARLA-0.9.14
./CarlaUE4.sh

# Terminal 2
cd /path/to/2024-ARTC-Yabloc
make simple_record

# Terminal 3
source /path/to/2024-ARTC-Yabloc/install/setup.bash
ros2 bag record /topic1 /topic2 ...
```

## Note
In this repository, we can only evaluate the performance of Yabloc in standalone scheme. The workflow here is not compatible to the latest Autoware.

# 2024-ARTC-Yabloc

## Description
This repository is for 2024 ARTC project, where we evaluate the performance of Yabloc, a localization component from Autoware, in a standalone scheme.

## Build
```sh
git clone https://github.com/Allan11231123/2024-ARTC-Yabloc.git
cd 2024-ARTC-Yabloc
source /opt/ros/humber/setup.bash
rosdep install -y --from-path src --ignore-src --rosdistro $ROS_DISTRO
colcon build --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=Release
```

## Usage
- Running Yabloc sample launch file. (You can find ros bag from [here](https://drive.google.com/drive/folders/1ADNInLOsWBpyns6xQdVlkyr3R1q3POVQ)) 
```sh
# Terminal 1
source install/setup.bash
ros2 launch yabloc_launch sample.launch.xml

# Terminal 2
source install/setup.bash
bash test.sh

# Terminal 3
source install/setup.bash
ros2 bag play town10_1/  --remap /tf_s:=/tf_static /carla/ego_vehicle/imu:=/sensing/imu/tamagawa/imu_raw /carla/ego_vehicle/rgb_front/camera_info:=/sensing/camera/traffic_light/camera_info /out/compressed:=/sensing/camera/traffic_light/image_raw/compressed /initialpose3:=initialpose
```

## Note
In this repository, Yabloc component is not up to date. We are now create another workflow using the latest version of Yabloc from autoware universe. 
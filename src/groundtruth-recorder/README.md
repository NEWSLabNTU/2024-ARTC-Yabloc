# Distance Verifier
## Description

This package aims to evaluate the performance of Yabloc, localization component from [Autoware](https://github.com/autowarefoundation/autoware).  
It will measure simple distance difference between prediction pose and ground truth pose. In addition, I also implement ADE, FDE(ongoing), and NL-ADE(ongoing) as evaluation metrics.

## Prerequisite
- OS: Ubuntu 22.04
- [ROS2 Humble](https://docs.ros.org/en/humble/Installation/Alternatives/Ubuntu-Development-Setup.html)
- [Autoware](https://autowarefoundation.github.io/autoware-documentation/main/installation/autoware/source-installation/)

## Build
This package should be placed in the `src/` directory under your workspace.

```bash
cd your_workspace
git clone https://github.com/Allan11231123/distance-verifier.git src/distance-verifier
source /opt/ros/humble/setup.bash
rosdep install -y --from-path src --ignore-src --rosdistro $ROS_DISTRO
colcon build --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=Release
```

## Usage
- Running Yabloc sample launch file.
(You can find testing bag from [here](https://drive.google.com/drive/folders/1ADNInLOsWBpyns6xQdVlkyr3R1q3POVQ?usp=drive_link))
```bash
# Terminal 1
source install/setup.bash
ros2 launch yabloc_launch sample.launch.xml

# Terminal 2
source install/setup.bash
ros2 run distance_verifier distance_verifier

# Terminal 3 
source install/setup.bash
ros2 launch yabloc_launch rviz.launch.xml

# Terminal 4
source install/setup.bash
ros2 bag play town10_1/  --remap /tf_s:=/tf_static /carla/ego_vehicle/imu:=/sensing/imu/tamagawa/imu_raw /carla/ego_vehicle/rgb_front/camera_info:=/sensing/camera/traffic_light/camera_info /out/compressed:=/sensing/camera/traffic_light/image_raw/compressed /initialpose3:=initialpose
```
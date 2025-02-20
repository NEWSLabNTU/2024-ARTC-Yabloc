SHELL := /bin/bash
.PHONY: default prepare build simple_record simple_eval

default:
	@echo 'make prepare'
	@echo '    Install required dependencies for this project.'
	@echo
	@echo 'make build'
	@echo '    Build this project.'
	@echo
	@echo 'make simple_record'
	@echo '    Run simple recording process under CARLA simulation.'
	@echo '    NOTE: Make sure to activate CARLA server first.'
	@echo
	@echo 'make simple_eval'
	@echo '    Run simple evaluation process.'
	@echo '    NOTE: Remember to source your autoware workspace before running this command.'

prepare:
	source /opt/ros/humble/setup.bash && \
	rosdep update --rosdistro=humble && \
	rosdep install -y --from-paths src --ignore-src -r

build:
	source /opt/ros/humble/setup.bash && \
	colcon build \
		--symlink-install \
		--cmake-args -DCMAKE_BUILD_TYPE=Release

simple_record:
	source ./install/setup.bash && \
	ros2 launch ./launch/carla_manual_control.yaml && \
	ros2 launch ./launch/record_accessory.xml

simple_eval:
	source ./install/setup.bash && \
	ros2 launch ./launch/map_load.xml && \
	ros2 launch ./launch/distance_verify.launch.xml && \
	ros2 launch yabloc_launch sample.launch.xml

SHELL := /bin/bash
.PHONY: default prepare build

default:
	@echo 'make prepare'
	@echo '    Install required dependencies for this project.'
	@echo
	@echo 'make build'
	@echo '    Build this project.'

prepare:
	source /opt/ros/humble/setup.bash && \
	rosdep update --rosdistro=humble && \
	rosdep install -y --from-paths src --ignore-src -r

build:
	source /opt/ros/humble/setup.bash && \
	colcon build \
		--symlink-install \
		--cmake-args -DCMAKE_BUILD_TYPE=Release

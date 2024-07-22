#!/usr/bin/env bash

# This is a script to test Yabloc, component for localization in Autoware.

parallel -j0 --lb <<EOF
ros2 run distance_verifier distance_verifier
sleep 2
ros2 launch yabloc_launch rviz.launch.xml
EOF


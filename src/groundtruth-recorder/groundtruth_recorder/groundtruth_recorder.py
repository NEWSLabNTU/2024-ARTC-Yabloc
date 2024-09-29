import rclpy
from rclpy.node import Node
from geometry_msgs.msg import PoseStamped
from nav_msgs.msg import Path, Odometry
from std_msgs.msg import String
from sensor_msgs.msg import Image
from cv_bridge import CvBridge
# from autoware_auto_vehicle_msgs.msg import VelocityReport
# from carla_msgs.msg import CarlaEgoVehicleInfo,CarlaEgoVehicleStatus
from rclpy.qos import  QoSProfile, DurabilityPolicy
import matplotlib.pyplot as plt
import numpy as np
from scipy.spatial.distance import cdist
import os
import csv

class GroundtruthRecorder(Node):
    def __init__(self,output_path):
        super().__init__("distance_verifier")
        
        self.carla_path_subscription = self.create_subscription(
            Odometry,
            "/odom",
            self.nuscenes_pose_to_table_callback,
            1,
        )
        if not os.path.exists(output_path):
            os.makedirs(output_path)
        # self.output_path = output_path

        self.csv_writer = csv.writer(open(output_path+"groundtruth_table.csv","w",newline=''))

        # give initial row into the output file
        self.csv_writer.writerow(['sec','nanosec','x','y'])
        
    def nuscenes_pose_to_table_callback(self,msg):
        groundtruth = msg.pose.pose.position
        stamp = msg.header.stamp
        
        self.csv_writer.writerow([stamp.sec,stamp.nanosec,groundtruth.x,groundtruth.y])

def main():
    rclpy.init()
    groundtruth_recorder = GroundtruthRecorder("../../../resourse/")

    rclpy.spin(groundtruth_recorder)
    groundtruth_recorder.destroy_node()
    rclpy.shutdown()


if __name__ == "__main__":
    main()

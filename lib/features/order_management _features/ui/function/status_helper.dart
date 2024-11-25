import 'package:flutter/material.dart';
import '../../../../core/styles/Colors.dart'; // Adjust the import path as needed

final List<int> myStatuses = StatusHelper.statuses;

class StatusHelper {
  // List of statuses
  static final List<int> statuses = [
    1,
    2,
    3,
    4,
  ];

  // Function to get color based on status
  static Color getColor(String status) {
    switch (status) {
      case '1':
        return AppColors.grey;
      case '2':
        return AppColors.redOpacity;
      case '3':
        return AppColors.greenOpacity;
      case '4':
        return AppColors.blueOpacity;
      default:
        return AppColors.white; // Default color if the status is unknown
    }
  }
}

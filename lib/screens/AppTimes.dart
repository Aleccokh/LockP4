import 'package:flutter/material.dart';
import 'package:app_usage/app_usage.dart';




Future<List<AppUsageInfo>> getUsageStats() async {
  try {
    DateTime endDate = DateTime.now();
    DateTime startDate = endDate.subtract(Duration(hours: 1));
    List<AppUsageInfo> infoList =
    await AppUsage().getAppUsage(startDate, endDate);

    // Sort infoList based on usage duration
    infoList.sort((a, b) => b.usage.compareTo(a.usage));

    // Get only the first five elements
    List<AppUsageInfo> firstFive = infoList.length > 5
        ? infoList.sublist(0, 5)
        : infoList;

    return firstFive;

  } on AppUsageException catch (exception) {
    return[];
  }
}



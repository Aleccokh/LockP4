import 'package:app_usage/app_usage.dart';

import 'package:app_lock_flutter/screens/AppTimes.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AppUsageScreen(),
    );
  }
}

class AppUsageScreen extends StatefulWidget {
  @override
  _AppUsageScreenState createState() => _AppUsageScreenState();
}

class _AppUsageScreenState extends State<AppUsageScreen> {
  Future<List<AppUsageInfo>>? _usageStatsFuture;

  @override
  void initState() {
    super.initState();
    _usageStatsFuture = getUsageStats();
  }

  void _refreshUsageStats() {
    setState(() {
      _usageStatsFuture = getUsageStats();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Usage Statis'),
      ),
      body: FutureBuilder<List<AppUsageInfo>>(
        future: _usageStatsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            List<AppUsageInfo> usageStats = snapshot.data ?? [];
            // Display usage stats in your UI
            return ListView.builder(
              itemCount: usageStats.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(usageStats[index].appName),
                  subtitle: Text(
                    'Usage: ${usageStats[index].usage.inSeconds} seconds',
                    style: TextStyle(
                      color: usageStats[index].usage.inSeconds >= 30 ? Colors.red : Colors.black,
                    ),
                  ),
                  trailing: Icon(
                    usageStats[index].usage.inSeconds >= 30 ? Icons.warning : null,
                    color: usageStats[index].usage.inSeconds >= 30 ? Colors.red : Colors.transparent,
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _refreshUsageStats,
        child: Icon(Icons.refresh),
      ),
    );
  }
}

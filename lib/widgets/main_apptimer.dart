import 'dart:async';
import 'package:flutter/material.dart';
import 'package:app_usage/app_usage.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  List<AppUsageInfo> informationList = [];
  Timer? timer;

  @override
  void initState() {
    super.initState();
    getUsageStats();
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      getUsageStats();
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('App Usage'),
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            // Utilisation d'une flèche de retour
            onPressed: () {
              // Retour à la page des paramètres (Settings)
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: Colors.white, // Couleur de fond du Scaffold
        body: ListView.builder(
            itemCount: informationList.length,
            itemBuilder: (context, index) {
              return ListTile(
                  title: Text(informationList[index].appName),
                  trailing: Text(informationList[index].usage.toString()));
            }),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              // Vous pouvez appeler manuellement la fonction ici si nécessaire
              getUsageStats();
            },
            child: const Icon(Icons.file_download)),
      ),
    );
  }

  void getUsageStats() {
    var appUsage = AppUsage().getAppUsage(
        DateTime.now().subtract(const Duration(hours: 1)), DateTime.now());
    appUsage.then((value) {
      setState(() {
        informationList = value;
      });
    });
  }
}

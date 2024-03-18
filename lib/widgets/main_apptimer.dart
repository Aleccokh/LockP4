import 'dart:async';
import 'package:flutter/material.dart';
import 'package:app_usage/app_usage.dart';
import 'package:app_lock_flutter/screens/settings.dart'; // Importer le fichier settings.dart

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<AppUsageInfo> _infos = [];
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Appel de la fonction pour récupérer les statistiques dès le début
    getUsageStats();
    // Démarrer le timer pour mettre à jour toutes les 5 secondes
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      getUsageStats();
      Icon(Icons.file_download);
    });
  }

  @override
  void dispose() {
    // Arrêter le timer lorsqu'il n'est plus nécessaire pour éviter les fuites de mémoire
    _timer?.cancel();
    super.dispose();
  }

  void getUsageStats() async {
    try {
      DateTime endDate = DateTime.now();
      DateTime startDate = endDate.subtract(Duration(hours: 1));
      List<AppUsageInfo> infoList =
      await AppUsage().getAppUsage(startDate, endDate);
      setState(() => _infos = infoList);

      for (var info in infoList) {
        //print(info.toString());
      }
    } on AppUsageException catch (exception) {
      //print(exception);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('App Usage'),
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back), // Utilisation d'une flèche de retour
            onPressed: () {
              // Retour à la page des paramètres (Settings)
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor, // Couleur de fond du Scaffold
        body: ListView.builder(
            itemCount: _infos.length,
            itemBuilder: (context, index) {
              return ListTile(
                  title: Text(_infos[index].appName),
                  trailing: Text(_infos[index].usage.toString()));
            }),
        floatingActionButton: FloatingActionButton(
        onPressed: () {
        // Vous pouvez appeler manuellement la fonction ici si nécessaire
        getUsageStats();
         },
         child: Icon(Icons.file_download)),
      ),
    );
  }
}

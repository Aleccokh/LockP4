import 'package:app_lock_flutter/models/navigation.dart';
import 'package:app_lock_flutter/screens/home.dart';
import 'package:app_lock_flutter/screens/search.dart';
import 'package:flutter/material.dart';
import 'package:app_lock_flutter/services/init.dart';
import 'package:app_lock_flutter/services/themes.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.dark,
      home: PermissionPage(),
    );
  }
}

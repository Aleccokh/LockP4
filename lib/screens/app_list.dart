import 'package:app_lock_flutter/executables/controllers/apps_controller.dart';
import 'package:app_lock_flutter/widgets/material_card.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppCard extends StatefulWidget {
  const AppCard({Key? key}) : super(key: key);

  @override
  State<AppCard> createState() => _AppCardState();
}

class _AppCardState extends State<AppCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App List'),
        centerTitle: true,
      ),
      body: SizedBox(
        child: GetBuilder<AppsController>(
          builder: (appsController) {
            //Add condition for no list
            return RefreshIndicator(
              onRefresh: () async {
                return await appsController.getAppsData();
              },
              child: ListView.builder(
                itemCount: appsController.unLockList.length,
                itemBuilder: (context, index) {
                  Application app = appsController.unLockList[index];
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: MaterialCardHolder(app: app),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

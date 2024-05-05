import 'dart:ui';

import 'package:app_lock_flutter/executables/controllers/apps_controller.dart';
import 'package:app_lock_flutter/screens/search.dart';
import 'package:app_lock_flutter/screens/search_list.dart';
import 'package:app_lock_flutter/widgets/material_card.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppCard extends StatefulWidget {
  const AppCard({Key? key}) : super(key: key);

  @override
  State<AppCard> createState() => _AppCardState();
}

class _AppCardState extends State<AppCard> with SingleTickerProviderStateMixin{


  List<Application> _searchApps(List<Application> apps, String query) {
    return apps.where((app) {
      final appName = app.appName.toLowerCase();
      return appName.contains(query.toLowerCase());
    }).toList();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App List'),
        centerTitle: true,
      ),
      
      body: Stack( children: [

          SizedBox(
              child: GetBuilder<AppsController>(
                builder: (appsController) {
                  if (appsController.unLockList.isEmpty) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
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
                          child: MaterialCardHolder(app: app, search: false),
                        );
                      },
                    ),
                  );
                },
              ),
            ),

          GetBuilder<AppsController>(
              id: Get.find<AppsController>().addRemoveToUnlockUpdate,
              builder: (state) {
                return state.addToAppsLoading
                    ? BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                        child: const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        ),
                      )
                    : const SizedBox();
              },
            ),
        ],
      ),
    );
  }
  
}
import 'dart:ui';

import 'package:app_lock_flutter/executables/controllers/method_channel_controller.dart';
import 'package:app_lock_flutter/executables/controllers/password_controller.dart';
import 'package:app_lock_flutter/widgets/confirmation_dialog.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import '../executables/controllers/apps_controller.dart';
import '../services/constant.dart';
import '../widgets/pass_confirm_dialog.dart';
import 'set_passcode.dart';

class UnlockedAppScreen extends StatelessWidget {
  const UnlockedAppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          leading: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Container(
              decoration: BoxDecoration(
                // color: Theme.of(context).primaryColorDark,
                borderRadius: BorderRadius.circular(10),
                // ignore: prefer_const_literals_to_create_immutables
              ),
              child: IconButton(
                padding: const EdgeInsets.all(0.0),
                onPressed: () async {
                  await showGeneralDialog(
                    barrierColor: Colors.black.withOpacity(0.8),
                    context: context,
                    barrierDismissible: false,
                    barrierLabel: MaterialLocalizations.of(context)
                        .modalBarrierDismissLabel,
                    transitionDuration: const Duration(milliseconds: 200),
                    pageBuilder: (context, animation1, animation2) {
                      return const ConfirmationDialog(
                          heading: "Stop",
                          bodyText: "Sure you want to stop AppLock");
                    },
                  ).then((value) {
                    if (value as bool) {
                      Get.find<MethodChannelController>().stopForeground();
                    }
                  });
                },
                icon: Icon(
                  Icons.cancel_outlined,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
          centerTitle: true,
          title: Text(
            "AppLock",
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: Colors.white,
                ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                decoration: BoxDecoration(
                  // color: Theme.of(context).primaryColorDark,
                  borderRadius: BorderRadius.circular(10),
                  // ignore: prefer_const_literals_to_create_immutables
                ),
                child: IconButton(
                  onPressed: () {
                    if (Get.find<PasswordController>()
                        .prefs
                        .containsKey(AppConstants.setPassCode)) {
                      showComfirmPasswordDialog(context).then((value) {
                        if (value as bool) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SetPasscode(),
                            ),
                          );
                        }
                      });
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SetPasscode(),
                        ),
                      );
                    }
                  },
                  icon: Icon(
                    Icons.password_rounded,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Theme.of(context).primaryColorDark,
                  ),
                ),
                child: GetBuilder<AppsController>(
                  builder: (appsController) {
                    if (appsController.unLockList.isEmpty) {
                      return Container(
                        color: Colors.transparent,
                        height: 1,
                        child: Column(
                          children: [
                            
                          ],
                        ),
                      );
                    } else {
                      Application app = appsController.unLockList[0];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5),
                                margin: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 14,
                                ),
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.25),
                                      blurRadius: 20.0,
                                      offset: const Offset(5, 5),
                                    ),
                                  ],
                                ),
                                child: app is ApplicationWithIcon
                                    ? CircleAvatar(
                                        backgroundImage: MemoryImage(app.icon),
                                        backgroundColor: Theme.of(context)
                                            .primaryColorDark,
                                      )
                                    : CircleAvatar(
                                        backgroundColor: Theme.of(context)
                                            .primaryColorDark,
                                        child: Text(
                                          "Error",
                                          style: MyFont().subtitle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                              ),Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      app.appName,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(color: Colors.white),
                                    ),
                                  ],
                                ),

                              GetBuilder<AppsController>(
                                id: Get.find<AppsController>()
                                    .addRemoveToUnlockUpdate,
                                builder: (appsController) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),


                                    //Switch to activate deactivate lock
                                    child: FlutterSwitch(
                                      width: 50.0,
                                      height: 25.0,
                                      valueFontSize: 25.0,
                                      toggleColor: Colors.white,
                                      activeColor:
                                          Colors.purple.shade800,
                                      inactiveColor:
                                          Theme.of(context).primaryColorDark,
                                      toggleSize: 20.0,
                                      value: appsController.selectLockList
                                          .contains(app.appName),
                                      borderRadius: 30.0,
                                      padding: 2.0,
                                      showOnOff: false,
                                      onToggle: (val) {
                                        if ("${Get.find<AppsController>().getPasscode()}" !=
                                            "") {
                                          appsController.addToLockedApps(
                                            app,
                                            context,
                                          );
                                        } else {
                                          Fluttertoast.showToast(
                                              msg: "Set password");
                                        }
                                      },
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                ),
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
      ),
    );
  }
}
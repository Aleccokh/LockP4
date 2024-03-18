import 'package:app_lock_flutter/executables/controllers/method_channel_controller.dart';
import 'package:app_lock_flutter/executables/controllers/password_controller.dart';
import 'package:app_lock_flutter/screens/pin.dart';
import 'package:app_lock_flutter/services/constant.dart';
import 'package:app_lock_flutter/widgets/confirmation_dialog.dart';
import 'package:app_lock_flutter/widgets/pass_confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: SizedBox(
        child: Center(
          child: Column(
            children: [
              ElevatedButton(onPressed: () {
                    if (Get.find<PasswordController>()
                        .prefs
                        .containsKey(AppConstants.setPassCode)) {
                      showComfirmPasswordDialog(context).then((value) {
                        if (value as bool) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PinScreen(),
                            ),
                          );
                        }
                      });
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PinScreen(),
                        ),
                      );
                    }
                  }, child: Text("Set Passcode")),
              ElevatedButton(
                  onPressed: () async {
                    await showGeneralDialog(
                      context: context,
                      barrierDismissible: false,
                      barrierLabel: MaterialLocalizations.of(context)
                          .modalBarrierDismissLabel,
                      transitionDuration: const Duration(milliseconds: 200),
                      pageBuilder: (context, animation1, animation2) {
                        return const ConfirmationDialog(
                            heading: "Wait",
                            bodyText:
                                "Are you sure that you want to stop the process?");
                      },
                    ).then((value) {
                      if (value as bool) {
                        Get.find<MethodChannelController>().stopForeground();
                      }
                    });
                  },
                  child: Text("Kill Process"))
            ],
          ),
        ),
      ),
    );
  }
}

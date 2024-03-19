import 'package:app_lock_flutter/executables/controllers/apps_controller.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class MaterialCardHolder extends StatefulWidget {
  var app;
  MaterialCardHolder({Key? key, this.app}) : super(key: key);

  @override
  State<MaterialCardHolder> createState() => _MaterialCardHolderState();
}

class _MaterialCardHolderState extends State<MaterialCardHolder> {

  bool locked = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      
      child: Container (
        height: MediaQuery.of(context).size.height * 0.1,
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[

              
              //App Icon
              Padding(padding: const EdgeInsets.only(left: 8) ,
              child: widget.app is ApplicationWithIcon? 
              CircleAvatar(
                backgroundImage: MemoryImage(widget.app.icon),
                ):
              const CircleAvatar(
                backgroundColor: Colors.grey,
                ),
              ),
              const SizedBox(width: 15),


              //App Name
              Expanded(
                child: Text("${widget.app.appName}"),
              ),
              const SizedBox(width: 8),


              //Switch
              GetBuilder<AppsController>(
                id: Get.find<AppsController>().addRemoveToUnlockUpdate,
                builder: (appsController) {
                  return  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Switch(
                      value: appsController.selectLockList.contains(widget.app.appName),
                      onChanged: (bool value) {
                        if ("${Get.find<AppsController>().getPasscode()}" !="") 
                        {
                          appsController.addToLockedApps(widget.app, context);
                        } else {
                          Fluttertoast.showToast(msg: "Please set a password first");
                        }
                      },
                    ),
                    );
                },
                ),
            ],
          ),
        ),
      ),
    );
  }
}

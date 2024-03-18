

import 'package:app_lock_flutter/executables/controllers/password_controller.dart';
import 'package:flutter/material.dart';
import 'package:app_lock_flutter/services/constant.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';

class PinScreen extends StatefulWidget {
  const PinScreen({super.key});

  @override
  State<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
    void initState() {
    super.initState();
    Get.find<PasswordController>().clearData();
  }
  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) async {false;},
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: Scaffold(
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                //Top text
                Align(
                alignment: Alignment.center,
                child: GetBuilder<PasswordController>(builder: (state) {
                  return Text(
                    state.isConfirm ? "Confirm Passcode" : "Set Passcode",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: Colors.white,
                        ),
                  );
                }),
              ),

              const SizedBox(
                height: 10,
              ),

              //Passcode Boxes
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 0; i < 6; i++)
                    GetBuilder<PasswordController>(builder: (state) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 2,
                        ),
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.white24,
                          ),
                          color: Colors.black38,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              state.passcode.length >= i + 1 ? "*" : "",
                              style: MyFont().normaltext(
                                fontsize: 28,
                                color: state.passcode.length >= i + 1
                                    ? Colors.white
                                    : Colors.black54,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                ],
              ),
              const SizedBox(
                height: 10,
              ),

              //Keypad
              Padding(
                padding: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 25,
                ),

                child: GetBuilder<PasswordController>(builder: (state) {
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 12,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 0.0,
                      childAspectRatio: 2,
                      mainAxisSpacing: 10.0,),
                      itemBuilder: (context, index) {
                      if (index == 11){

                        return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: 
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(61, 66, 56, 83),
                            minimumSize: const Size(50, 50),
                          ),
                          onPressed: () {
                            Get.find<PasswordController>().savePasscode();
                          },
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "⇥",
                              style: MyFont().subtitle(
                                fontsize: 20,
                                color:Color.fromARGB(255, 167, 146, 202),
                              ),
                            ),
                          ),),);  
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: 
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(61, 66, 56, 83),
                            minimumSize: const Size(50, 50),
                          ),
                          onPressed: () {
                            state.setPasscode(index);
                          },
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              index != 9 ?
                             "${index == 10 ? 0 : index + 1}": "⌫",
                              style: MyFont().subtitle(
                                fontsize: 20,
                                color:Color.fromARGB(255, 167, 146, 202),
                              ),
                            ),
                          ),),
                      );
                    },
                  );
                  
                }),
              
              ),


              ],)
            ),
            



        ),
      ),
    );
  }
}
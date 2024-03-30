import 'package:app_lock_flutter/models/app_bar.dart';
import 'package:app_lock_flutter/widgets/material_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';

import '../executables/controllers/apps_controller.dart';
import '../services/constant.dart';

class SearchList extends StatefulWidget {
  const SearchList({Key? key}) : super(key: key);

  @override
  State<SearchList> createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  @override
  void dispose() {
    Get.find<AppsController>().searchApkText.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Search"),

      
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 4,
            ),
            child: GetBuilder<AppsController>(builder: (state) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Theme.of(context).primaryColorDark,
                  ),
                ),
                child: TextField(
                  controller: state.searchApkText,
                  onChanged: (value) {
                    state.appSearch();
                  },
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Colors.white,
                      ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 14,
                    ),
                    isCollapsed: true,
                    filled: true,
                    hintText: 'Search apps',
                    hintStyle: Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: Colors.white30,
                        ),
                    prefixIcon: const Padding(
                      padding: EdgeInsets.all(12),
                      child: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              );
            }),
          ),


          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: MySeparator(
              color: Theme.of(context).primaryColor,
              dashWidthget: 3.0,
            ),
          ),

          //Search List
          Expanded(
            child: GetBuilder<AppsController>(
              id: Get.find<AppsController>().appSearchUpdate,
              builder: (state) {
                return ListView.builder(
                  itemCount: state.searchedApps.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: MaterialCardHolder(app: state.searchedApps[index].application!, search:true, state: state, index: index,),
                    );
                  },
                );
              }
              ),
              ),
        ],
      ),
    );
  }
}

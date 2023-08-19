import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:letsgo/Controllers/search_controller.dart';
import 'package:sizer/sizer.dart';

import '../../Utils/pallete.dart';
import '../../Utils/size_controller.dart';
import '../../Widgets/search_result_widget.dart';
import '../../Widgets/search_widget.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  SearchController searchController = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => ListView(physics: const BouncingScrollPhysics(), children: [
          Container(
              height: AppLayout.getScreenHeight(),
              width: AppLayout.getScreenWidth(),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(30.0),
                  topLeft: Radius.circular(30.0),
                ),
                gradient: LinearGradient(
                    colors: [
                      context.theme.colorScheme.background,
                      context.theme.colorScheme.primary,
                    ],
                    begin: FractionalOffset.bottomCenter,
                    end: FractionalOffset.topCenter,
                    tileMode: TileMode.mirror),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 3.h,
                  ),
                  // Text(
                  //   "Search for Places....",
                  //   style: heading3,
                  // ),
                  // SizedBox(
                  //   height: 1.h,
                  // ),
                  Container(
                    width: AppLayout.getScreenWidth(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SearchWidget(
                          hintTitle: 'Search Spot',
                          enable: true,
                        )
                      ],
                    ),
                  ),
                  Container(
                      height: 85.h,
                      width: AppLayout.getScreenWidth(),
                      child: searchController.searchResult.isEmpty
                          ? Center(
                              child: Container(
                                  child: Column(children: [
                                SizedBox(height: AppLayout.getHeight(50)),
                                Image.asset(
                                  'assets/images/nodata.png',
                                  width: AppLayout.getWidth(100),
                                  height: AppLayout.getHeight(100),
                                  fit: BoxFit.fitWidth,
                                ),
                                SizedBox(
                                  height: AppLayout.getHeight(30),
                                ),
                                Text(
                                  "Couldn't find",
                                  style: heading3,
                                ),
                              ])),
                            )
                          : GetBuilder<SearchController>(builder: (context) {
                              return ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount:
                                      searchController.searchResult.length,
                                  itemBuilder: (context, index) {
                                    return Column(children: [
                                      SearchResultWidget(
                                        placeDetail: searchController
                                            .searchResult[index],
                                      )
                                    ]);
                                  });
                            }))
                ],
              )),
        ]),
      ),
      backgroundColor: Colors.transparent,
    );
  }
}

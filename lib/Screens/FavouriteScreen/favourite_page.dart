import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import 'package:letsgo/Controllers/favourite_page_controller.dart';
import 'package:letsgo/Controllers/firebase_controller.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../../Utils/Constants.dart';
import '../../Utils/pallete.dart';
import '../../Utils/size_controller.dart';
import '../../Widgets/CathegoryItem.dart';

import '../../Widgets/cathegory_divider.dart';
import '../../Widgets/loader_widget.dart';

import '../../Widgets/swipecard_widget.dart';

class FavouriteScreen extends StatelessWidget {
  FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FavouritesController favouritesController = Get.put(FavouritesController());
    FirebaseController firebaseController = Get.put(FirebaseController());
    return Scaffold(
      backgroundColor: bgColor,
      body: Obx(() => favouritesController.isLoading.value
          ? const LoaderWidget()
          : Container(
              height: AppLayout.getScreenHeight(),
              width: AppLayout.getScreenWidth(),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      context.theme.colorScheme.background,
                      context.theme.colorScheme.primary,
                    ],
                    begin: FractionalOffset.bottomCenter,
                    end: FractionalOffset.topCenter,
                    tileMode: TileMode.mirror),
              ),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  Container(
                    child: Column(
                      children: [
                        SizedBox(
                          height: AppLayout.getHeight(30),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: AppLayout.getHeight(10),right: AppLayout.getHeight(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Your Favourites",
                                    style: heading5,
                                  ),
                                  SizedBox(
                                    height: AppLayout.getHeight(15),
                                  ),
                                  Text(
                                    "are here.....",
                                    style: heading6,
                                  ),
                                ],
                              ),
                              Container(
                                width: 85,
                                height: 85,
                                margin: EdgeInsets.only(
                                    right: AppLayout.getHeight(15)),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.transparent

                                    ),
                                child: Container(
                                  //    padding: const EdgeInsets.only(right: 5, top: 10, bottom: 10),
                                  margin: EdgeInsets.all(AppLayout.getHeight(2)),
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    color: Colors.transparent,
                                  ),
                                  child: Lottie.asset(
                                    'assets/lottie/favourites.json',
                                    repeat: true,
                                    reverse: true,
                                    animate: true,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: AppLayout.getHeight(40),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: AppLayout.getHeight(10),right: AppLayout.getHeight(10)),
                          child: const CategoryDivider(
                            title: 'Sort your favourites by:',
                          ),
                        ),
                        SizedBox(
                          height: AppLayout.getHeight(10),
                        ),
                        Container(
                          height: AppLayout.getHeight(115),
                          width: AppLayout.getScreenWidth(),
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            children: CATEGORIES
                                .map((category) => CathegoryItem(
                                      category: category,
                                      favouritesPage: true,
                                    ))
                                .toList(),
                          ),
                        ),
                        SizedBox(
                          height: AppLayout.getHeight(20),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: AppLayout.getHeight(10),right: AppLayout.getHeight(10)),
                          child: const CategoryDivider(
                            title: 'Favourites :',
                          ),
                        ),
                        SizedBox(
                          height: AppLayout.getHeight(10),
                        ),
                        Container(
                            height: 80.h,
                            width: double.infinity,
                            color: Colors.transparent,
                            child: favouritesController
                                    .favPlaceDetailList.isEmpty
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
                                        "Favourites is Empty",
                                        style: heading8.copyWith(color: Colors.black),
                                      ),
                                    ])),
                                  ):
                                // :   firebaseController.netWorkStatus.value?

                            GetBuilder<FavouritesController>(
                                    builder: (context) {
                                      return Obx(() => ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          physics:
                                              const BouncingScrollPhysics(),
                                          itemCount:
                                              context.favPlaceDetailList.length,
                                          itemBuilder: (context, index) {
                                            return Row(children: [
                                              // TouristspotRecycler(
                                              //   placeDetail: exploreController
                                              //       .placeDetailList[index],
                                              // )
                                              SwipeCard(
                                                  placeDetail:
                                                      favouritesController
                                                              .favPlaceDetailList[
                                                          index],
                                                  isBottom: false)
                                            ]);
                                          }));
                                    },
                                  )
                            //     :Center(
                            //   child: Container(
                            //       child: Column(children: [
                            //         SizedBox(height: AppLayout.getHeight(50)),
                            //         Image.asset(
                            //           'assets/images/network.png',
                            //           width: AppLayout.getWidth(100),
                            //           height: AppLayout.getHeight(100),
                            //           fit: BoxFit.fitWidth,
                            //         ),
                            //         SizedBox(
                            //           height: AppLayout.getHeight(30),
                            //         ),
                            //         Text(
                            //           "Turn on Internet",
                            //           style: heading8.copyWith(color: Colors.black),
                            //         ),
                            //       ])),
                            // )
    ) ,
                      ],
                    ),
                  ),
                ],
              ),
            )),
    );
  }
}

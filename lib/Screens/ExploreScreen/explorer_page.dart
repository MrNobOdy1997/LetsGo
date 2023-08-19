import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:letsgo/Controllers/explore_page_controller.dart';
import 'package:letsgo/Utils/size_controller.dart';
import 'package:letsgo/Widgets/CathegoryItem.dart';

import 'package:letsgo/Widgets/touristspot_recycler_widget.dart';

import '../../Controllers/maps_controller.dart';
import '../../Utils/Constants.dart';
import '../../Utils/pallete.dart';
import '../../Widgets/cathegory_divider.dart';
import '../../Widgets/loader_widget.dart';
import '../../Widgets/restaurant_item_widget.dart';
import '../../Widgets/search_widget.dart';
import '../../Widgets/text-field-input.dart';
import '../SearchScreen/search_screen.dart';

class ExplorerScreen extends StatelessWidget {
  ExplorerScreen({Key? key}) : super(key: key);
  ExploreController exploreController = Get.put(ExploreController());
  MapController mapController = Get.put(MapController());

  @override
  Widget build(BuildContext context) {
    Orientation currentOrientation = MediaQuery.of(context).orientation;
    return Scaffold(
      body: Obx(() => exploreController.isLoading.value
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
                    width: AppLayout.getScreenWidth(),
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        SizedBox(
                          height: AppLayout.getHeight(40),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: AppLayout.getHeight(10),
                              right: AppLayout.getHeight(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Welcome back...",
                                    style: heading5,
                                  ),
                                  SizedBox(
                                    height: AppLayout.getHeight(15),
                                  ),
                                  Text(
                                    "${exploreController.username}",
                                    style: heading6,
                                  ),
                                ],
                              ),
                              Container(
                                width: 70,
                                height: 70,
                                margin: EdgeInsets.only(
                                    right: AppLayout.getHeight(20)),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: const DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                            "assets/images/letsgo.png"))),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: AppLayout.getHeight(30),
                        ),
                        Container(
                          width: AppLayout.getScreenWidth(),

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                            SearchWidget(
                                      hintTitle: 'Search Spot', enable: false,
                                    )
                              ],
                            ),

                        ),
                        SizedBox(
                          height: AppLayout.getHeight(15),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: AppLayout.getHeight(10),
                              right: AppLayout.getHeight(10)),
                          child: const CategoryDivider(
                            title: 'Sort by :',
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
                                      favouritesPage: false,
                                    ))
                                .toList(),
                          ),
                        ),
                        SizedBox(
                          height: AppLayout.getHeight(20),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: AppLayout.getHeight(10),
                              right: AppLayout.getHeight(10)),
                          child: const CategoryDivider(
                            title: 'Top Attractions :',
                          ),
                        ),
                        SizedBox(
                          height: AppLayout.getHeight(10),
                        ),
                        exploreController.placeDetailList.isEmpty
                            ? const LoaderWidget()
                            : Container(
                                height: AppLayout.getHeight(350),
                                width: AppLayout.getScreenWidth(),
                                child: GetBuilder<ExploreController>(
                                    builder: (context) {
                                  return ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: exploreController
                                          .placeDetailList.length,
                                      itemBuilder: (context, index) {
                                        return Row(children: [
                                          TouristSpotRecycler(
                                            placeDetail: exploreController
                                                .placeDetailList[index],
                                          )
                                        ]);
                                      });
                                })),
                        SizedBox(
                          height: AppLayout.getHeight(20),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: AppLayout.getHeight(10),
                              right: AppLayout.getHeight(10)),
                          child: const CategoryDivider(
                            title: 'Top Restaurants :',
                          ),
                        ),
                        SizedBox(
                          height: AppLayout.getHeight(10),
                        ),
                        exploreController.hotelDetailList.length == 0
                            ? const LoaderWidget()
                            : Container(
                                height: AppLayout.getHeight(280),
                                width: AppLayout.getScreenWidth(),
                                padding: const EdgeInsets.all(2),
                                color: Colors.transparent,
                                child: GetBuilder<ExploreController>(
                                    builder: (context) {
                                  return ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: exploreController
                                          .hotelDetailList.length,
                                      itemBuilder: (context, index) {
                                        return Row(children: [
                                          HospitalityItemWidget(
                                            hotelDetail: exploreController
                                                .hotelDetailList[index],
                                          )
                                        ]);
                                      });
                                })),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      floatingActionButton: SpeedDial(
        backgroundColor: context.theme.colorScheme.surface,
        icon: Icons.map_outlined,
        activeIcon: Icons.close_rounded,
        overlayColor: context.theme.colorScheme.primary,
        overlayOpacity: 0.2,
        children: [
          SpeedDialChild(
              child: Icon(
                Icons.radar_rounded,
                color: context.theme.colorScheme.surface,
              ),
              label: "Places",
              labelStyle: TextStyle(
                  color: context.theme.colorScheme.surface,
                  fontWeight: FontWeight.bold),
              labelBackgroundColor: context.theme.colorScheme.background,
              backgroundColor: context.theme.colorScheme.background,
              onTap: () {
                mapController.plotAllPlaces(exploreController.placeDetailList);
              }),
          SpeedDialChild(
              child: Icon(
                Icons.fastfood_outlined,
                color: context.theme.colorScheme.surface,
              ),
              label: "Restaurants",
              labelStyle: TextStyle(
                  color: context.theme.colorScheme.surface,
                  fontWeight: FontWeight.bold),
              labelBackgroundColor: context.theme.colorScheme.background,
              backgroundColor: context.theme.colorScheme.background,
              onTap: () {
                mapController.plotAllHotels(exploreController.hotelDetailList);
                log("hoteldetailsMap${exploreController.hotelDetailList}");
              }),
        ],
      ),
      backgroundColor: bgColor,
    );
  }
}

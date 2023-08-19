import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:letsgo/Controllers/explore_page_controller.dart';
import 'package:letsgo/Controllers/favourite_page_controller.dart';

import 'package:letsgo/Widgets/swipecard_widget.dart';
import 'package:swipe_cards/swipe_cards.dart';

import '../Utils/size_controller.dart';
import 'loader_widget.dart';

class FilterScreenResult extends StatelessWidget {
  FilterScreenResult({Key? key, required this.favourites}) : super(key: key);
  final bool favourites;
  late ExploreController exploreController;

  late FavouritesController favouritesController;

  @override
  Widget build(BuildContext context) {
    if (favourites == true) {
      favouritesController = Get.put(FavouritesController());
    } else {
      exploreController = Get.put(ExploreController());
    }

    return Container(
        child: Obx(() => favourites == true
            ? favouritesController.isFiltering.value
                ? const LoaderWidget()
                : GetBuilder<FavouritesController>(builder: (context) {
                    return SwipeCards(
                        matchEngine: context.matchEngine,
                        onStackFinished: () {},
                        upSwipeAllowed: true,
                        itemBuilder: (BuildContext context, int index) {
                          return SwipeCard(
                            placeDetail:
                                favouritesController.filterFavDetailList[index],
                            isBottom: true,
                          );
                        });
                  })
            : exploreController.isFiltering.value
                ? const LoaderWidget()
                : GetBuilder<ExploreController>(builder: (context) {
                    return SwipeCards(
                        matchEngine: exploreController.matchEngine,
                        onStackFinished: () {
                          log("Data finished");
                          AppLayout.customToast("data finished");

                          // exploreController.addSwipeItem()
                        },
                        upSwipeAllowed: true,
                        itemBuilder: (BuildContext context, int index) {
                          return SwipeCard(
                            placeDetail:
                                exploreController.filterDetailList[index],
                            isBottom: true,
                          );
                        });
                  })),
    );
  }
}

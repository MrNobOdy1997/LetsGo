import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:letsgo/Controllers/favourite_page_controller.dart';
import 'package:letsgo/Controllers/firebase_controller.dart';
import 'package:letsgo/Models/place_details_model.dart';
import 'package:letsgo/Utils/pallete.dart';

import '../Screens/DetailedViewScreen/place_detailed_view.dart';
import '../Utils/size_controller.dart';
import 'image_loader_widget.dart';

class TouristSpotRecycler extends StatelessWidget {
  TouristSpotRecycler({Key? key, required this.placeDetail}) : super(key: key);
  final PlaceDetails placeDetail;

  FavouritesController favouritesController = Get.put(FavouritesController());
  FirebaseController firebaseController = Get.put(FirebaseController());

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => DetailedViewScreen(
              details: placeDetail,
            ));
      },
      child: Container(
        width: AppLayout.getWidth(225),
        height: AppLayout.getHeight(330),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        margin: const EdgeInsets.only(right: 8, top: 5, left: 8),
        decoration: BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.circular(10),
border: Border.all(color: context.theme.colorScheme.surface),
            boxShadow:  [
              BoxShadow(color: context.theme.colorScheme.secondary, blurRadius: 2, spreadRadius: 1)
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: AppLayout.getHeight(210),
              width: AppLayout.getWidth(205),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: kWhite,
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: .8,
                      spreadRadius: 1, //New
                    )
                  ]),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                child: CachedNetworkImage(
                  width: AppLayout.getHeight(175),
                  height: AppLayout.getHeight(200),
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const ImageLoader(),
                  imageUrl: placeDetail.placeImages[0],
                ),
              ),
            ),
            SizedBox(
              height: AppLayout.getHeight(15),
            ),
            RichText(
                text: TextSpan(children: [
              WidgetSpan(
                  child: Icon(
                Icons.radar_sharp,
                color: Colors.red.shade500,
                size: 18,
              )),
              const TextSpan(
                text: "  ",
              ),
              TextSpan(
                  text: placeDetail.placeName,
                  style: heading2.copyWith(color: firebaseNavy))
            ])),
            SizedBox(
              height: AppLayout.getHeight(2),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                    text: TextSpan(children: [
                  WidgetSpan(
                      child: Icon(
                    Icons.location_on,
                    color: Colors.green.shade300,
                    size: 18,
                  )),
                  const TextSpan(
                    text: "  ",
                  ),
                  TextSpan(
                      text: placeDetail.placeDistrict,
                      style: heading2.copyWith(color: firebaseNavy))
                ])),
                Container(
                    margin: EdgeInsets.only(
                        left: AppLayout.getHeight(5),
                        right: AppLayout.getHeight(5),
                        bottom: AppLayout.getHeight(5)),
                    height: AppLayout.getHeight(40),
                    width: AppLayout.getWidth(40),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: context.theme.colorScheme.surface),
                      boxShadow:  [
                        BoxShadow(
                          color: context.theme.colorScheme.secondary,
                          blurRadius: 1.0,
                          spreadRadius: 1, //New
                        )
                      ],
                    ),
                    child: ClipOval(
                      child: Material(
                        color: Colors.white, // Button color
                        child: InkWell(
                            splashColor: Colors.orange.shade300, // Splash color
                            onTap: () {
                              if (firebaseController.favSpot
                                  .contains(placeDetail.placeId)) {
                                favouritesController
                                    .removeFromFav(placeDetail.placeId);
                              } else {
                                favouritesController.addToFav(placeDetail);
                              }
                            },
                            child: SizedBox(
                              width: AppLayout.getHeight(95),
                              height: AppLayout.getHeight(95),
                              child: Obx(() => Icon(
                                  firebaseController.favSpot.value
                                          .contains(placeDetail.placeId)
                                      ? FluentSystemIcons.ic_fluent_heart_filled
                                      : FluentSystemIcons
                                          .ic_fluent_heart_regular,
                                  color: Colors.redAccent.shade200)),
                            )),
                      ),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

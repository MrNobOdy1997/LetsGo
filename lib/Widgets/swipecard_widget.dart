import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:letsgo/Controllers/favourite_page_controller.dart';
import 'package:letsgo/Controllers/maps_controller.dart';
import 'package:letsgo/Models/place_details_model.dart';
import 'package:letsgo/Utils/size_controller.dart';
import 'package:sizer/sizer.dart';
import '../Controllers/firebase_controller.dart';
import '../Screens/DetailedViewScreen/place_detailed_view.dart';
import 'Custom_label_widget.dart';
import 'image_loader_widget.dart';

class SwipeCard extends StatelessWidget {
  SwipeCard({Key? key, required this.placeDetail, required this.isBottom})
      : super(key: key);
  final PlaceDetails placeDetail;
  final bool isBottom;
  final FavouritesController favouritesController =
      Get.put(FavouritesController());
  FirebaseController firebaseController = Get.put(FirebaseController());
  MapController mapController = Get.put(MapController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:isBottom? EdgeInsets.all(2.2.h):EdgeInsets.all(2.h),
      child: InkWell(
        onTap: () {
          Get.to(() => DetailedViewScreen(
                details: placeDetail,
              ));
        },
        child: Container(
          // width: 100.w,
           //height: isBottom == true?40.h:80.h,

          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: context.theme.colorScheme.background,
                blurRadius: 1,
                spreadRadius: 1, //New
              )
            ],
            border: Border.all(color: context.theme.colorScheme.surface),
            borderRadius: BorderRadius.circular(15),
            shape: BoxShape.rectangle,
          ),
          child: Column(
            children: [
           Container(
                  // height: isBottom == true
                  //     ? 37.h
                  //     : 40.h,
                  margin: EdgeInsets.all(2.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      boxShadow: [
                        BoxShadow(
                          color: context.theme.colorScheme.secondary,
                          blurRadius: .8,
                          spreadRadius: 1, //New
                        )
                      ]),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(1),
                    ),
                    child: CachedNetworkImage(
                      width: isBottom == true
                          ? 95.w
                          : 90.w,
                      height: isBottom == true
                          ? 35.h
                          : 60.h,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const ImageLoader(),
                      imageUrl: placeDetail.placeImages[0],
                    ),
                  ),
                ),

              Container(
                 width:90.w,
                padding:
                EdgeInsets.only(left: 3.w,right: 3.w,top: 2.w, ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        height: 5.h,
                        width: 10.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                              color: context.theme.colorScheme.surface),
                          boxShadow: [
                            BoxShadow(
                              color: context.theme.colorScheme.secondary,
                              blurRadius: 3.0,
                              spreadRadius: 1, //New
                            )
                          ],
                        ),
                        child: ClipOval(
                          child: Material(
                            color: Colors.white, // Button color
                            child: InkWell(
                              splashColor: Colors.amberAccent.shade200,
                              // Splash color
                              onTap: () {
                                var geopoint = placeDetail.placeGeopoints;
                                mapController.loadData(
                                    geopoint,
                                    placeDetail.placeId,
                                    true,
                                    placeDetail.placeName);

                                AppLayout.customToast(
                                    "Geopoints :  ${geopoint.latitude}");
                              },
                              child: SizedBox(
                                  width: AppLayout.getWidth(90),
                                  height: AppLayout.getHeight(90),
                                  child: Icon(
                                      FluentSystemIcons
                                          .ic_fluent_location_regular,
                                      color: Colors.green.shade800)),
                            ),
                          ),
                        )),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomLabel(
                            placeName: placeDetail.placeName,
                            placeDistrict: placeDetail.placeDistrict),
                      ],
                    ),
                    Container(
                        height: 5.h,
                        width: 10.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                              color: context.theme.colorScheme.surface),
                          boxShadow: [
                            BoxShadow(
                              color: context.theme.colorScheme.secondary,
                              blurRadius: 3.0,
                              spreadRadius: 1, //New
                            )
                          ],
                        ),
                        child: ClipOval(
                          child: Material(
                            color: Colors.white, // Button color
                            child: InkWell(
                              splashColor: Colors.amberAccent.shade200,
                              // Splash color
                              onTap: () {
                                if (firebaseController.favSpot
                                    .contains(placeDetail.placeId)) {
                                  // firebaseController.removeFavFromDB(placeDetail.placeId);
                                  favouritesController
                                      .removeFromFav(placeDetail.placeId);
                                } else {
                                  favouritesController.addToFav(placeDetail);
                                }
                              },
                              child: SizedBox(
                                  width: AppLayout.getWidth(80),
                                  height: AppLayout.getHeight(90),
                                  child: Obx(() => Icon(
                                      firebaseController.favSpot.value
                                              .contains(placeDetail.placeId)
                                          ? FluentSystemIcons
                                              .ic_fluent_heart_filled
                                          : FluentSystemIcons
                                              .ic_fluent_heart_regular,
                                      color: Colors.redAccent.shade200))),
                            ),
                          ),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

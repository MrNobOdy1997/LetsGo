import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:letsgo/Controllers/firebase_controller.dart';
import 'package:sizer/sizer.dart';

import '../../Controllers/detail_view_controller.dart';
import '../../Controllers/maps_controller.dart';
import '../../Models/place_details_model.dart';
import '../../Utils/pallete.dart';
import '../../Utils/size_controller.dart';
import '../../Widgets/app_bar_widget.dart';
import '../../Widgets/image_loader_widget.dart';
import '../../Widgets/restaurant_item_widget.dart';

class DetailedViewScreen extends StatelessWidget {
  DetailedViewScreen({Key? key, required this.details}) : super(key: key);
  final PlaceDetails details;

  @override
  Widget build(BuildContext context) {
    MapController mapController = Get.put(MapController());
    DetailedViewController detailedViewController =
        Get.put(DetailedViewController());
    FirebaseController firebaseController = Get.put(FirebaseController());
    // return Scaffold(
    //   appBar: AppBarWidget(
    //     height: AppLayout.getHeight(100),
    //     headline: details.placeName,
    //   ),
    //   body: Container(
    //     color:context.theme.colorScheme.background ,
    //     child: Column(
    //       children: [
    //         Stack(
    //           children: [
    //             Container(
    //               height: AppLayout.getHeight(625),
    //               width: AppLayout.getWidth(382),
    //               decoration:  BoxDecoration(
    //
    //                 borderRadius: BorderRadius.circular(20),
    //               ),
    //               margin: EdgeInsets.only(
    //                 left: AppLayout.getHeight(15),
    //                 right: AppLayout.getHeight(8),),
    //               child: ClipRRect(
    //                 borderRadius: BorderRadius.circular(20),
    //
    //                 child: Builder(
    //                   builder: (context) {
    //                     final double height = MediaQuery.of(context).size.height;
    //                     return CarouselSlider(
    //                       options: CarouselOptions(
    //                         height: height,
    //                         viewportFraction: 1.0,
    //                         enlargeCenterPage: true,
    //                       ),
    //                       items: details.placeImages
    //                           .map((item) => Center(
    //                           child: CachedNetworkImage(
    //                             width: AppLayout.getWidth(380),
    //                             height: AppLayout.getHeight(625),
    //                             fit: BoxFit.cover,
    //                             filterQuality: FilterQuality.medium,
    //                             alignment: Alignment.center,
    //                             placeholder: (context, url) => const ImageLoader(),
    //                             imageUrl: item,
    //                           )))
    //                           .toList(),
    //                     );
    //                   },
    //                 ),
    //               ),
    //             ),
    //             Container(
    //               height: AppLayout.getHeight(200),
    //               width: AppLayout.getWidth(380),
    //               margin: EdgeInsets.only(top: AppLayout.getHeight(425),left: AppLayout.getHeight(15),right: AppLayout.getHeight(8)),
    //               decoration:  BoxDecoration(
    //                   borderRadius: BorderRadius.circular(20),
    //                   gradient: const LinearGradient(colors: [Colors.transparent,Colors.black],begin:Alignment.topCenter ,end:Alignment.bottomCenter ,stops:[.05,1] )
    //               ),
    //             ),
    //             Container(
    //               height: AppLayout.getHeight(180),
    //               width: AppLayout.getWidth(400),
    //
    //               margin: EdgeInsets.only(top: AppLayout.getHeight(425),left: AppLayout.getHeight(20),right: AppLayout.getHeight(20)),
    //               child: Column(
    //                 mainAxisSize: MainAxisSize.min,
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   const Expanded(child: Center()),
    //                   SizedBox(height: AppLayout.getHeight(5)),
    //                   Row(
    //                     children: [
    //                       Text(
    //                         details.placeName,
    //                         style: const TextStyle(
    //                             fontFamily: "BerkshireSwash",
    //                             color: Colors.white,
    //                             fontSize: 28,
    //                             fontWeight: FontWeight.bold),
    //                       ),
    //                       SizedBox(width: AppLayout.getWidth(10)),
    //                       InkWell(
    //                         onTap: (){
    //                           detailedViewController.getHotelDetails(details.placeDistrict);
    //                           Get.bottomSheet(
    //                               Column(
    //                                 children: [
    //                                   SizedBox(height: AppLayout.getHeight(30),),
    //                                   Text(
    //                                     "Nearby Restaurants",
    //                                     style: heading3,
    //                                   ),
    //                                   SizedBox(height: AppLayout.getHeight(10),),
    //                                   Container(
    //                                       height: AppLayout.getHeight(280),
    //                                       width: AppLayout.getScreenWidth(),
    //                                       padding: const EdgeInsets.all(2),
    //                                       color: Colors.transparent,
    //                                       child: GetBuilder<DetailedViewController>(
    //                                           builder: (context) {
    //                                             return ListView.builder(
    //                                                 scrollDirection: Axis.horizontal,
    //                                                 physics: const BouncingScrollPhysics(),
    //                                                 itemCount:
    //                                                 detailedViewController.hotelDetailList.length,
    //                                                 itemBuilder: (context, index) {
    //                                                   return Row(children: [
    //
    //                                                     HospitalityItemWidget(
    //                                                       hotelDetail: detailedViewController
    //                                                           .hotelDetailList[index],
    //                                                     )
    //                                                   ]);
    //                                                 });
    //                                           })
    //                                   ),
    //                                 ],
    //                               ),
    //
    //                             backgroundColor: Colors.white.withOpacity(1.0),
    //                             shape: RoundedRectangleBorder(
    //                               borderRadius: BorderRadius.circular(25),
    //                             ),
    //                           );
    //
    //                         },
    //                         child: Container(
    //                           width: 30,
    //                           height: 30,
    //                           margin: EdgeInsets.only(right: AppLayout.getHeight(20)),
    //                           decoration: BoxDecoration(
    //                               borderRadius: BorderRadius.circular(10),
    //                               image: const DecorationImage(
    //                                   fit: BoxFit.cover,
    //                                   image: AssetImage(
    //                                       "assets/images/restaurantmarker.png"))),
    //                         ),
    //                       )
    //
    //                     ],
    //                   ),
    //                   SizedBox(height: AppLayout.getHeight(10)),
    //                   Container(
    //                     height: AppLayout.getHeight(80),
    //                     width: AppLayout.getScreenWidth(),
    //
    //                     child: SingleChildScrollView(
    //                       child: Text(details.placeDescription,
    //                           style:heading7.copyWith(color: Colors.white)),
    //                     ),
    //                   ),
    //
    //
    //                 ],
    //               ),
    //             ),
    //
    //           ],
    //
    //
    //         ),
    //         Container(
    //           margin: EdgeInsets.only(top: AppLayout.getHeight(12)),
    //           padding: EdgeInsets.only(left: AppLayout.getHeight(25),right: AppLayout.getHeight(25)),
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               Container(
    //                   margin:  EdgeInsets.only(left: AppLayout.getHeight(20), right: AppLayout.getHeight(2),bottom: AppLayout.getHeight(10)),
    //                   height: AppLayout.getHeight(55),
    //                   width: AppLayout.getWidth(55),
    //                   decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.circular(50),
    //                     border: Border.all(color: context.theme.colorScheme.surface),
    //                     boxShadow:  [
    //                       BoxShadow(
    //                         color: context.theme.colorScheme.secondary,
    //                         blurRadius: 3.0,
    //                         spreadRadius: 1, //New
    //                       )
    //                     ],
    //                   ),
    //                   child: ClipOval(
    //                     child: Material(
    //                       color: context.theme.colorScheme.background, // Button color
    //                       child: InkWell(
    //                         splashColor: Colors.amber.shade300, // Splash color
    //                         onTap: () {
    //                           detailedViewController.textToSpeech(details.placeDescription);
    //                         },
    //                         child: SizedBox(
    //                           width:  AppLayout.getHeight(90),
    //                           height:  AppLayout.getHeight(90),
    //                           child: Icon(FluentSystemIcons.ic_fluent_speaker_1_regular,
    //                               color: Colors.blueGrey.shade500),),
    //                       ),
    //                     ),
    //                   )),
    //               Container(
    //                   margin:  EdgeInsets.only(bottom: AppLayout.getHeight(10)),
    //                   height: AppLayout.getHeight(75),
    //                   width: AppLayout.getWidth(75),
    //                   decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.circular(50),
    //                     border: Border.all(color: context.theme.colorScheme.surface),
    //                     boxShadow:  [
    //                       BoxShadow(
    //                         color: context.theme.colorScheme.secondary,
    //                         blurRadius: 3.0,
    //                         spreadRadius: 1, //New
    //                       )
    //                     ],
    //                   ),
    //                   child: ClipOval(
    //                     child: Material(
    //                       color: context.theme.colorScheme.background, // Button color
    //                       child: InkWell(
    //                         splashColor: Colors.amber.shade300, // Splash color
    //                         onTap: () {
    //                           if(firebaseController.favSpot.contains(details.placeId)){
    //                             firebaseController.removeFavFromDB(details.placeId);
    //                           }
    //                           else{
    //                             firebaseController.addFavToDB(details.placeId);
    //                           }
    //
    //                         },
    //                         child: SizedBox(
    //                           width:  AppLayout.getHeight(95),
    //                           height:  AppLayout.getHeight(95),
    //                           child: Obx(()=>Icon(firebaseController.favSpot.value.contains(details.placeId)?
    //                           FluentSystemIcons.ic_fluent_heart_filled:FluentSystemIcons.ic_fluent_heart_regular,
    //                               color: Colors.redAccent.shade200)),),
    //                       ),
    //                     ),
    //                   )),
    //               Container(
    //                   margin:  EdgeInsets.only(left:  AppLayout.getHeight(2), right:  AppLayout.getHeight(20),bottom: AppLayout.getHeight(10)),
    //                   height: AppLayout.getHeight(55),
    //                   width: AppLayout.getWidth(55),
    //                   decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.circular(50),
    //                     border: Border.all(color: context.theme.colorScheme.surface),
    //                     boxShadow:  [
    //                       BoxShadow(
    //                         color: context.theme.colorScheme.secondary,
    //                         blurRadius: 3.0,
    //                         spreadRadius: 1, //New
    //                       )
    //                     ],
    //                   ),
    //                   child: ClipOval(
    //                     child: Material(
    //                       color: context.theme.colorScheme.background, // Button color
    //                       child: InkWell(
    //                         splashColor: Colors.amber.shade300, // Splash color
    //                         onTap: () {
    //                           var geopoint = details.placeGeopoints;
    //                           mapController.loadData(geopoint,details.placeId,true,details.placeName);
    //
    //                           AppLayout.customToast(
    //
    //                               "Geopoints :  ${geopoint.latitude}");
    //
    //                         },
    //                         child: SizedBox(
    //                           width:  AppLayout.getHeight(85),
    //                           height:  AppLayout.getHeight(85),
    //                           child: Icon(FluentSystemIcons.ic_fluent_location_regular,
    //                               color: Colors.green.shade800),),
    //                       ),
    //                     ),
    //                   ))
    //             ],
    //           ),
    //         ),
    //
    //       ],
    //     ),
    //   ),
    // );

    return Scaffold(
      appBar: AppBarWidget(
        height: AppLayout.getHeight(120),
        headline: details.placeName,
        districtName: details.placeDistrict,
      ),
      body: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
        Container(
          // color:context.theme.colorScheme.background ,
          margin: EdgeInsets.all(AppLayout.getHeight(5)),
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
                height: AppLayout.getHeight(400),
                width: AppLayout.getWidth(382),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: EdgeInsets.only(
                  top: AppLayout.getHeight(10),
                  left: AppLayout.getHeight(8),
                  right: AppLayout.getHeight(8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Builder(
                    builder: (context) {
                      final double height = MediaQuery.of(context).size.height;
                      return CarouselSlider(
                        options: CarouselOptions(
                          height: AppLayout.getHeight(400),
                          viewportFraction: 1.0,
                          enlargeCenterPage: true,
                        ),
                        items: details.placeImages
                            .map((item) => Center(
                                    child: CachedNetworkImage(
                                  width: AppLayout.getWidth(380),
                                  height: AppLayout.getHeight(625),
                                  fit: BoxFit.cover,
                                  filterQuality: FilterQuality.medium,
                                  alignment: Alignment.center,
                                  placeholder: (context, url) =>
                                      const ImageLoader(),
                                  imageUrl: item,
                                )))
                            .toList(),
                      );
                    },
                  ),
                ),
              ),
              Container(
                height: AppLayout.getHeight(180),
                width: AppLayout.getWidth(400),
                margin: EdgeInsets.only(
                    top: AppLayout.getHeight(15),
                    left: AppLayout.getHeight(20),
                    right: AppLayout.getHeight(10)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: AppLayout.getHeight(170),
                      width: AppLayout.getWidth(550),
                      child: SingleChildScrollView(
                        child: Text(details.placeDescription,
                            style: heading2.copyWith(fontSize:11.sp,color: Colors.black54)),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    left: AppLayout.getHeight(25),
                    right: AppLayout.getHeight(25)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        margin: EdgeInsets.only(
                            left: AppLayout.getHeight(20),
                            right: AppLayout.getHeight(2),
                            bottom: AppLayout.getHeight(10)),
                        height: AppLayout.getHeight(55),
                        width: AppLayout.getWidth(55),
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
                            color: context.theme.colorScheme.background,
                            // Button color
                            child: InkWell(
                              splashColor: Colors.amber.shade300,
                              // Splash color
                              onTap: () {
                                detailedViewController
                                    .textToSpeech(details.placeDescription);
                              },
                              child: SizedBox(
                                width: AppLayout.getHeight(90),
                                height: AppLayout.getHeight(90),
                                child: Icon(
                                    FluentSystemIcons
                                        .ic_fluent_speaker_1_regular,
                                    color: Colors.blueGrey.shade500),
                              ),
                            ),
                          ),
                        )),
                    Container(
                        margin:
                            EdgeInsets.only(bottom: AppLayout.getHeight(10)),
                        height: AppLayout.getHeight(75),
                        width: AppLayout.getWidth(75),
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
                            color: context.theme.colorScheme.background,
                            // Button color
                            child: InkWell(
                              splashColor: Colors.amber.shade300,
                              // Splash color
                              onTap: () {

                                if(firebaseController.netWorkStatus.value){
                                  if (firebaseController.favSpot
                                      .contains(details.placeId)) {
                                    firebaseController
                                        .removeFavFromDB(details.placeId);
                                  } else {
                                    firebaseController
                                        .addFavToDB(details.placeId);
                                  }
                                }
                                else{
                                  AppLayout.customToast("Please turn on your internet");
                                }



                              },
                              child: SizedBox(
                                width: AppLayout.getHeight(95),
                                height: AppLayout.getHeight(95),
                                child: Obx(() => Icon(
                                    firebaseController.favSpot.value
                                            .contains(details.placeId)
                                        ? FluentSystemIcons
                                            .ic_fluent_heart_filled
                                        : FluentSystemIcons
                                            .ic_fluent_heart_regular,
                                    color: Colors.redAccent.shade200)),
                              ),
                            ),
                          ),
                        )),
                    Container(
                        margin: EdgeInsets.only(
                            left: AppLayout.getHeight(2),
                            right: AppLayout.getHeight(20),
                            bottom: AppLayout.getHeight(10)),
                        height: AppLayout.getHeight(55),
                        width: AppLayout.getWidth(55),
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
                            color: context.theme.colorScheme.background,
                            // Button color
                            child: InkWell(
                              splashColor: Colors.amber.shade300,
                              // Splash color
                              onTap: () {
                                var geopoint = details.placeGeopoints;
                                mapController.loadData(geopoint,
                                    details.placeId, true, details.placeName);

                                AppLayout.customToast(
                                    "Geopoints :  ${geopoint.latitude}");
                              },
                              child: SizedBox(
                                width: AppLayout.getHeight(85),
                                height: AppLayout.getHeight(85),
                                child: Icon(
                                    FluentSystemIcons
                                        .ic_fluent_location_regular,
                                    color: Colors.green.shade800),
                              ),
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
      backgroundColor: context.theme.colorScheme.background,
    );
  }
}

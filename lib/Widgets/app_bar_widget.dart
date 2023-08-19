import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:letsgo/Widgets/restaurant_item_widget.dart';
import 'package:sizer/sizer.dart';

import '../Controllers/detail_view_controller.dart';
import '../Controllers/firebase_controller.dart';
import '../Utils/pallete.dart';
import '../Utils/size_controller.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final String districtName;
  final String headline;

  const AppBarWidget({
    Key? key,
    required this.height,
    required this.headline,
    required this.districtName,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(height);

  get color => null;

  @override
  Widget build(BuildContext context) {
    DetailedViewController detailedViewController =
        Get.put(DetailedViewController());
    FirebaseController firebaseController = Get.put(FirebaseController());
    return Container(
      height: preferredSize.height + 20,
      width: AppLayout.getScreenWidth(),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              context.theme.colorScheme.background,
              context.theme.colorScheme.primary,
            ],
            begin: FractionalOffset.bottomCenter,
            end: FractionalOffset.topCenter,
            tileMode: TileMode.decal),
      ),
      child: Padding(
        padding: EdgeInsets.only(
            left: AppLayout.getHeight(5),
            right: AppLayout.getHeight(5),
            bottom: AppLayout.getHeight(2),
            top: AppLayout.getHeight(30)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: AppLayout.getWidth(55),
              height: AppLayout.getHeight(55),
              margin: EdgeInsets.only(
                  top: AppLayout.getHeight(10), left: AppLayout.getHeight(10)),
              //   margin: const EdgeInsets.only(top: 10,bottom: 700),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/letsgo.png"))),
            ),
            Row(
              children: [
                Container(
                  width: AppLayout.getWidth(200),
                  height: AppLayout.getHeight(100),
                  margin: EdgeInsets.only(
                      top: AppLayout.getHeight(40),
                      right: AppLayout.getHeight(5),
                      left: AppLayout.getHeight(5)),
                  child: Text(
                    headline,
                    style: const TextStyle(
                        fontFamily: "BerkshireSwash",
                        color: blackshade,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                InkWell(
                  onTap: () {
                    detailedViewController.getHotelDetails(districtName);
                    Get.bottomSheet(
                      Column(
                        children: [
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            "Nearby Restaurants",
                            style: heading3,
                          ),
                          SizedBox(
                            height: 1.w,
                          ),
                          Container(
                              height: AppLayout.getHeight(250),
                              width: AppLayout.getScreenWidth(),
                              padding: const EdgeInsets.all(2),
                              color: Colors.transparent,
                              child:firebaseController.netWorkStatus.value ?

                              GetBuilder<DetailedViewController>(
                                  builder: (context) {
                                    return ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        physics: const BouncingScrollPhysics(),
                                        itemCount: detailedViewController
                                            .hotelDetailList.length,
                                        itemBuilder: (context, index) {
                                          return Row(children: [
                                            HospitalityItemWidget(
                                              hotelDetail: detailedViewController
                                                  .hotelDetailList[index],
                                            )
                                          ]);
                                        });
                                  }): Center(
                                child: Container(
                                    child: Column(children: [
                                      SizedBox(height: AppLayout.getHeight(50)),
                                      Image.asset(
                                        'assets/images/network.png',
                                        width: AppLayout.getWidth(100),
                                        height: AppLayout.getHeight(100),
                                        fit: BoxFit.fitWidth,
                                      ),
                                      SizedBox(
                                        height: AppLayout.getHeight(30),
                                      ),
                                      Text(
                                        "Turn on Internet",
                                        style: heading8.copyWith(color: Colors.black),
                                      ),
                                    ])),
                              ) ),
                        ],
                      ),
                      backgroundColor: Colors.white.withOpacity(1.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    );
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    // margin: EdgeInsets.only(right: AppLayout.getHeight(20)),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                            fit: BoxFit.cover,
                            image:
                            AssetImage("assets/images/restaurantmarker.png"))),
                  ),
                )
              ],
            ),

          ],
        ),
      ),
    );
  }
}

// Padding(
// padding: EdgeInsets.all(AppLayout.getHeight(25)),
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Container(
// width: AppLayout.getWidth(70),
// height: AppLayout.getHeight(70),
// margin: const EdgeInsets.only(top: 10,left: 15,right: 15),
// //   margin: const EdgeInsets.only(top: 10,bottom: 700),
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(10),
// image: const DecorationImage(
// fit: BoxFit.cover,
// image: AssetImage(
// "assets/images/letsgo.png"))),
// ),
// Container(
// width: AppLayout.getWidth(150),
// height: AppLayout.getHeight(50),
// margin: const EdgeInsets.only(top: 15,left: 10,right: 70),
// child:
// Text(
// details.placeName,
// style: const TextStyle(
// fontFamily: "BerkshireSwash",
// color: blackshade,
// fontSize: 30,
// fontWeight: FontWeight.bold),
// ),
//
// ),
//
// ],
// ),
// ),

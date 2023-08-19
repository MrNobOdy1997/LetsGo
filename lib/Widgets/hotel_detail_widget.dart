import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Controllers/maps_controller.dart';
import '../Models/hospitality_detail_model.dart';
import '../Utils/pallete.dart';
import '../Utils/size_controller.dart';
import 'image_loader_widget.dart';

class HotelDetailView extends StatelessWidget {
  const HotelDetailView({Key? key, required this.hotelDetail})
      : super(key: key);

  final HospitalityDetails hotelDetail;

  @override
  Widget build(BuildContext context) {
    MapController mapController = Get.put(MapController());
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      width: 50.w,
      height: 35.h,
      padding:  EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.w),
      margin:  EdgeInsets.only(right: .2.w, top: 5, left: .2.w),
      decoration: BoxDecoration(
          color: context.theme.colorScheme.background,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: context.theme.colorScheme.secondary,
                blurRadius: 2,
                spreadRadius: 1)
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(children: [
            Container(
              height: 22.h,
              width: 50.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: context.theme.colorScheme.primary,
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
                  imageUrl: hotelDetail.providerimages[0],
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.only(left: 1.h,top: 1.h),
                child: Container(
                  height: 3.h,
                  width: 3.h,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    child: Material(
                      color: context.theme.colorScheme.background,
                      child: Icon(
                        Icons.radio_button_on_sharp,
                        color: hotelDetail.vegeterian == true
                            ? Colors.green
                            : Colors.brown,
                        size: 20,
                      ),
                    ),
                  ),
                )),
            Container(
              margin: EdgeInsets.only(top: 17.h),
              padding: EdgeInsets.all(1.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: AppLayout.getHeight(30),
                    width: AppLayout.getWidth(55),
                    padding: EdgeInsets.all(AppLayout.getHeight(5)),
                    decoration: BoxDecoration(
                      color: context.theme.colorScheme.background,
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                    ),
                    child: RichText(
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(children: [
                        const WidgetSpan(
                            child: Icon(
                          Icons.star,
                          color: Colors.orange,
                          size: 15,
                        )),
                        const TextSpan(
                          text: " ",
                        ),
                        TextSpan(
                            text: hotelDetail.providerrateing,
                            style: textTheme.subtitle2!.apply(fontSizeDelta: 2))
                      ]),
                    ),
                  ),
                  Container(
                    height: AppLayout.getHeight(30),
                    width: AppLayout.getWidth(30),
                    decoration: BoxDecoration(
                      color: context.theme.colorScheme.background,
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      child: Material(
                        color: Colors.white.withOpacity(0.8),
                        child: InkWell(
                            splashColor: Colors.orange.shade300, // Splash color
                            onTap: () {
                              var geopoint = hotelDetail.providerlocation;
                              mapController.loadData(
                                  geopoint, hotelDetail.providerid, false,hotelDetail.providername);
                            },
                            child: SizedBox(
                              width: AppLayout.getHeight(5),
                              height: AppLayout.getHeight(5),
                              child: Icon(
                                  FluentSystemIcons.ic_fluent_map_regular,
                                  color: Colors.redAccent.shade200),
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ]),
          SizedBox(
            height: AppLayout.getHeight(10),
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
                text: hotelDetail.providername,
                style: heading4.copyWith(color: firebaseNavy))
          ])),
          SizedBox(
            height:.5.w,
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
                    text: hotelDetail.providergeolocation,
                    style: heading1.copyWith(color: firebaseNavy))
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
                    boxShadow: [
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
                            var url =
                                Uri.parse("tel:${hotelDetail.providerphone}");

                            launchUrl(url);
                          },
                          child: SizedBox(
                            width: AppLayout.getHeight(95),
                            height: AppLayout.getHeight(95),
                            child: Icon(
                                FluentSystemIcons.ic_fluent_call_add_regular,
                                color: Colors.blue.shade500),
                          )),
                    ),
                  ))
            ],
          ),
          SizedBox(
            height: .5.w,
          ),
          Row(
            children: [
              RichText(
                overflow: TextOverflow.ellipsis,
                text: TextSpan(children: [
                  const WidgetSpan(
                      child: Icon(
                    FluentSystemIcons.ic_fluent_mail_filled,
                    color: Colors.orange,
                    size: 15,
                  )),
                  const TextSpan(
                    text: "   ",
                  ),
                  TextSpan(text: hotelDetail.providermail, style: heading9)
                ]),
              ),
            ],
          )
        ],
      ),
    );
  }
}

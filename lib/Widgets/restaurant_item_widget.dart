import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:letsgo/Models/hospitality_detail_model.dart';
import '../Utils/pallete.dart';
import '../Utils/size_controller.dart';

import 'hotel_detail_widget.dart';
import 'image_loader_widget.dart';

class HospitalityItemWidget extends StatelessWidget {
  const HospitalityItemWidget({Key? key, required this.hotelDetail});

  final HospitalityDetails hotelDetail;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: () {
        Get.defaultDialog(
          backgroundColor: Colors.transparent,
          titleStyle: const TextStyle(color: Colors.transparent),
          middleTextStyle: const TextStyle(color: Colors.transparent),
          content: HotelDetailView(
            hotelDetail: hotelDetail,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(right: 2, top: 5, left: 4),
        width: AppLayout.getWidth(195),
        height: AppLayout.getHeight(250),
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  flex: 6,
                  child: Container(),
                ),
                Expanded(
                  flex: 7,
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                            color: context.theme.colorScheme.surface),
                        color: kWhite,
                        boxShadow: [
                          BoxShadow(
                            color: context.theme.colorScheme.secondary,
                            blurRadius: 2,
                            spreadRadius: 1, //New
                          )
                        ]),
                  ),
                )
              ],
            ),
            Padding(
                padding: EdgeInsets.all(AppLayout.getHeight(15)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30)),
                            border: Border.all(
                                color: context.theme.colorScheme.surface),
                            boxShadow: [
                              BoxShadow(
                                color: context.theme.colorScheme.secondary,
                                blurRadius: 1,
                                spreadRadius: .2, //New
                              )
                            ]),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30)),
                          child: CachedNetworkImage(
                            width: AppLayout.getHeight(125),
                            height: AppLayout.getHeight(135),
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const ImageLoader(),
                            imageUrl: hotelDetail.providerimages[0],
                          ),
                        ),
                      ),
                    ),
                    const Expanded(child: Center()),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          hotelDetail.providername,
                          style: heading7,
                        ),
                        SizedBox(height: AppLayout.getHeight(4)),
                        RichText(
                            text: TextSpan(children: [
                          const WidgetSpan(
                              child: Icon(
                            Icons.location_on_rounded,
                            color: Colors.green,
                            size: 18,
                          )),
                          TextSpan(
                              text: hotelDetail.providergeolocation,
                              style: heading1)
                        ])),
                        SizedBox(height: AppLayout.getHeight(4)),
                        Row(
                          children: [
                            Expanded(
                                flex: 6,
                                child: RichText(
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(children: [
                                    const WidgetSpan(
                                        child: Icon(
                                      Icons.star,
                                      color: Colors.orange,
                                      size: 15,
                                    )),
                                    TextSpan(
                                        text: hotelDetail.providerrateing,
                                        style: heading9)
                                  ]),
                                )),
                            Expanded(
                                flex: 6,
                                child: RichText(
                                  textAlign: TextAlign.right,
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(children: [
                                    WidgetSpan(
                                        child: Icon(
                                      Icons.radio_button_on_sharp,
                                      color: hotelDetail.vegeterian == true
                                          ? Colors.green
                                          : Colors.brown,
                                      size: 18,
                                    )),
                                  ]),
                                ))
                          ],
                        )
                      ],
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

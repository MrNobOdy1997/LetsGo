
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Models/place_details_model.dart';
import '../Screens/DetailedViewScreen/place_detailed_view.dart';
import '../Utils/pallete.dart';
import '../Utils/size_controller.dart';
import 'image_loader_widget.dart';

class SearchResultWidget extends StatelessWidget {
const SearchResultWidget(
{Key? key, required this.placeDetail,
})
: super(key: key);
final PlaceDetails placeDetail;

@override
Widget build(BuildContext context) {
  return InkWell(
    onTap: (){
      Get.to(() => DetailedViewScreen(
        details: placeDetail,
      ));
    },
    child: Container(
      height: AppLayout.getHeight(100),
      width: AppLayout.getScreenWidth(),
      margin: EdgeInsets.only(left:AppLayout.getHeight(30)),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right:AppLayout.getHeight(30)),
            decoration: BoxDecoration(
                borderRadius:
                const BorderRadius.all(Radius.circular(15)),
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
              const BorderRadius.all(Radius.circular(15)),
              child: CachedNetworkImage(
                width: AppLayout.getHeight(80),
                height: AppLayout.getHeight(80),
                fit: BoxFit.cover,
                placeholder: (context, url) => const ImageLoader(),
                imageUrl: placeDetail.placeImages[0],
              ),
            ),
          ),
          SizedBox(height: AppLayout.getHeight(40),),
          Text(
            placeDetail.placeName,
            style: heading4,
          ),
        ],
      ),
    ),
  );
}
}
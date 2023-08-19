import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:letsgo/Utils/size_controller.dart';

import '../Models/place_details_model.dart';
import 'explore_page_controller.dart';

class SearchController extends GetxController{
  ExploreController exploreController = Get.put(ExploreController());
  late TextEditingController searchByWord;
  var placeList = <PlaceDetails>[];
  var searchResult = <PlaceDetails>[].obs;
  @override
  void onInit() {
    searchByWord = TextEditingController();
    log("placeList${placeList.length}");
    searchByWord.addListener(() {
       log("searchtext${searchByWord.text}");
       searchForPlaces(searchByWord.text);
    });
  }
  searchForPlaces(String keyWord){
    searchResult.clear();
for(var value in exploreController.placeDetailList){
  log("placeName${value.placeName}");
  var placeName = value.placeName;
  log("foundName${placeName}");
  if (placeName.toLowerCase().contains(keyWord.toLowerCase())) {
    log("foundNameif${placeName}");
   searchResult.add(value);
   if(searchResult.isNotEmpty){
     update();
   }
  } else {
    // AppLayout.customToast("Could't find anything");
  }
}
}
}
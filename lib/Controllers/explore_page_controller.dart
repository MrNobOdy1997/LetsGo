import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:letsgo/Controllers/firebase_controller.dart';
import 'package:letsgo/Models/hospitality_detail_model.dart';
import 'package:letsgo/Models/place_details_model.dart';
import 'package:letsgo/Utils/Constants.dart';
import 'package:letsgo/Widgets/filter_screen.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';
import '../Utils/size_controller.dart';

class ExploreController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isFiltering = false.obs;
  RxString username = "".obs;
  late TextEditingController searchField;
  var placeDetailList = <PlaceDetails>[];
  var hotelDetailList = <HospitalityDetails>[];
  var filterDetailList = <PlaceDetails>[].obs;
  FirebaseController firebaseController = Get.put(FirebaseController(),);
  final List<SwipeItem> swipeItems = <SwipeItem>[].obs;
   MatchEngine matchEngine = MatchEngine();
  RxBool endOfData = false.obs;
  RxString selectedDistrict = Districts.first.obs;

  @override
  void onInit() {
    searchField = TextEditingController();
    searchField.addListener(searchByText);
    getCurrentUserDetails();
    firebaseController.getFavDataFromDB();
    getTouristPlaceDetails();

    getHotelDetails();
  }
  searchByText(){
    log("searchfieldtext ${searchField.text}");
  }

  void openBottomSheet(String verificationId) {                 // Bottom sheet showing filter screen result
    print(Get.isBottomSheetOpen);
    Get.bottomSheet(
      FilterScreenResult(
        favourites: false,
      ),
      enableDrag: false,
      isDismissible: false,
      backgroundColor: Colors.white.withOpacity(1.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
    );
  }

  getTouristPlaceDetails() async {                                // Getting tourist place details at top attracion section
    var fetchedDataSnapshot =
        await firebaseController.getPlaceDataFromFirestore();
    if (fetchedDataSnapshot.docs.isEmpty) {
      isLoading.value = true;
    } else {
      for (var doc in fetchedDataSnapshot.docs) {
        var placesModel =
            PlaceDetails.fromDocumentSnapshot(documentSnapshot: doc);
        placeDetailList.add(PlaceDetails(
            placeTerrain: placesModel.placeTerrain,
            placeDescription: placesModel.placeDescription,
            placeDistrict: placesModel.placeDistrict,
            placeId: placesModel.placeId,
            placeName: placesModel.placeName,
            placeGeopoints: placesModel.placeGeopoints,
            placeImages: placesModel.placeImages));
      }
      if (placeDetailList.isNotEmpty) {
        update();
        isLoading.value = false;
      }
    }
  }

  filterPlacesFromDb(String filterType, String district) async {

    if (firebaseController.netWorkStatus == false) {
      AppLayout.customToast("Please turn on your internet");
    } else {
      // Filtering tourist palce from db as per user choice
      isFiltering.value = true;
      filterDetailList.clear();
      if (filterType == "District") {                                           //Condition to filter places on bases of district
        var filteredData =
        await firebaseController.filterDistrictDataFromDb(district);
        var data = filteredData["placeId"];
        for (var value in data) {
          log("filterplaces .......$value");
          var filterData = await firebaseController.filterPlaceDetails(value);
          var filteredPlacesModel =
          PlaceDetails.fromDocumentSnapshot(documentSnapshot: filterData);
          filterDetailList.add(PlaceDetails(
              placeTerrain: filteredPlacesModel.placeTerrain,
              placeDescription: filteredPlacesModel.placeDescription,
              placeDistrict: filteredPlacesModel.placeDistrict,
              placeId: filteredPlacesModel.placeId,
              placeName: filteredPlacesModel.placeName,
              placeGeopoints: filteredPlacesModel.placeGeopoints,
              placeImages: filteredPlacesModel.placeImages));

        }
        if(filterDetailList.isNotEmpty){
          addSwipeItem();
          isFiltering.value = false;
        }
        else{
          AppLayout.customToast("Could't find ");
        }
      }
      else {
        var filteredData =                                                                                 // Filtering places on bases of terrain
        await firebaseController.filterTerrainDataFromDb(filterType);
        var data = filteredData["placeId"];
        for (var value in data) {
          var filterData = await firebaseController.filterPlaceDetails(value);
          var filteredPlacesModel =
          PlaceDetails.fromDocumentSnapshot(documentSnapshot: filterData);
          filterDetailList.add(PlaceDetails(
              placeTerrain: filteredPlacesModel.placeTerrain,
              placeDescription: filteredPlacesModel.placeDescription,
              placeDistrict: filteredPlacesModel.placeDistrict,
              placeId: filteredPlacesModel.placeId,
              placeName: filteredPlacesModel.placeName,
              placeGeopoints: filteredPlacesModel.placeGeopoints,
              placeImages: filteredPlacesModel.placeImages));
        }
        if(filterDetailList.isNotEmpty){
          addSwipeItem();
          isFiltering.value = false;
        }
        else{
          AppLayout.customToast("Could't find ");
        }
      }
    }





  }

  getCurrentUserDetails() async {                                                        //Getting current user detail
    var currentUserDetails = await firebaseController.getUserData();
    if (currentUserDetails == null) {
      AppLayout.customToast("Could't get current user details");
      isLoading.value = true;
    } else {
      username.value = currentUserDetails['userName'];
    }
  }

  Future<void> getHotelDetails() async {                                                 // Getting all Hotel details from db
    var fetchedHotelDataSnapshot =
        await firebaseController.getHotelDataFromFirestore();
    if (fetchedHotelDataSnapshot.docs.isEmpty) {
      isLoading.value = false;
      // log("Inside fetchdata null");
    } else {
      // log("Inside fetchdata not null");
      for (var doc in fetchedHotelDataSnapshot.docs) {
        var hotelModel =
            HospitalityDetails.fromDocumentSnapshot(documentSnapshot: doc);
        hotelDetailList.add(HospitalityDetails(
            providergeolocation: hotelModel.providergeolocation,
            providerid: hotelModel.providerid,
            providername: hotelModel.providername,
            providerphone: hotelModel.providerphone,
            providermail: hotelModel.providermail,
            providerlocation: hotelModel.providerlocation,
            providerimages: hotelModel.providerimages,
            vegeterian: hotelModel.vegeterian,
            providerrateing:hotelModel.providerrateing));
        if (hotelDetailList.isNotEmpty) {
          update();
          isLoading.value = false;
        }
      }
    }


  }
  void addSwipeItem() {                                           // swipe item for showing filtered place data in the bottom sheet
    swipeItems.clear();
    for (int i = 0; i < filterDetailList.length; i++) {

      swipeItems.add(SwipeItem(
          content: filterDetailList[i],
          likeAction: () {
            log("placedata ${swipeItems.length}");
            if (i == filterDetailList.length - 1) {
              isFiltering.value = true;
              matchEngine = MatchEngine(swipeItems: swipeItems);
              // isLoading.value = true;
              isFiltering.value = false;
              update();

            }
          },
          nopeAction: () {
            if (i == filterDetailList.length - 1) {
              isFiltering.value = true;
              matchEngine = MatchEngine(swipeItems: swipeItems);
              // isLoading.value = true;
              isFiltering.value = false;
              update();
            }
          },
          superlikeAction: () {
            if (i == filterDetailList.length - 1) {
              isFiltering.value = true;
              matchEngine = MatchEngine(swipeItems: swipeItems);
              // isLoading.value = true;
              isFiltering.value = false;
              update();

            }
          },
          onSlideUpdate: (SlideRegion? region) async {
            print("Region $region");
          }));
    } //for loop

    matchEngine = MatchEngine(swipeItems: swipeItems);
    update();
    isLoading.value = false;
  }
}

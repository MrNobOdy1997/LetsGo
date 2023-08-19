import 'dart:developer';

import 'package:get/get.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';

import '../Models/place_details_model.dart';
import '../Utils/size_controller.dart';
import 'firebase_controller.dart';

class FavouritesController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isFiltering = false.obs;
  var favPlaceDetailList = <PlaceDetails>[].obs;
  FirebaseController firebaseController = Get.put(FirebaseController());
  RxString username = "".obs;
  var filterFavDetailList = <PlaceDetails>[].obs;
  final List<SwipeItem> favSwipeItems = <SwipeItem>[].obs;
  MatchEngine matchEngine = MatchEngine();

  @override
  void onInit() {
    getCurrentUserDetails();
  }

  getCurrentUserDetails() async {
    // get user deatils
    var currentUserDetails = await firebaseController.getUserData();
    if (currentUserDetails == null) {
      AppLayout.customToast("Could't get current user details");
      isLoading.value = true;
    } else {
      username.value = currentUserDetails['userName'];
      getFavouritesfromDb();
      isLoading.value = false;
    }
  }

  getFavouritesfromDb() async {
    if (firebaseController.netWorkStatus == false) {
      AppLayout.customToast("Please turn on your internet");
    } else {
      // get user added details from db
      for (var i = 0; i < firebaseController.favSpot.length; i++) {
        var favPlaceDetails = await firebaseController
            .filterPlaceDetails(firebaseController.favSpot.value[i]);

        var filteredPlacesModel = PlaceDetails.fromDocumentSnapshot(
            documentSnapshot: favPlaceDetails);
        favPlaceDetailList.add(PlaceDetails(
            placeTerrain: filteredPlacesModel.placeTerrain,
            placeDescription: filteredPlacesModel.placeDescription,
            placeDistrict: filteredPlacesModel.placeDistrict,
            placeId: filteredPlacesModel.placeId,
            placeName: filteredPlacesModel.placeName,
            placeGeopoints: filteredPlacesModel.placeGeopoints,
            placeImages: filteredPlacesModel.placeImages));

        update();
      }

      isLoading.value = false;
    }
  }

  filterFavPlacesFromDb(String filterType, String district) async {
    if (firebaseController.netWorkStatus == false) {
      AppLayout.customToast("Please turn on your internet");
    } else {
      // filter user fav from db
      isFiltering.value = true;
      filterFavDetailList.clear();
      if (filterType == "District") {
        // filter on bases of district
        var filteredData =
            await firebaseController.filterDistrictDataFromDb(district);
        var data = filteredData["placeId"];
        for (var value in data) {
          log("filterplaces .......$value");
          if (firebaseController.favSpot.contains(value)) {
            var filterData = await firebaseController.filterPlaceDetails(value);
            var filteredPlacesModel =
                PlaceDetails.fromDocumentSnapshot(documentSnapshot: filterData);
            filterFavDetailList.add(PlaceDetails(
                placeTerrain: filteredPlacesModel.placeTerrain,
                placeDescription: filteredPlacesModel.placeDescription,
                placeDistrict: filteredPlacesModel.placeDistrict,
                placeId: filteredPlacesModel.placeId,
                placeName: filteredPlacesModel.placeName,
                placeGeopoints: filteredPlacesModel.placeGeopoints,
                placeImages: filteredPlacesModel.placeImages));
          }
        }
        if (filterFavDetailList.isNotEmpty) {
          addSwipeItem();
          isFiltering.value = false;
        } else {
          AppLayout.customToast("Could't find ");
        }
      } else {
        var filteredData = // filter on bases of Terrain
            await firebaseController.filterTerrainDataFromDb(filterType);
        var data = filteredData["placeId"];
        for (var value in data) {
          log("filterplaces .......$value");
          if (firebaseController.favSpot.contains(value)) {
            var filterData = await firebaseController.filterPlaceDetails(value);
            var filteredPlacesModel =
                PlaceDetails.fromDocumentSnapshot(documentSnapshot: filterData);
            filterFavDetailList.add(PlaceDetails(
                placeTerrain: filteredPlacesModel.placeTerrain,
                placeDescription: filteredPlacesModel.placeDescription,
                placeDistrict: filteredPlacesModel.placeDistrict,
                placeId: filteredPlacesModel.placeId,
                placeName: filteredPlacesModel.placeName,
                placeGeopoints: filteredPlacesModel.placeGeopoints,
                placeImages: filteredPlacesModel.placeImages));
          }
        }
        if (filterFavDetailList.isNotEmpty) {
          addSwipeItem();
          isFiltering.value = false;
        } else {
          AppLayout.customToast("Could't find ");
        }
      }
    }
  }

  void addSwipeItem() {
    // Bottom sheet showing filter result as tinder swipe widget
    favSwipeItems.clear();
    for (int i = 0; i < filterFavDetailList.length; i++) {
      favSwipeItems.add(SwipeItem(
          content: filterFavDetailList[i],
          likeAction: () {
            log("placedata ${favSwipeItems.length}");
            if (i == filterFavDetailList.length - 1) {
              isFiltering.value = true;
              matchEngine = MatchEngine(swipeItems: favSwipeItems);
              // isLoading.value = true;
              isFiltering.value = false;
              update();
            }
          },
          nopeAction: () {
            if (i == filterFavDetailList.length - 1) {
              isFiltering.value = true;
              matchEngine = MatchEngine(swipeItems: favSwipeItems);
              // isLoading.value = true;
              isFiltering.value = false;
              update();
            }
          },
          superlikeAction: () {
            if (i == filterFavDetailList.length - 1) {
              isFiltering.value = true;
              matchEngine = MatchEngine(swipeItems: favSwipeItems);

              isFiltering.value = false;
              update();
            }
          },
          onSlideUpdate: (SlideRegion? region) async {
            print("Region $region");
          }));
    } //for loop
    matchEngine = MatchEngine(swipeItems: favSwipeItems);
    update();
    isLoading.value = false;
  }

  addToFav(PlaceDetails item) {
    // Adding place to favourites in db
    if (firebaseController.netWorkStatus == false) {
      AppLayout.customToast("Please turn on your internet");
    } else {
      firebaseController.addFavToDB(item.placeId);
      favPlaceDetailList.value.add(item);
      update();
    }





  }

  removeFromFav(String placeId) async {
    // Removing place from favourites


    if (firebaseController.netWorkStatus == false) {
      AppLayout.customToast("Please turn on your internet");
    } else {
      await firebaseController.removeFavFromDB(placeId);
      favPlaceDetailList.removeWhere((element) => element.placeId == placeId);
      update();
    }

  }
}

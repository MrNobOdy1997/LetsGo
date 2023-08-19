import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:letsgo/Utils/size_controller.dart';

import '../Models/hospitality_detail_model.dart';
import 'firebase_controller.dart';

class DetailedViewController extends GetxController {
  FirebaseController firebaseController = Get.put(FirebaseController());
  var hotelDetailList = <HospitalityDetails>[];
  FlutterTts flutterTts = FlutterTts();
  bool isSpeaking = false;
  RxBool isLoading = true.obs;

  void textToSpeech(String information) async {    // Method to convert text to speech
    if (isSpeaking == false) {
      AppLayout.customToast("speaking");
      await flutterTts.speak(information);
      isSpeaking = true;
    } else {
      AppLayout.customToast("stop speaking");
      await flutterTts.stop();
      isSpeaking = false;
    }
  }

  Future<void> getHotelDetails(String districtName) async {   // Method to get selected hotel detail

    if (firebaseController.netWorkStatus == false) {
      AppLayout.customToast("Please turn on your internet");
    } else {
      hotelDetailList.clear();
      var fetchedHotelDataSnapshot =
      await firebaseController.filterDistrictDataFromDb(districtName);
      var data = fetchedHotelDataSnapshot["hotelId"];
      for (var doc in data) {
        var fetchedHotelDataSnapshot =
        await firebaseController.touristPlaceHotelDetails(doc);
        var hotelModel =
        HospitalityDetails.fromDocumentSnapshot(documentSnapshot: fetchedHotelDataSnapshot);
        hotelDetailList.add(HospitalityDetails(
            providergeolocation: hotelModel.providergeolocation,
            providerid: hotelModel.providerid,
            providername: hotelModel.providername,
            providerphone: hotelModel.providerphone,
            providermail: hotelModel.providermail,
            providerlocation: hotelModel.providerlocation,
            providerimages: hotelModel.providerimages,
            vegeterian: hotelModel.vegeterian,
            providerrateing: hotelModel.providerrateing));
        if (hotelDetailList.isNotEmpty) {
          update();
          isLoading.value = false;
        }
      }
    }



  }
}

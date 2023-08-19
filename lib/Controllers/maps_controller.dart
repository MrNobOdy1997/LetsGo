
import 'dart:developer';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:letsgo/Models/hospitality_detail_model.dart';
import 'package:letsgo/Models/place_details_model.dart';

import '../Screens/MapsScreen/map_view_page.dart';

class MapController extends GetxController{
  final List<Marker> markers = <Marker>[].obs;
  Uint8List? marketimages;

  // declared method to get Images
  Future<Uint8List> getImages(String path, int width) async{
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return(await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();

  }

  @override
  void onInit() {

  }

  Future<void> loadData(GeoPoint geopoint, String placeId,bool markerType,String name) async {
    if(markerType){
      final Uint8List placeMarker = await getImages("assets/images/letsgo.png", 100);
      // makers added according to index
      log("");
      markers.clear();
      markers.add(
          Marker(
            // given marker id
            markerId: MarkerId(placeId),
            // given marker icon
            icon: BitmapDescriptor.fromBytes(placeMarker),
            // given position
            position:LatLng(geopoint.latitude, geopoint.longitude) ,
            infoWindow:  InfoWindow(
              // given title for marker
              title: 'Location: $name ',
            ),
          )
      );
    }
    else{
      final Uint8List placeMarker = await getImages("assets/images/restaurantmarker.png", 110);
      // makers added according to index
      log("");
      markers.clear();
      markers.add(
          Marker(
            // given marker id
            markerId: MarkerId(placeId),
            // given marker icon
            icon: BitmapDescriptor.fromBytes(placeMarker),
            // given position
            position:LatLng(geopoint.latitude, geopoint.longitude) ,
            infoWindow: const InfoWindow(
              // given title for marker
              title: 'Location: ',
            ),
          )
      );
    }

     Get.to(() =>  MapSample(latitude: geopoint.latitude,longitude: geopoint.longitude));
  }
  Future<void> plotAllPlaces(List<PlaceDetails> placeDetailList)async {
    final Uint8List placeMarker = await getImages("assets/images/letsgo.png", 80);
    markers.clear();
    for(var data in placeDetailList){
      markers.add(
          Marker(
            // given marker id
            markerId: MarkerId(data.placeId),
            // given marker icon
            icon: BitmapDescriptor.fromBytes(placeMarker),
            // given position
            position:LatLng(data.placeGeopoints.latitude, data.placeGeopoints.longitude) ,
            infoWindow:  InfoWindow(
              // given title for marker
              title: 'Location: ${data.placeName} ',
            ),
          )
      );
    }
    Get.to(() =>  MapSample(latitude: placeDetailList[0].placeGeopoints.latitude,longitude:  placeDetailList[0].placeGeopoints.longitude));
  }
  Future<void> plotAllHotels(List<HospitalityDetails> hotelDetailList)async {
    final Uint8List placeMarker = await getImages("assets/images/restaurantmarker.png", 80);
    markers.clear();
    for(var data in hotelDetailList){
      markers.add(
          Marker(
            // given marker id
            markerId: MarkerId(data.providerid),
            // given marker icon
            icon: BitmapDescriptor.fromBytes(placeMarker),
            // given position
            position:LatLng(data.providerlocation.latitude, data.providerlocation.longitude) ,
            infoWindow:  InfoWindow(
              // given title for marker
              title: 'Location: ${data.providername} ',
            ),
          )
      );
    }
    Get.to(() =>  MapSample(latitude: hotelDetailList[0].providerlocation.latitude,longitude:hotelDetailList[0].providerlocation.longitude));
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';

class PlaceDetails {
  String placeId;
  String placeDescription;
  String placeDistrict;
  String placeTerrain;
  GeoPoint placeGeopoints;
  String placeName;
  List<dynamic> placeImages;

  PlaceDetails(
      {required this.placeTerrain,
      required this.placeDescription,
      required this.placeDistrict,
      required this.placeId,
      required this.placeName,
      required this.placeGeopoints,
      required this.placeImages});

  Map<String, dynamic> toMap() {
    return {
      'placeterrain': placeTerrain,
      'newsTitle': placeDescription,
      'placedistrict': placeDistrict,
      'placeid': placeId,
      'placename': placeName,
      'placegeopoints': placeGeopoints,
      'placeimages': placeImages
    };
  }

  PlaceDetails.fromDocumentSnapshot(
      {required DocumentSnapshot<Object?> documentSnapshot})
      :
        placeDescription = documentSnapshot["placedescription"],
        placeTerrain = documentSnapshot["placeterrain"],
        placeDistrict = documentSnapshot["placedistrict"],
        placeGeopoints = documentSnapshot["placegeopoints"],
        placeId = documentSnapshot["placeid"],
        placeName = documentSnapshot["placename"],
        placeImages = documentSnapshot["placeimages"];
}

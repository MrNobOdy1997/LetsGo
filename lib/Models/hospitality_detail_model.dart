import 'package:cloud_firestore/cloud_firestore.dart';

class HospitalityDetails {
  String providergeolocation;
  String providerid;
  String providername;
  String providerphone;
  String providermail;
  String providerrateing;
  GeoPoint providerlocation;
  bool vegeterian;
  List<dynamic> providerimages;

  HospitalityDetails(
      {required this.providergeolocation,
      required this.providerid,
      required this.providername,
      required this.providerphone,
      required this.providermail,
      required this.providerlocation,
      required this.providerimages,
      required this.vegeterian,
      required this.providerrateing});

  Map<String, dynamic> toMap() {
    return {
      'providergeolocation': providergeolocation,
      'providerid': providerid,
      'providername': providername,
      'providerphone': providerphone,
      'providermail': providermail,
      'providerlocation': providerlocation,
      'providerimages': providerimages,
      'vegeterian': vegeterian,
      'providerrateing':providerrateing
    };
  }

  HospitalityDetails.fromDocumentSnapshot(
      {required DocumentSnapshot<Object?> documentSnapshot})
      : providergeolocation = documentSnapshot["providergeolocation"],
        providerid = documentSnapshot["providerid"],
        providername = documentSnapshot["providername"],
        providerphone = documentSnapshot["providerphone"],
        providermail = documentSnapshot["providermail"],
        providerlocation = documentSnapshot["providerlocation"],
        providerimages = documentSnapshot["providerimages"],
        vegeterian = documentSnapshot["vegeterian"],
        providerrateing = documentSnapshot["providerrateing"];
}

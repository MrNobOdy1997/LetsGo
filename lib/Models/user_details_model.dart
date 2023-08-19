import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  String id;
  String userName;
  String mailId;
  String password;
  String phoneNumber;
  bool sms;

  UserData(
      {required this.id,
      required this.userName,
      required this.mailId,
      required this.password,
      required this.phoneNumber,
      required this.sms});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userName': userName,
      'mailId': mailId,
      'password': password,
      'phoneNumber': phoneNumber,
      'sms': sms
    };
  }

  UserData.fromDocumentSnapshot(
      {required DocumentSnapshot<Object?> documentSnapshot})
      : id = documentSnapshot["id"],
        userName = documentSnapshot["userName"],
        mailId = documentSnapshot["mailId"],
        password = documentSnapshot["password"],
        phoneNumber = documentSnapshot["phoneNumber"],
        sms = documentSnapshot["sms"];
}

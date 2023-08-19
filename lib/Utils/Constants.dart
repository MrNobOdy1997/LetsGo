import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final Future<FirebaseApp> firebaseInitialization = Firebase.initializeApp();
FirebaseAuth firebaseAuth = FirebaseAuth.instance;
FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
const CATEGORIES = [
  {"image": "beach.png", "name": "Beach"},
  {"image": "field.png", "name": "Land"},
  {"image": "mountain.png", "name": "Mountain"},
  {"image": "country.png", "name": "District"},
];
const Districts = [
  "Alappuzha",
  "Ernakulam",
  "Idukki",
  "Kollam",
  "Kottyam",
  "Thrissur",
  "Trivandrum",
  "Wayanad"
];

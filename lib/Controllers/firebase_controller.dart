import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:letsgo/Models/user_details_model.dart';

import 'package:letsgo/Screens/LoginScreen/login_page.dart';

import '../Screens/BottomNavigationBar/bottom_bar.dart';
import '../Utils/Constants.dart';
import '../Utils/size_controller.dart';

class FirebaseController extends GetxController {
  String currentUserId = "";

  late Rx<User?> firebaseUser;
  var favSpot = <String>[].obs;
  User? user;
RxBool netWorkStatus = true.obs;
  //this variable 0 = No Internet, 1 = connected to WIFI ,2 = connected to Mobile Data.
  //Instance of Flutter Connectivity

  int connectionType = 0;
  final Connectivity _connectivity = Connectivity();
  //Stream to keep listening to network change state
  late StreamSubscription _streamSubscription;

  @override
  void onInit() {
    super.onInit();
    _getConnectionType();
    _streamSubscription =
        _connectivity.onConnectivityChanged.listen(_updateState);
    firebaseUser = Rx<User?>(firebaseAuth.currentUser);

    firebaseUser.bindStream(firebaseAuth.userChanges());

    ever(firebaseUser, _setInitialScreen);

    if (netWorkStatus == false) {
      AppLayout.customToast("Please turn on your internet");
    } else {
      initializeFirebase();
    }

  }


  @override
  void onClose() {
    //stop listening to network state when app is closed
    _streamSubscription.cancel();
    super.onClose();
  }

  // a method to get which connection result, if you we connected to internet or no if yes then which network
  Future<void> _getConnectionType() async {
    ConnectivityResult? connectivityResult;
    try {
      connectivityResult = await (_connectivity.checkConnectivity());
    } on PlatformException catch (e) {
      print(e);
    }
    return _updateState(connectivityResult!);
  }



  // state update, of network, if you are connected to WIFI connectionType will get set to 1,
  // and update the state to the consumer of that variable.
  _updateState(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        connectionType = 1;
        AppLayout.customToast("You are connected to wifi");
        netWorkStatus.value = true;
        break;
      case ConnectivityResult.mobile:
        connectionType = 2;
        netWorkStatus.value = true;
        AppLayout.customToast("You are connected to mobile data");
        break;
      case ConnectivityResult.none:
        connectionType = 0;
        netWorkStatus.value =false;
        AppLayout.customToast("Please connect to internet");
        break;
      default:
        netWorkStatus.value =false;
        Get.snackbar('Network Error', 'Failed to get Network Status');
        break;
    }
  }

  Future<FirebaseApp> initializeFirebase() async {


    FirebaseApp firebaseApp = await Firebase.initializeApp();

    user = FirebaseAuth.instance.currentUser;

    return firebaseApp;
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      AppLayout.customToast("inside firecontroller login");
      Get.offAll(() => LoginScreen(), transition: Transition.fadeIn);
    } else {
      AppLayout.customToast("inside firecontroller bottom");
    }
  }

  void register(
      String username, String email, password, String phoneNumber) async {


    if (netWorkStatus == false) {
      AppLayout.customToast("Please turn on your internet");
    } else {
      try {
        CollectionReference reference =
        FirebaseFirestore.instance.collection("Users");
        await firebaseAuth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) {
          print(value.user?.uid.toString());
          UserData userData = UserData(
              id: value.user!.uid.toString(),
              userName: username,
              mailId: email,
              password: password,
              phoneNumber: phoneNumber,
              sms: false);
          reference
              .doc(value.user?.uid.toString())
              .set(userData.toMap())
              .then((value) => Get.offAll(BottomBar()));
        }).catchError((onError) =>
            log("Inside registermethod on error catch $onError"));
      } catch (firebaseAuthException) {}
    }





  }

  void login(String email, String password) async {
    try {
      await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => Get.to(() => BottomBar()))
          .catchError((onError) =>
              Get.snackbar("Error while sign in ", onError.message));
    } catch (firebaseAuthException) {}
  }

  signOut() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      if (!kIsWeb) {
        await googleSignIn.signOut();
      }
      await FirebaseAuth.instance.signOut();
      Get.offAll(LoginScreen());
    } catch (e) {}
  }

  Future<QuerySnapshot<Object?>> getPlaceDataFromFirestore() async {
    var response = await FirebaseFirestore.instance
        .collection("Places")
        .get()
        .then((QuerySnapshot querySnapshot) {
      return querySnapshot;
    });

    return response;
  }

  filterTerrainDataFromDb(String filterType) async {
    var filterDbReference = await FirebaseFirestore.instance
        .collection("FilterCategory")
        .doc(filterType)
        .get();
    if (filterDbReference.exists) {
      Map<String, dynamic>? data = filterDbReference.data();
      return data;
    }
  }

  filterDistrictDataFromDb(String districtName) async {
    var filterDbReference = await FirebaseFirestore.instance
        .collection("FilterCategory")
        .doc("District")
        .collection("DistrictNames")
        .doc(districtName)
        .get();
    if (filterDbReference.exists) {
      Map<String, dynamic>? data = filterDbReference.data();
      return data;
    }
  }

  Future<QuerySnapshot<Object?>> getHotelDataFromFirestore() async {
    var response = await FirebaseFirestore.instance
        .collection("Hospitality")
        .get()
        .then((QuerySnapshot querySnapshot) {
      return querySnapshot;
    });

    return response;
  }

  Future<DocumentSnapshot<Object?>> touristPlaceHotelDetails(
      String hotelId) async {
    var response = await FirebaseFirestore.instance
        .collection("Hospitality")
        .doc(hotelId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      return documentSnapshot;
    });

    return response;
  }

  Future<DocumentSnapshot<Object?>> filterPlaceDetails(id) async {
    var sortedPlaceDetail = await FirebaseFirestore.instance
        .collection("Places")
        .doc(id)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      return documentSnapshot;
    });
    return sortedPlaceDetail;
  }

  Future<DocumentSnapshot<Object?>> getUserData() async {
    currentUserId = firebaseUser.value!.uid;
    var response = await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUserId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      return documentSnapshot;
    });
    return response;
  }

  addFavToDB(String favItemId) async {
    var response = await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUserId)
        .collection("Favourites")
        .doc(favItemId)
        .set({"itemId": favItemId});
  }

  removeFavFromDB(String itemId) async {
    var response = await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUserId)
        .collection("Favourites")
        .doc(itemId)
        .delete()
        .then((value) => favSpot.remove(itemId));

    for (var value in favSpot) {
      log("favSpotdetails ..${value}");
    }
  }

  void getFavDataFromDB() {
    var collection = FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUserId)
        .collection("Favourites");
    collection.snapshots().listen((querySnapshot) {
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data();
        favSpot.add(data['itemId']);
      }
    });
    update();
  }
}

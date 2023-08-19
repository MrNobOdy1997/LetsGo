import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:letsgo/Controllers/explore_page_controller.dart';
import 'package:letsgo/Controllers/favourite_page_controller.dart';
import 'package:letsgo/Controllers/firebase_controller.dart';
import 'package:letsgo/Utils/pallete.dart';
import 'package:letsgo/Utils/size_controller.dart';
import 'package:letsgo/Widgets/filter_screen.dart';
import 'dropdown_widget.dart';

class CathegoryItem extends StatelessWidget {
  const CathegoryItem(
      {Key? key, required this.category, required this.favouritesPage})
      : super(key: key);
  final Map<String, String> category;
  final bool favouritesPage;

  @override
  Widget build(BuildContext context) {
    ExploreController exploreController = Get.put(ExploreController());
    FavouritesController favouritesController = Get.put(FavouritesController());
    FirebaseController firebaseController = Get.put(FirebaseController());
    return InkWell(
      onTap: () {
        if (category["name"] == "District") {
          Get.defaultDialog(
              backgroundColor: context.theme.colorScheme.background,
              titleStyle:  TextStyle(color: context.theme.colorScheme.background),
              middleTextStyle:  TextStyle(color: context.theme.colorScheme.background),
              content: const DropdownButtonExample(),
              textConfirm: "Find Places",
              confirmTextColor: Colors.black,
              buttonColor: context.theme.colorScheme.primary,
              onConfirm: () {
                if (favouritesPage == true) {
                  favouritesController.filterFavPlacesFromDb(category["name"]!,
                      exploreController.selectedDistrict.value);
                } else {
                  exploreController.filterPlacesFromDb(category["name"]!,
                      exploreController.selectedDistrict.value);
                }
                Get.bottomSheet(
                  firebaseController.netWorkStatus.value ?
                  Container(
                    child: FilterScreenResult(
                      favourites: favouritesPage,
                    ),
                  ):Center(
                    child: Container(
                        child: Column(children: [
                          SizedBox(height: AppLayout.getHeight(50)),
                          Image.asset(
                            'assets/images/network.png',
                            width: AppLayout.getWidth(100),
                            height: AppLayout.getHeight(100),
                            fit: BoxFit.fitWidth,
                          ),
                          SizedBox(
                            height: AppLayout.getHeight(30),
                          ),
                          Text(
                            "No Internet",
                            style: heading3,
                          ),
                        ])),
                  ),
                  backgroundColor: context.theme.colorScheme.background,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                );
              });
        } else {
          if (favouritesPage == true) {
            favouritesController.filterFavPlacesFromDb(category["name"]!, "");
          } else {
            exploreController.filterPlacesFromDb(category["name"]!, "");
          }

          Get.bottomSheet(
            firebaseController.netWorkStatus.value ?
            Container(
              height: AppLayout.getScreenHeight(),
              child: FilterScreenResult(
                favourites: favouritesPage,
              ),
            ):Center(
              child: Container(
                  child: Column(children: [
                    SizedBox(height: AppLayout.getHeight(50)),
                    Image.asset(
                      'assets/images/network.png',
                      width: AppLayout.getWidth(100),
                      height: AppLayout.getHeight(100),
                      fit: BoxFit.fitWidth,
                    ),
                    SizedBox(
                      height: AppLayout.getHeight(30),
                    ),
                    Text(
                      "No Internet",
                      style: heading3,
                    ),
                  ])),
            ),
            backgroundColor: Colors.white.withOpacity(1.0),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          );
        }
      },
      child: Container(
        height: AppLayout.getHeight(10),
        width: favouritesPage == true
            ? AppLayout.getWidth(100)
            : AppLayout.getWidth(100),
        margin: const EdgeInsets.all(7.0),
        decoration: BoxDecoration(
          color: context.theme.colorScheme.background,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: context.theme.colorScheme.surface,
              blurRadius: 1.0,
              spreadRadius: 1, //New
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Image.asset(
                "assets/images/${category["image"]}",
                height: AppLayout.getHeight(60),
                width: AppLayout.getWidth(60),
              ),
              SizedBox(
                height: AppLayout.getHeight(5),
              ),
              Text(
                "${category["name"]}",
                style: heading1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

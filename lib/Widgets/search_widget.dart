import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controllers/explore_page_controller.dart';
import '../Controllers/search_controller.dart';
import '../Screens/SearchScreen/search_screen.dart';
import '../Utils/pallete.dart';
import '../Utils/size_controller.dart';

class SearchWidget extends StatelessWidget {
  SearchWidget({Key? key, required this.hintTitle, required this.enable})
      : super(key: key);
  final String hintTitle;
  final bool enable;
  ExploreController exploreController = Get.put(ExploreController());
  SearchController searchController = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (enable == true) {




        } else {
          Get.to(() =>  SearchScreen(),
              duration: const Duration(milliseconds: 900),
              //duration of transitions, default 1 sec
              transition: Transition.downToUp);
        }
      },
      child: Container(
        height: AppLayout.getHeight(60),
        width: AppLayout.getScreenWidth(),
padding: EdgeInsets.only(left:AppLayout.getHeight(20),right: AppLayout.getHeight(20)),
// margin: EdgeInsets.all(AppLayout.getHeight(20)),
        // decoration: BoxDecoration(
        //   color: Colors.grey.withOpacity(.5),
        //   border: Border.all(width: .5, color: context.theme.colorScheme.surface),
        //   borderRadius: BorderRadius.circular(20),
        // ),
        child: TextFormField(
          controller: enable?searchController.searchByWord: exploreController.searchField,
          decoration: InputDecoration(
            enabled: enable,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 5, color: context.theme.colorScheme.surface),
              //<-- SEE HERE
              borderRadius: BorderRadius.circular(10.0),
            ),
            labelText: hintTitle,
            labelStyle: const TextStyle(
                color: Colors.blueGrey,
                fontSize: 20,
                fontWeight: FontWeight.w500),
            prefixIcon: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: AppLayout.getHeight(15)),
              child: const Icon(
                Icons.search_outlined,
                size: 28,
                color: Colors.blueGrey,
              ),
            ),
            hintStyle: heading1,
          ),
          style: heading4,
        ),
      ),
    );
  }
}

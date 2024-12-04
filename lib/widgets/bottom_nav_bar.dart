import 'package:flutter/material.dart';
import 'package:flutter_base_app/views/home_view.dart';
import 'package:flutter_base_app/views/other_view.dart';
import 'package:get/get.dart';

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.other_houses),
          label: 'Other',
        ),
      ],
      onTap: (index) {
        switch (index) {
          case 0:
            Get.to(HomeView());
            break;
          case 1:
            Get.to(OtherView());
            break;
        }
      },
    );
  }
}

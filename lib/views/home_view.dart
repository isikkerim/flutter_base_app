import 'package:flutter/material.dart';
import 'package:flutter_base_app/controllers/theme_controller.dart';
import 'package:flutter_base_app/widgets/bottom_nav_bar.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              themeController.toggleTheme();
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('Home View'),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

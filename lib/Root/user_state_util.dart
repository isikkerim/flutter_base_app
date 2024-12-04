import 'package:flutter/material.dart';
import 'package:flutter_base_app/Auth/auth_service.dart';
import 'package:flutter_base_app/views/home_view.dart';
import 'package:flutter_base_app/widgets/bottom_nav_bar.dart';

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: FirebaseAuthService().authStateChanges(),
      builder: (context, helperSnapshot) {
        if (helperSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator()); // Yükleniyor ekranı
        }

        if (helperSnapshot.hasError) {
          return Center(child: Text("Bir hata oluştu!")); // Hata ekranı
        }

        if (helperSnapshot.data == true) {
          // İlk defa giriş yapıldıysa onboarding sayfasına yönlendir
          //
          //  return OnBoardingPage();
          return BottomNavBar();
        } else {
          return FutureBuilder(
              future: FirebaseAuthService().authStateChanges(),
              builder: (context, authSnapshot) {
                if (authSnapshot.connectionState == ConnectionState.waiting) {
                  return Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ); // Yükleniyor ekranı
                }
                if (authSnapshot.hasError) {
                  return Scaffold(
                      body: Center(
                          child: Text("Bir hata oluştu!"))); // Hata ekranı
                }
                if (authSnapshot.data == true) {
                  return BottomNavBar(); // Kullanıcı giriş yaptıysa
                } else {
                  return HomeView(); // Kullanıcı giriş yapmadıysa
                }
              });
        }
      },
    );
  }
}

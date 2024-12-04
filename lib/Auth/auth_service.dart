import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_app/views/home_view.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'auth_abstract.dart';

FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

class FirebaseAuthService extends AuthService {
  @override
  Future<bool> authStateChanges() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      return user != null;
    } on FirebaseAuthException catch (e) {
      String errorMessage;

      // FirebaseAuth hatalarına göre özel mesajlar
      switch (e.code) {
        case 'network-request-failed':
          errorMessage = 'Ağ hatası'; // Ağ hatası mesajı
          break;
        case 'user-disabled':
          errorMessage = 'Hesap engellendi'; // Hesap engellendi mesajı
          break;
        case 'operation-not-allowed':
          errorMessage = 'İşlem izin verilmiyor'; // İşlem izin verilmiyor mesajı
          break;
        default:
          errorMessage = 'Genel hata'; // Genel hata mesajı
      }

      // Hata durumunda Snackbar ile kullanıcıya bildirim göster
      Get.snackbar(
        'Hata', // Başlık
        errorMessage, // Hata mesajı
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );

      return false;
    } catch (e) {
      // Diğer hatalar için genel bir hata mesajı
      Get.snackbar(
        'Hata', // Başlık
        'Genel hata', // Genel hata mesajı
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
      return false;
    }
  }

  @override
  Future<void> changeUserPassword({required String email}) async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email)
          .whenComplete(() {
        // Başarı durumunda Snackbar gösteriliyor
        Get.snackbar(
          'Başarılı', // Başlık
          "Şifre sıfırlama e-postası gönderildi: $email", // Mesaj
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3),
        );

        print("Şifre sıfırlama e-postası başarıyla gönderildi: $email");
      });
    } on FirebaseAuthException catch (e) {
      String errorMessage;

      // Firebase hatası kontrol ediliyor
      if (e.code == 'user-not-found') {
        errorMessage = 'Kullanıcı bulunamadı';
      } else {
        errorMessage = 'Genel hata';
      }

      // Hata durumunda Snackbar gösteriliyor
      Get.snackbar(
        'Hata', // Başlık
        errorMessage, // Hata mesajı
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );

      print("Hata: ${e.message}");
    } catch (e) {
      // Genel bir hata durumunda
      Get.snackbar(
        'Hata', // Başlık
        'Genel hata', // Genel hata mesajı
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );

      print("Hata: $e");
    }
  }

  @override
  Future<UserCredential?> createUserwithMailandPassword({
    required String emailAddress,
    required String password,
  }) async {
    try {
      UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      // Giriş başarılı ise credential döndür
      return credential;
    } on FirebaseAuthException catch (e) {
      // Hata mesajlarını kontrol et
      if (e.code == 'weak-password') {
        print('Girilen şifre çok zayıf.');
      } else if (e.code == 'email-already-in-use') {
        print('Bu e-posta için hesap zaten mevcut.');
      }
      return null; // Hata durumunda null döndür
    } catch (e) {
      print('Bir hata oluştu: $e');
      return null; // Diğer hatalar için null döndür
    }
  }

  @override
  void currentUserDataProvider() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        print(user.uid);
      }
    });
  }

  void currenUserUuid() {
    if (FirebaseAuth.instance.currentUser != null) {
      print(FirebaseAuth.instance.currentUser?.uid);
    }
  }

  @override
  Future<void> reauthenticate(
      {required String mail, required String password}) async {
    _firebaseAuth.currentUser?.reauthenticateWithCredential(
      EmailAuthProvider.credential(
        email: mail,
        password: password,
      ),
    );
  }

  @override
  Future<void> userDelete() async {
    await _firebaseAuth.currentUser!.delete();
  }

  @override
  Future<UserCredential?> userLoginWithEmailPassword({
    required String emailAddress,
    required String password,
  }) async {
    try {
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);

      // Giriş başarılı ise credential döndür
      return credential;
    } on FirebaseAuthException catch (e) {
      // Firebase hataları için mesajlar
      if (e.code == 'user-not-found') {
        print('Bu e-posta için kullanıcı bulunamadı.');
      } else if (e.code == 'wrong-password') {
        print('Bu kullanıcı için girilen şifre yanlış.');
      }
      return null; // Hata durumunda null döndür
    } catch (e) {
      print('Bir hata oluştu: $e');
      return null; // Diğer hatalar için null döndür
    }
  }

  @override
  Future<UserCredential?> userLoginWithGoogleAccount() async {
    // Kimlik doğrulama akışını başlatın
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Talep detaylarını alın
    final GoogleSignInAuthentication? googleAuth =
    await googleUser?.authentication;

    // Yeni bir kimlik bilgisi oluşturun
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Giriş yaptıktan sonra UserCredential döndür
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Future<void> userPasswordUpdate({required String newPassword}) async {
    await _firebaseAuth.currentUser?.updatePassword(newPassword);
  }

  @override
  Future<void> userSignOut() async {
    FirebaseAuth.instance.signOut().then(
          (value) {
        Get.offAll(HomeView());
      },
    );
  }
}

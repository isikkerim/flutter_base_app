import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthService {
  Future<UserCredential?> userLoginWithEmailPassword(
      {required String emailAddress, required String password});

  Future<UserCredential?> userLoginWithGoogleAccount();

  Future<bool>? authStateChanges();

  void currenUserUuid();

  Future<UserCredential?> createUserwithMailandPassword(
      {required String emailAddress, required String password});

  void currentUserDataProvider();


  Future<void> userPasswordUpdate({required String newPassword});

  Future<void> changeUserPassword({required String email});

  void userDelete();

  void reauthenticate({required String mail, required String password});

  void userSignOut();
}
import 'dart:developer';
import 'package:detail_app/routes/routes.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  RxBool isLoggedIn = false.obs;
  RxString name = ''.obs;
  RxString email = ''.obs;
  RxString password = ''.obs;
  RxString photoPath = ''.obs;

  AuthController() {
    getAllData();
  }

  Future<void> saveLoginData(
      String username, String userEmail, String password, String photo) async {
    isLoggedIn.value = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', username);
    await prefs.setString('email', userEmail);
    await prefs.setString('password', password);
    await prefs.setString('photo', photo);
    await prefs.setBool('isLoggedIn', isLoggedIn.value);
  }

  void getAllData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    name.value = prefs.getString('name') ?? '';
    email.value = prefs.getString('email') ?? '';
    photoPath.value = prefs.getString('photo') ?? '';
    password.value = prefs.getString('password') ?? '';
    isLoggedIn.value = prefs.getBool('isLoggedIn') ?? false;

    log("LOGIN : ${isLoggedIn.value}");
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    isLoggedIn.value = false;
    Get.offAllNamed(Routes.signup);
  }
}

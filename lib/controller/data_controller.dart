import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class DataController extends GetxController {
  RxList<Map<String, String>> details = <Map<String, String>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadDetails();
  }

  void addDetail(String title, String subtitle) async {
    details.add({'title': title, 'subtitle': subtitle});
    await saveDetails();
  }

  Future<void> saveDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String encodedDetails = jsonEncode(details);
    await prefs.setString('details', encodedDetails);
  }

  void deleteDetail(int index) async {
    details.removeAt(index);
    await saveDetails();
  }

  Future<void> loadDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? encodedDetails = prefs.getString('details');
    if (encodedDetails != null) {
      List<dynamic> decodedDetails = jsonDecode(encodedDetails);
      details.value =
          decodedDetails.map((e) => Map<String, String>.from(e)).toList();
    }
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/data_controller.dart';

class AddDetailScreen extends StatelessWidget {
  DataController dataController = Get.find();
  TextEditingController titleController = TextEditingController();
  TextEditingController subtitleController = TextEditingController();

  void saveDetail() {
    if (titleController.text.isNotEmpty && subtitleController.text.isNotEmpty) {
      dataController.addDetail(titleController.text, subtitleController.text);
      Get.snackbar('Success', 'Detail added successfully!');
      Get.back();
    } else {
      Get.snackbar('Error', 'Please fill in both fields.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Add Detail'),
        backgroundColor: Colors.white70,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              controller: titleController,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 2,
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 2,
                  ),
                ),
                filled: true,
                fillColor: Colors.white70,
                hintText: " Enter Title",
                hintStyle: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                ),
                border: const OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              maxLines: 3,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              controller: subtitleController,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 2,
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 2,
                  ),
                ),
                filled: true,
                fillColor: Colors.white70,
                hintText: " Enter SubTitle",
                hintStyle: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                ),
                border: const OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.back();
                saveDetail();
              },
              // onLongPress: () => Get.back(),
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

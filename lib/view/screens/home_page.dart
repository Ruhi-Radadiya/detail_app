import 'dart:io';

import 'package:detail_app/controller/auth_controller.dart';
import 'package:detail_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/data_controller.dart';
import 'detail_page.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DataController dataController = Get.put(DataController());
  AuthController authController = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
    // authController.getAllData();
    // loadUserData();
  }

  // Future<void> loadUserData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     username = prefs.getString('username') ?? 'User';
  //     email = prefs.getString('email') ?? 'user@example.com';
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        title: Text(
          'Home',
        ),
        backgroundColor: Colors.white,
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Obx(
              () => UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.blue.shade300),
                accountName: Text(authController.name.value),
                accountEmail: Text(authController.email.value),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    backgroundImage: FileImage(
                      File(authController.photoPath.value),
                    ),
                    radius: 50,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text('Add Details'),
              onTap: () {
                Navigator.pop(context);
                Get.toNamed(Routes.add);
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18.0),
              child: Divider(),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Get.back();
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18.0),
              child: Divider(),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                authController.logout();
                Get.offNamed(Routes.signup);
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18.0),
              child: Divider(),
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Exit'),
              onTap: () {
                exit(0);
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() => dataController.details.isEmpty
            ? Center(
                child: Image.asset(
                'assets/1.png',
                width: 200,
              ))
            : ListView.builder(
                itemCount: dataController.details.length,
                itemBuilder: (context, index) {
                  final item = dataController.details[index];
                  return Card(
                    color: Colors.white,
                    child: ListTile(
                      title: Text(item['title']!),
                      subtitle: Text(item['subtitle']!),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          _confirmDelete(context, index);
                        },
                      ),
                      onTap: () {
                        Get.to(() => DetailScreen(detail: item));
                      },
                    ),
                  );
                },
              )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.add),
        child: Icon(Icons.add),
        tooltip: 'Add Detail',
      ),
    );
  }

  // Confirmation dialog before deleting
  void _confirmDelete(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Detail'),
        content: Text('Are you sure you want to delete this detail?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              dataController.deleteDetail(index);
              Navigator.pop(context);
              Get.snackbar('Deleted', 'Detail has been deleted successfully.',
                  backgroundColor: Colors.green.shade100);
            },
            child: Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

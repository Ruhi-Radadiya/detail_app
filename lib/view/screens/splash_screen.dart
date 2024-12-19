import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import '../../controller/auth_controller.dart';
import '../../routes/routes.dart';
import 'package:get/get.dart';
import 'login_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  double h = 110;
  double w = 110;
  double size = 120;

  AuthController authController = Get.put(AuthController());

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    );

    animationController.forward();

    Future.delayed(const Duration(seconds: 3), () {
      h = 130;
      w = 130;
      size = 140;
      setState(() {});
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      log("Splash : ${authController.isLoggedIn.value}");
      if (authController.isLoggedIn.value) {
        Get.offNamed(Routes.home);
      } else {
        Get.offNamed(Routes.login);
      }
    });
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeTransition(
              opacity: animation,
              child: AnimatedContainer(
                duration: const Duration(seconds: 3),
                height: h,
                width: w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.white,
                  ),
                  image: const DecorationImage(
                    image: NetworkImage(
                        "https://i.pinimg.com/236x/f5/e0/9c/f5e09c13ae3ee7fabed3917ce6568743.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                alignment: Alignment.center,
              ),
            ), // Animated Logo
            const SizedBox(height: 20),
            AnimatedContainer(
              curve: Curves.bounceOut,
              duration: const Duration(
                seconds: 5,
              ),
              // height: h,
              // width: w,
              // decoration: BoxDecoration(
              //   color: Colors.white,
              //   borderRadius: BorderRadius.circular(20),
              // ),
              // alignment: Alignment.center,
              child: const Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            // Obx(
            //   () => Text(authController.isLoggedIn.value.toString()),
            // )
          ],
        ),
      ),
    );
  }
}

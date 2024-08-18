import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hippopants/controllers/auth_controller.dart';
import 'package:hippopants/screens/login_screen.dart';
import 'package:hippopants/screens/profile_screen.dart';

class ProfileWrapper extends GetView<AuthController> {
  const ProfileWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.profile.value != null) {
        return const ProfileScreem();
      }

      return const LoginScreen();
    });
  }
}

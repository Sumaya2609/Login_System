import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../themes/colors.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({super.key});

  final auth = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text("Dashboard"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: auth.logout,
          )
        ],
      ),
      body: Center(
        child: Obx(() {
          final user = auth.currentUser.value;
          return Text(
            user == null ? "Welcome" : "Welcome, ${user.name}",
            style: const TextStyle(fontSize: 22),
          );
        }),
      ),
    );
  }
}

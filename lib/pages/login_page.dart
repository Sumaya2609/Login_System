import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../themes/colors.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final auth = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.lock, size: 80, color: AppColors.primary),
              const SizedBox(height: 20),

              TextField(
                controller: emailCtrl,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  labelText: "Email",
                ),
              ),
              const SizedBox(height: 10),

              TextField(
                controller: passCtrl,
                obscureText: true,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  labelText: "Password",
                ),
              ),
              const SizedBox(height: 20),

              Obx(() => ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  minimumSize: const Size(double.infinity, 45),
                ),
                onPressed: auth.isLoading.value
                    ? null
                    : () => auth.login(
                  emailCtrl.text.trim(),
                  passCtrl.text.trim(),
                ),
                child: auth.isLoading.value
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Login"),
              )),

              TextButton(
                onPressed: () => Get.toNamed('/signup'),
                child: const Text("Don’t have an account? Create Account"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

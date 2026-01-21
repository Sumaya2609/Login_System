import 'package:get/get.dart';
import '../db/db.dart';
import '../models/user_model.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  var currentUser = Rxn<UserModel>();

  Future<void> register(String name, String email, String password) async {
    if (isLoading.value) return;

    isLoading.value = true;
    try {
      final database = await DB.db;


      final existing = await database.query(
        'users',
        where: 'email = ?',
        whereArgs: [email],
      );

      if (existing.isNotEmpty) {
        Get.snackbar("Error", "Email already exists");
        return;
      }

      await database.insert('users', {
        'name': name,
        'email': email,
        'password': password,
      });

      Get.snackbar("Success", "Account created successfully");
      Get.back();
    } catch (e) {
      Get.snackbar("Error", "Registration failed");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> login(String email, String password) async {
    if (isLoading.value) return;

    isLoading.value = true;
    try {
      final database = await DB.db;

      final result = await database.query(
        'users',
        where: 'email = ? AND password = ?',
        whereArgs: [email, password],
      );

      if (result.isNotEmpty) {
        currentUser.value = UserModel.fromMap(result.first);
        Get.offAllNamed('/dashboard');
      } else {
        Get.snackbar("Error", "Invalid email or password");
      }
    } catch (e) {
      Get.snackbar("Error", "Login failed");
    } finally {
      isLoading.value = false;
    }
  }

  void logout() {
    currentUser.value = null;
    Get.offAllNamed('/login');
  }
}

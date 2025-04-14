import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:x_book_shelf/app/data/consts_config.dart';

class SignupController extends GetxController {
  //TODO: Implement SignupController

  var isPasswordHidden = true.obs;
  var isConfirmPasswordHidden = true.obs;
  var isLoading = false.obs;

  // Controllers for input fields
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Reactive variables for validation error messages
  var nameError = ''.obs;
  var emailError = ''.obs;
  var passwordError = ''.obs;
  var confirmPasswordError = ''.obs;

  // Toggles for password visibility
  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordHidden.value = !isConfirmPasswordHidden.value;
  }

  // Validation function
  bool validate() {
    bool isValid = true;

    // Name validation
    if (nameController.text.isEmpty) {
      nameError.value = 'Name is required';
      isValid = false;
    } else {
      nameError.value = '';
    }

    // Email validation
    if (!GetUtils.isEmail(emailController.text)) {
      emailError.value = 'Please enter a valid email';
      isValid = false;
    } else {
      emailError.value = '';
    }

    // Password validation
    if (passwordController.text.length < 6) {
      passwordError.value = 'Password must be at least 6 characters long';
      isValid = false;
    } else {
      passwordError.value = '';
    }

    // Confirm password validation
    if (confirmPasswordController.text != passwordController.text) {
      confirmPasswordError.value = 'Passwords do not match';
      isValid = false;
    } else {
      confirmPasswordError.value = '';
    }

    return isValid;
  }

  Future<void> signUp() async {
    if (!validate()) return; // Do not proceed if validation fails

    try {
      isLoading.value = true;

      // Supabase Auth sign up
      final response = await Supabase.instance.client.auth.signUp(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      final user = response.user;
      String uid = user!.id; // Get the user ID

      // Insert user information into Supabase table 'users'
      await Supabase.instance.client.from('users').insert({
        'uid': uid,
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'profileImageUrl': "", // Default profile picture URL
        'role': 'user',
        'phone': '',
        'password': passwordController.text.trim(),
      });

      Get.offAllNamed('/navigation-screen');
      // Show success message
      Get.snackbar(
        'Success',
        'Account created successfully!',
        snackPosition: SnackPosition.TOP,
        backgroundColor: ConstsConfig.primarycolor,
        colorText: Colors.white,
      );

      isLoading.value = false;
    } catch (e) {
      // Handle sign up error
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.yellow);
      print(e.toString());
      isLoading.value = false;
    }
  }
}

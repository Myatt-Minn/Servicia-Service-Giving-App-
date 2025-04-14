import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginController extends GetxController {
  // Controllers for TextFields
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var signingIn = false.obs;

  var isPasswordHidden = true.obs; // To toggle password visibility
  var isLoading = false.obs; // To show a loading indicator
  var emailError = ''.obs; // Validation error for email
  var passwordError = ''.obs; // Validation error for password
  var generalError = ''.obs; // General error message for login failure

  Future<void> loginUser() async {
    // Clear any previous error messages
    emailError.value = '';
    passwordError.value = '';
    generalError.value = '';

    // Validate input
    if (!validateInput()) {
      return;
    }

    // Start loading
    isLoading.value = true;

    try {
      // Attempt to sign in with email and password using Supabase
      await Supabase.instance.client.auth.signInWithPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Get.offAllNamed('/navigation-screen');
    } catch (e) {
      // Handle login errors
      if (e.toString().contains('user-not-found')) {
        generalError.value = 'No user found with this email.';
      } else if (e.toString().contains('incorrect-password')) {
        generalError.value = 'Incorrect password.';
      } else {
        generalError.value = 'User not Signed Up/Incorrect Password';
      }
    } finally {
      // Stop loading
      isLoading.value = false;
    }
  }

  // Input validation function
  bool validateInput() {
    bool isValid = true;

    // Email validation
    if (emailController.text.trim().isEmpty) {
      emailError.value = 'Please enter your email.';
      isValid = false;
    } else if (!GetUtils.isEmail(emailController.text.trim())) {
      emailError.value = 'Please enter a valid email address.';
      isValid = false;
    }

    // Password validation
    if (passwordController.text.trim().isEmpty) {
      passwordError.value = 'Please enter your password.';
      isValid = false;
    } else if (passwordController.text.trim().length < 6) {
      passwordError.value = 'Password must be at least 6 characters long.';
      isValid = false;
    }

    return isValid;
  }

  // Clear error messages on text change
  void clearErrorMessages() {
    emailError.value = '';
    passwordError.value = '';
    generalError.value = '';
  }

  // Dispose controllers when not needed
  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}

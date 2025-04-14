import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:x_book_shelf/app/data/consts_config.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              // Logo at the top
              Image.asset(
                ConstsConfig.logo, // Replace with your logo path
                height: 150,
              ),

              // Title and subtitle
              Text(
                'Sign In',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text('Welcome Back', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 30),
              // Email input
              Obx(
                () => TextField(
                  controller: controller.emailController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.mail),
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    errorText:
                        controller.emailError.value.isEmpty
                            ? null
                            : controller.emailError.value,
                  ),
                  onChanged: (value) => controller.clearErrorMessages(),
                ),
              ),
              const SizedBox(height: 20),
              // Password input
              Obx(
                () => TextField(
                  controller: controller.passwordController,
                  obscureText: controller.isPasswordHidden.value,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isPasswordHidden.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        controller.isPasswordHidden.value =
                            !controller.isPasswordHidden.value;
                      },
                    ),
                    errorText:
                        controller.passwordError.value.isEmpty
                            ? null
                            : controller.passwordError.value,
                  ),
                  onChanged: (value) => controller.clearErrorMessages(),
                ),
              ),

              const SizedBox(height: 30),
              // Sign In Button
              Obx(
                () =>
                    controller.isLoading.value
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                          onPressed: () {
                            controller.loginUser();
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 100,
                              vertical: 15,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            backgroundColor: ConstsConfig.primarycolor,
                          ),
                          child: Text(
                            'Sign In',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
              ),
              const SizedBox(height: 10),
              // General error message
              Obx(
                () => Text(
                  controller.generalError.value,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Create An Account"),
                  SizedBox(width: 4),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed('/signup');
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        color: ConstsConfig.primarycolor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              // Obx(
              //   () => Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       SizedBox(height: 20),
              //       ElevatedButton(
              //         style: ElevatedButton.styleFrom(
              //           padding: const EdgeInsets.symmetric(
              //               horizontal: 20, vertical: 15),
              //           shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(12),
              //           ),
              //           backgroundColor: Colors.white,
              //         ),
              //         onPressed: controller.isBiometricAvailable.value
              //             ? controller.authenticateAndFetchUserData
              //             : null,
              //         child: Text('Login With FingerPrint?'),
              //       ),
              //       SizedBox(height: 20),
              //     ],
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}

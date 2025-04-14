import 'dart:io';

import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController
  var username = 'User'.obs;
  var isProfileImageChooseSuccess = false.obs;
  var profileImg = "".obs;
  var role = "".obs;
  late File file;

  @override
  void onInit() {
    super.onInit();
    fetchProfileData();
  }

  // Function to retrieve the profile picture from Firestore
  Future<void> fetchProfileData() async {
    try {
      final supabase = Supabase.instance.client;

      // Retrieve user data from Supabase `users` table
      final userResponse =
          await supabase
              .from('users')
              .select()
              .eq(
                'uid',
                Supabase.instance.client.auth.currentSession!.user.id,
              ) // Replace `id` with your user table's primary key column
              .single();

      if (userResponse.isNotEmpty) {
        final data = userResponse;
        profileImg.value = data['profileImageUrl'] ?? '';
        username.value = data['name'] ?? '';
        role.value = data['role'] ?? 'user';

        isProfileImageChooseSuccess.value = true;
      } else {
        Get.snackbar('Error', 'User document does not exist.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to retrieve profile picture.');
      print('Error: $e');
    }
  }

  void signOut() {
    Supabase.instance.client.auth.signOut();
    Get.offAllNamed('/login');
  }
}

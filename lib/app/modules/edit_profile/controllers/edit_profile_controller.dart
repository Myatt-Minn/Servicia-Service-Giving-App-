import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:x_book_shelf/app/data/consts_config.dart';
import 'package:x_book_shelf/app/modules/profile/controllers/profile_controller.dart';

class EditProfileController extends GetxController {
  // Reactive variables for the profile fields
  var fullName = ''.obs;
  var phoneNumber = ''.obs;
  final SupabaseClient supabase = Supabase.instance.client;
  var userId = Supabase.instance.client.auth.currentSession!.user.id;
  var isLoading = false.obs;
  var isProfileImageChooseSuccess = false.obs;
  var profileImg = "".obs;

  late File file;
  // Text controllers for the TextFields
  late TextEditingController fullNameController;
  late TextEditingController phoneController;

  // Show error message if validation fails
  var showError = false.obs;
  @override
  void onReady() {
    super.onReady();
    isProfileImageChooseSuccess.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    fullNameController = TextEditingController();
    phoneController = TextEditingController();

    fetchUserData(); // Fetch user data when the controller initializes
  }

  // Fetch current user data from Supabase
  void fetchUserData() async {
    try {
      final response =
          await supabase
              .from('users')
              .select()
              .eq('uid', userId) // Assuming 'id' is the unique identifier
              .single();

      if (response.isNotEmpty) {
        final user = response;
        fullName.value = user['name'] ?? '';
        phoneNumber.value = user['phone'] ?? ''; // Fetch phone number
        profileImg.value = user['profileImageUrl'] ?? '';

        // Set values in TextControllers for initial state
        fullNameController.text = fullName.value;
        phoneController.text = phoneNumber.value; // Set phone number
      } else {
        Get.snackbar('Error', 'Failed to load user data.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load user data.');
    }
  }

  // Validate fields
  bool validateFields() {
    return fullNameController.text.isNotEmpty &&
        phoneController.text.isNotEmpty;
  }

  // Check if a field is empty
  bool isEmpty(TextEditingController controller) {
    return controller.text.isEmpty;
  }

  // Update user profile data in Supabase
  void updateUserProfile() async {
    if (!validateFields()) {
      showError.value = true;
      return;
    }

    try {
      isLoading.value = true;

      // Upload image if necessary
      await uploadImage(file);

      await supabase
          .from('users')
          .update({
            'name': fullNameController.text,
            'phone': phoneController.text, // Add phone number
            'profileImageUrl': profileImg.value,
          })
          .eq('uid', userId); // Update the user with matching userId

      Get.find<ProfileController>().fetchProfileData();
      Get.snackbar(
        'Success',
        'Profile updated successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: ConstsConfig.primarycolor,
        colorText: Colors.black,
      );
      isLoading.value = false;
    } catch (e) {
      Get.snackbar('Error', 'Failed to update profile.');
      isLoading.value = false;
    }
  }

  // Function to choose an image from File Picker
  Future<void> chooseImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      file = File(result.files.single.path!);
      isProfileImageChooseSuccess.value = true;
    } else {
      Get.snackbar("Cancel", "No Image");
    }
  }

  Future<void> uploadImage(File imageFile) async {
    try {
      if (isProfileImageChooseSuccess.value) {
        // Get the file name, could use a unique ID or timestamp
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();

        // Upload image to Supabase storage bucket
        await supabase.storage
            .from('profiles') // Assuming 'profile_images' is your bucket name
            .upload(fileName, imageFile);

        // Get the public URL of the uploaded image
        final publicUrl = supabase.storage
            .from('profiles')
            .getPublicUrl(fileName);
        profileImg.value = publicUrl;
      } else {
        Get.snackbar(
          'Image picking failed',
          'Sorry, the image is not picked!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }
}

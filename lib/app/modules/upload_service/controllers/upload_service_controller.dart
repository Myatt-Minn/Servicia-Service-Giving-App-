import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:x_book_shelf/app/data/ProviderModel.dart';

class UploadServiceController extends GetxController {
  // Text controllers
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final categoryController = TextEditingController();
  final priceController = TextEditingController();
  final pricingTypeController = TextEditingController();
  final locationController = TextEditingController();
  final phoneNumberController = TextEditingController();
  var userId = Supabase.instance.client.auth.currentSession!.user.id;
  var provider = Rxn<ProviderModel>();
  // State
  final isLoading = false.obs;
  final isImagePicked = false.obs;
  final imagePath = ''.obs;

  final supabase = Supabase.instance.client;

  @override
  void onInit() {
    super.onInit();
    fetchProviderData();
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      imagePath.value = picked.path;
      isImagePicked.value = true;
    }
  }

  void fetchProviderData() async {
    try {
      final response =
          await supabase
              .from('users')
              .select()
              .eq('uid', userId) // Replace 'userId' with actual provider's ID
              .single();

      if (response.isNotEmpty) {
        provider.value = ProviderModel.fromMap(response);

        // (Optional) If you want to pre-fill other fields, like bio:
        // bioController.text = provider.bio;
      } else {
        Get.snackbar('Error', 'Provider not found.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load provider data: $e');
    }
  }

  Future<void> uploadService() async {
    if (!_validateInputs()) return;

    isLoading.value = true;

    try {
      // 1. Upload image to Supabase Storage
      final imageFile = File(imagePath.value);
      final fileName = 'services/${DateTime.now().millisecondsSinceEpoch}.jpg';

      await supabase.storage.from('services').upload(fileName, imageFile);

      final imageUrl = supabase.storage.from('services').getPublicUrl(fileName);

      // 2. Insert service into Supabase DB
      final currentUserId = supabase.auth.currentUser?.id;
      if (currentUserId == null) {
        Get.snackbar('Error', 'User not authenticated');
        isLoading.value = false;
        return;
      }
      var serviceId = Uuid().v4();
      await supabase.from('services').insert({
        'title': titleController.text.trim(),
        'description': descriptionController.text.trim(),
        'category': categoryController.text.trim(),
        'price': int.parse(priceController.text),
        'pricingType': pricingTypeController.text.trim(),
        'provider': provider.value!.toMap(),
        'location': locationController.text.trim(),
        'imageUrl': imageUrl,
        'rating': 4.5,
        'popular': true,
        'phoneNumber': phoneNumberController.text.trim(),
        'createdAt': DateTime.now().toIso8601String(),
        'service_id': serviceId,
      });
      await addServiceToProvider(
        serviceId: serviceId,
        uid: provider.value!.uid,
      );
      Get.back();
      Get.snackbar(
        'Success',
        'Service uploaded!',
        backgroundColor: Colors.blue,
      );
      _resetForm();
    } catch (e) {
      Get.snackbar('Upload Failed', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  bool _validateInputs() {
    if (titleController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        categoryController.text.isEmpty ||
        priceController.text.isEmpty ||
        pricingTypeController.text.isEmpty ||
        locationController.text.isEmpty ||
        phoneNumberController.text.isEmpty ||
        imagePath.value.isEmpty) {
      Get.snackbar(
        'Missing Fields',
        'Please fill in all fields and pick an image.',
        backgroundColor: Colors.yellow,
      );
      return false;
    }
    return true;
  }

  Future<void> addServiceToProvider({
    required String uid,
    required String serviceId,
  }) async {
    try {
      final supabase = Supabase.instance.client;

      // 1. Fetch current list
      final response =
          await supabase
              .from('users')
              .select('givenServices')
              .eq('uid', uid)
              .single();

      final currentServices =
          (response['givenServices'] as List<dynamic>?)?.cast<String>() ?? [];

      // 2. Avoid duplicates
      if (!currentServices.contains(serviceId)) {
        currentServices.add(serviceId);

        // 3. Update user with new list
        await supabase
            .from('users')
            .update({'givenServices': currentServices})
            .eq('uid', uid);

        Get.snackbar('Success', 'Service added to provider.');
      } else {
        Get.snackbar('Info', 'Service already exists in provider\'s list.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to add service: $e');
      print(e);
    }
  }

  void _resetForm() {
    titleController.clear();
    descriptionController.clear();
    categoryController.clear();
    priceController.clear();
    pricingTypeController.clear();
    locationController.clear();
    phoneNumberController.clear();
    imagePath.value = '';
    isImagePicked.value = false;
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    categoryController.dispose();
    priceController.dispose();
    pricingTypeController.dispose();
    locationController.dispose();
    phoneNumberController.dispose();
    super.onClose();
  }
}

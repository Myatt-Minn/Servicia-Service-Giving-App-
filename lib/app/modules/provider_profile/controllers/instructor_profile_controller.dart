import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:x_book_shelf/app/data/ProviderModel.dart';
import 'package:x_book_shelf/app/data/ServiceModel.dart';

class AuthorProfileController extends GetxController {
  //TODO: Implement InstructorProfileController
  final supabase = Supabase.instance.client;
  var services = <ServiceModel>[].obs;
  var instructor = Rxn<ProviderModel>();
  var isLoading = false.obs;
  @override
  void onInit() async {
    super.onInit();
    isLoading.value = true;
    await fetchProviderById(Get.arguments);
    await fetchservices(instructor.value!.givenServices);
    isLoading.value = false;
  }

  Future<void> fetchProviderById(String providerId) async {
    try {
      final response =
          await supabase.from('users').select().eq('uid', providerId).single();

      instructor.value = ProviderModel.fromMap(response);
    } catch (e) {
      print('Error fetching provider: $e');
    }
  }

  Future<void> deleteServiceById(String serviceId) async {
    try {
      await supabase.from('services').delete().eq('service_id', serviceId);

      Get.snackbar(
        'Success',
        'Service deleted successfully.',
        backgroundColor: Colors.green,
      );
      await fetchservices(instructor.value!.givenServices);
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e');
    }
  }

  Future<void> fetchservices(List<String> courseIds) async {
    try {
      final supabase = Supabase.instance.client;

      final response = await supabase
          .from('services')
          .select()
          .filter('service_id', 'in', courseIds);

      services.value =
          response
              .map<ServiceModel>((video) => ServiceModel.fromMap(video))
              .toList();
    } catch (e) {
      print(e);
    }
  }
}

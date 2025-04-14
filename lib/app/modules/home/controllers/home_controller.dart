import 'dart:async';

import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:x_book_shelf/app/data/ServiceModel.dart';

class HomeController extends GetxController {
  RxList<ServiceModel> bookList = <ServiceModel>[].obs;
  RxList<ServiceModel> popularbooks = <ServiceModel>[].obs;

 

  var isLoading = true.obs;

  @override
  void onInit() async {
    super.onInit();
    await fetchbooks();
    await fetchPopular();
    isLoading.value = false;
  }



  Future<void> fetchbooks() async {
    try {
      final response =
          await Supabase.instance.client
              .from('services') // Replace with your table name
              .select();

      bookList.value =
          (response as List).map((item) {
            // Ensure that the data is in the correct format
            return ServiceModel.fromMap(item as Map<String, dynamic>);
          }).toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch books $e');
    }
  }

  Future<void> fetchPopular() async {
    try {
      final response = await Supabase.instance.client
          .from('services') // Replace with your table name
          .select()
          .eq('popular', true) // Filter for popular books
          ;

      popularbooks.value =
          (response as List).map((item) {
            return ServiceModel.fromMap(item as Map<String, dynamic>);
          }).toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch popular books');
    }
  }

}

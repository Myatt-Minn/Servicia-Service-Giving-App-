import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:x_book_shelf/app/data/ServiceModel.dart';

class AllBooksController extends GetxController {
  //TODO: Implement AllBooksController

  RxList<ServiceModel> books = <ServiceModel>[].obs; // List of all books
  RxList<ServiceModel> filteredbooks =
      <ServiceModel>[].obs; // Filtered list based on search
  RxString searchQuery = ''.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchbooks();
  }

  Future<void> fetchbooks() async {
    try {
      isLoading.value = true;

      // Query Supabase to fetch all books
      final response = await Supabase.instance.client.from('services').select('*');

      // Map Supabase data to the book model
      books.value =
          (response as List<dynamic>).map((data) {
            return ServiceModel.fromMap(data as Map<String, dynamic>);
          }).toList();

      isLoading.value = false;
      filteredbooks.assignAll(books);
    } catch (e, stacktrace) {
      print('Error: $e');
      print('Stacktrace: $stacktrace');

      // Display error in the UI
      Get.snackbar(
        'Error',
        'Failed to fetch books',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void searchbooks(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      filteredbooks.assignAll(books);
    } else {
      filteredbooks.assignAll(
        books
            .where(
              (book) => book.title.toString().toLowerCase().contains(
                query.toLowerCase(),
              ),
            )
            .toList(),
      );
    }
  }
}

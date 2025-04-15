import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:share_plus/share_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:x_book_shelf/app/data/ServiceModel.dart';

class BookDetailsController extends GetxController {
  //TODO: Implement BookDetailsController

  final box = GetStorage();
  var recommendedBooks = <ServiceModel>[].obs;
  ServiceModel book = Get.arguments;
  @override
  void onInit() {
    super.onInit();
    fetchRecommendedBooks(book.category);
  }

  Future<void> fetchRecommendedBooks(String category) async {
    try {
      final response = await Supabase.instance.client
          .from('services')
          .select()
          .eq('category', category) // Filter by category
          .limit(10); // Limit to 10 books

      // Assuming your data is returned as a list
      recommendedBooks.value =
          (response as List)
              .map((item) => ServiceModel.fromMap(item as Map<String, dynamic>))
              .toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch services');
    }
  }

  void shareBook(ServiceModel book) {
    final text = '${book.title} by ${book.provider.name}';
    Share.share(text);
  }

  Future<void> makePhoneCall() async {
    final Uri launchUri = Uri(scheme: 'tel', path: book.phoneNumber);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      Get.snackbar(
        'Cannot open Phone App',
        'Something went wrong!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}

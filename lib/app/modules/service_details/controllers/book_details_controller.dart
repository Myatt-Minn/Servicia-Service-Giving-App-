import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:share_plus/share_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:x_book_shelf/app/data/OrderModel.dart';
import 'package:x_book_shelf/app/data/ServiceModel.dart';

class BookDetailsController extends GetxController {
  //TODO: Implement serviceDetailsController
  TextEditingController addressController = TextEditingController();
  TextEditingController serviceDateController = TextEditingController();
  var serviceingDate = DateTime.now().obs;
  final box = GetStorage();
  var recommendedservices = <ServiceModel>[].obs;
  ServiceModel service = Get.arguments;
  var role = ''.obs;
  @override
  void onInit() {
    super.onInit();
    fetchProfileData();
    fetchRecommendedservices(service.category);
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

        role.value = data['role'] ?? 'user';
      } else {
        Get.snackbar('Error', 'User document does not exist.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to retrieve profile picture.');
      print('Error: $e');
    }
  }

  Future<void> fetchRecommendedservices(String category) async {
    try {
      final response = await Supabase.instance.client
          .from('services')
          .select()
          .eq('category', category) // Filter by category
          .limit(10); // Limit to 10 services

      // Assuming your data is returned as a list
      recommendedservices.value =
          (response as List)
              .map((item) => ServiceModel.fromMap(item as Map<String, dynamic>))
              .toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch services');
    }
  }

  void shareservice(ServiceModel service) {
    final text = '${service.title} by ${service.provider.name}';
    Share.share(text);
  }

  // Function to open the date picker and update the selected date
  Future<void> selectServiceDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Set the initial date
      firstDate: DateTime(2000), // Set the earliest date
      lastDate: DateTime(2100), // Set the latest date
    );

    if (pickedDate != null && pickedDate != serviceingDate.value) {
      serviceingDate.value = pickedDate;
    }
  }

  Future<void> addOrder() async {
    final supabase = Supabase.instance.client;

    try {
      OrderModel order = OrderModel(
        serviceId: service.id,
        serviceTitle: service.title,
        customerId: Supabase.instance.client.auth.currentUser!.id,
        providerId: service.provider.uid,
        serviceingDate: serviceingDate.value,
        createdAt: DateTime.now(),
        status: "pending",
        totalPrice: service.price,
        address: addressController.text,
      );

      await supabase.from('orders').insert(order.toMap()).select().single();

      Get.back();
      Get.snackbar(
        "Success",
        "This Service is Booked Successfully!",
        backgroundColor: Colors.green,
      );
    } catch (e) {
      print("Error adding order: $e");
      rethrow; // or handle however you want
    }
  }
}

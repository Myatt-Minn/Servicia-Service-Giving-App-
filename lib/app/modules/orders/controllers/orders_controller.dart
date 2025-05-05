import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:x_book_shelf/app/data/OrderModel.dart';

class OrdersController extends GetxController {
  //TODO: Implement OrdersController

  final supabase = Supabase.instance.client;
  var role = ''.obs;
  var isLoading = true.obs;
  var orders = <OrderModel>[].obs;
  var isCanceling = false.obs;
  @override
  void onInit() async {
    super.onInit();
    await fetchProfileData();
    await fetchOrders();
    isLoading.value = false;
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

  Future<void> fetchOrders() async {
    try {
      final user = supabase.auth.currentUser;
      if (user == null) throw Exception("User not logged in");
      PostgrestList response;
      if (role.value == 'provider') {
        response = await supabase
            .from('orders')
            .select()
            .eq('providerId', user.id)
            .order('createdAt', ascending: false);
      } else {
        response = await supabase
            .from('orders')
            .select()
            .eq('customerId', user.id)
            .order('createdAt', ascending: false);
      }

      orders.value =
          (response as List).map((e) => OrderModel.fromMap(e)).toList();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> deleteOrder(int orderId) async {
    final supabase = Supabase.instance.client;
    isCanceling.value = true;
    try {
      await supabase
          .from('orders')
          .update({'status': 'cancelled'})
          .eq('id', orderId);

      await fetchOrders();
      Get.back();
      Get.snackbar(
        "Success",
        "Booking canceled successfully!",
        backgroundColor: Colors.green,
      );
      isCanceling.value = false;
    } catch (e) {
      isCanceling.value = false;
      print("Error deleting order: $e");
      rethrow;
    }
  }

  Future<void> confirmOrder(int orderId) async {
    final supabase = Supabase.instance.client;
    isCanceling.value = true;
    try {
      await supabase
          .from('orders')
          .update({'status': 'confirmed'})
          .eq('id', orderId);

      await fetchOrders();
      Get.back();
      Get.snackbar(
        "Success",
        "Booking canceled successfully!",
        backgroundColor: Colors.green,
      );
      isCanceling.value = false;
    } catch (e) {
      isCanceling.value = false;
      print("Error deleting order: $e");
      rethrow;
    }
  }
}

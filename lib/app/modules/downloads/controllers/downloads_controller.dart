import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:x_book_shelf/app/data/OrderModel.dart';

class DownloadsController extends GetxController {
  //TODO: Implement DownloadsController

   RxList<OrderModel> downloadedBooks = <OrderModel>[].obs;
 Future<void> fetchbooks() async {
    try {
      final response =
          await Supabase.instance.client
              .from('orders') // Replace with your table name
              .select();

      downloadedBooks.value =
          (response as List).map((item) {
            // Ensure that the data is in the correct format
            return OrderModel.fromMap(item as Map<String, dynamic>);
          }).toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to orders $e');
    }
  }

}

import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:x_book_shelf/app/data/ProviderModel.dart';

class AuthorController extends GetxController {
  //TODO: Implement AuthorController
  var selectedauthor = 'author'.obs; // Observable for author selection
  var isLoading = false.obs;
  var authors = <ProviderModel>[].obs;
  var filterauthors = <ProviderModel>[].obs;
  RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProviders();
  }

  final SupabaseClient supabase = Supabase.instance.client;

  Future<void> fetchProviders() async {
    isLoading.value = true;
    try {
      final response = await supabase
          .from('users')
          .select()
          .eq('role', 'provider'); // Filter only providers

      authors.value =
          (response as List).map((item) {
            return ProviderModel.fromMap(item);
          }).toList();

      filterauthors.assignAll(authors);
      isLoading.value = false;
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch providers: $e');
      isLoading.value = false;
    }
  }

  void searchProducts(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      filterauthors.assignAll(authors);
    } else {
      filterauthors.assignAll(
        authors
            .where(
              (product) =>
                  product.name.toLowerCase().contains(query.toLowerCase()),
            )
            .toList(),
      );
    }
  }
}

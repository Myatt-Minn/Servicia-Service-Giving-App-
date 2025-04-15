import 'package:get/get.dart';

import '../controllers/all_popular_books_controller.dart';

class AllPopularBooksBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllPopularBooksController>(
      () => AllPopularBooksController(),
    );
  }
}

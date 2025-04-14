import 'package:get/get.dart';

import '../controllers/all_books_controller.dart';

class AllBooksBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllBooksController>(
      () => AllBooksController(),
    );
  }
}

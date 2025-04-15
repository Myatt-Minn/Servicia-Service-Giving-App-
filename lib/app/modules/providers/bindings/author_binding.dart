import 'package:get/get.dart';

import '../controllers/author_controller.dart';

class AuthorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthorController>(
      () => AuthorController(),
    );
  }
}

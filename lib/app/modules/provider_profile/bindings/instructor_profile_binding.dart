import 'package:get/get.dart';

import '../controllers/instructor_profile_controller.dart';

class AuthorProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthorProfileController>(() => AuthorProfileController());
  }
}

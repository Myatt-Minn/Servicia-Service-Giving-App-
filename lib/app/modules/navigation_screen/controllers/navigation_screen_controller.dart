import 'package:get/get.dart';
import 'package:x_book_shelf/app/modules/home/controllers/home_controller.dart';
import 'package:x_book_shelf/app/modules/profile/controllers/profile_controller.dart';
import 'package:x_book_shelf/app/modules/providers/controllers/author_controller.dart';

class NavigationScreenController extends GetxController {
  //TODO: Implement NavigationScreenController
  var currentIndex = 0.obs;

  @override
  void onInit() async {
    super.onInit();
    initializeController(currentIndex.value);
    // await SendNotificationHandler().initNotification();
  }

  void initializeController(int index) {
    // Initialize the corresponding controller based on the selected index
    switch (index) {
      case 0:
        Get.put(HomeController());
        break;
      case 1:
        Get.put(AuthorController());
        break;
      case 2:
        Get.put(ProfileController());
        break;
    }
  }

  void disposeController(int index) {
    // Delete the controller from memory when navigating away
    switch (index) {
      case 0:
        Get.delete<HomeController>();
      case 1:
        Get.delete<AuthorController>();
        break;
      case 3:
        Get.delete<ProfileController>();
        break;
    }
  }
}

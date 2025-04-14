import 'package:get/get.dart';

import '../controllers/upload_service_controller.dart';

class UploadServiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UploadServiceController>(
      () => UploadServiceController(),
    );
  }
}

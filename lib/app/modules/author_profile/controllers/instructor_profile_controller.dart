import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:x_book_shelf/app/data/ProviderModel.dart';
import 'package:x_book_shelf/app/data/ServiceModel.dart';

class AuthorProfileController extends GetxController {
  //TODO: Implement InstructorProfileController

  var books = <ServiceModel>[].obs;
  ProviderModel instructor = Get.arguments;
  @override
  void onInit() {
    super.onInit();
    fetchbooks(instructor.givenServices);
  }

  Future<void> fetchbooks(List<String> courseIds) async {
    try {
      final supabase = Supabase.instance.client;

      final response = await supabase
          .from('services')
          .select()
          .filter('service_id', 'in', courseIds);

      books.value =
          response
              .map<ServiceModel>((video) => ServiceModel.fromMap(video))
              .toList();
    } catch (e) {
      print(e);
    }
  }
}

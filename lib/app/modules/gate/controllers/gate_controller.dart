import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GateController extends GetxController {
  var isLoading = false.obs;
  final supabase = Supabase.instance.client; // Supabase client instance

  @override
  void onInit() {
    super.onInit();

    // Initial check for internet and authentication
    checkAuthentication();
  }

  void checkAuthentication() async {
    isLoading.value = true; // Show loading while checking authentication
    final session = supabase.auth.currentSession;

    if (session == null) {
      Get.offAllNamed('/login');

      isLoading.value = false;
    } else {
      final userId = session.user.id;
      if (userId.isNotEmpty) {
        try {
          final response =
              await supabase
                  .from('users')
                  .select()
                  .eq('uid', userId)
                  .single(); // Fetch user data from Supabase

          if (response.isNotEmpty) {
            final userData = response;
            if (userData['role'] == 'provider') {
              Get.offAllNamed('/admin-dashboard');
            } else {
              Get.offAllNamed('/navigation-screen');
            }
          } else {
            Get.offAllNamed('/login');
          }
        } catch (error) {
          print('Error fetching user data: $error');
          Get.offAllNamed('/login');
        }
      } else {
        Get.offAllNamed('/login');
      }
    }
    isLoading.value = false; // Stop loading after the check
  }
}

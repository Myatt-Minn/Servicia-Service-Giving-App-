import 'package:get/get.dart';

import '../modules/all_books/bindings/all_books_binding.dart';
import '../modules/all_books/views/all_books_view.dart';
import '../modules/all_popular_books/bindings/all_popular_books_binding.dart';
import '../modules/all_popular_books/views/all_popular_books_view.dart';
import '../modules/author/bindings/author_binding.dart';
import '../modules/author/views/author_view.dart';
import '../modules/author_profile/bindings/instructor_profile_binding.dart';
import '../modules/author_profile/views/instructor_profile_view.dart';
import '../modules/book_details/bindings/book_details_binding.dart';
import '../modules/book_details/views/book_details_view.dart';
import '../modules/downloads/bindings/downloads_binding.dart';
import '../modules/downloads/views/downloads_view.dart';
import '../modules/edit_profile/bindings/edit_profile_binding.dart';
import '../modules/edit_profile/views/edit_profile_view.dart';
import '../modules/gate/bindings/gate_binding.dart';
import '../modules/gate/views/gate_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/navigation_screen/bindings/navigation_screen_binding.dart';
import '../modules/navigation_screen/views/navigation_screen_view.dart';
import '../modules/privacy_policy/bindings/privacy_policy_binding.dart';
import '../modules/privacy_policy/views/privacy_policy_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/provider_signup/bindings/provider_signup_binding.dart';
import '../modules/provider_signup/views/provider_signup_view.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/upload_service/bindings/upload_service_binding.dart';
import '../modules/upload_service/views/upload_service_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.NAVIGATION_SCREEN,
      page: () => NavigationScreenView(),
      binding: NavigationScreenBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.DOWNLOADS,
      page: () => const DownloadsView(),
      binding: DownloadsBinding(),
    ),
    GetPage(
      name: _Paths.AUTHOR,
      page: () => const AuthorView(),
      binding: AuthorBinding(),
    ),
    GetPage(
      name: _Paths.BOOK_DETAILS,
      page: () => const BookDetailsView(),
      binding: BookDetailsBinding(),
    ),
    GetPage(
      name: _Paths.AUTHOR_PROFILE,
      page: () => const AuthorProfileView(),
      binding: AuthorProfileBinding(),
    ),
    GetPage(
      name: _Paths.GATE,
      page: () => const GateView(),
      binding: GateBinding(),
    ),
    GetPage(
      name: _Paths.ALL_BOOKS,
      page: () => const AllBooksView(),
      binding: AllBooksBinding(),
    ),
    GetPage(
      name: _Paths.ALL_POPULAR_BOOKS,
      page: () => const AllPopularBooksView(),
      binding: AllPopularBooksBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => const SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => const EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: _Paths.PROVIDER_SIGNUP,
      page: () => const ProviderSignupView(),
      binding: ProviderSignupBinding(),
    ),
    GetPage(
      name: _Paths.UPLOAD_SERVICE,
      page: () => const UploadServiceView(),
      binding: UploadServiceBinding(),
    ),
    GetPage(
      name: _Paths.PRIVACY_POLICY,
      page: () => const PrivacyPolicyView(),
      binding: PrivacyPolicyBinding(),
    ),
  ];
}

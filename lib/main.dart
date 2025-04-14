import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:x_book_shelf/app/data/consts_config.dart';
import 'package:x_book_shelf/app/modules/splash/bindings/splash_binding.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  await Supabase.initialize(
    url: "https://afqqtesrmxwxzpmvncwy.supabase.co",
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFmcXF0ZXNybXh3eHpwbXZuY3d5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDQ0Nzc5NTIsImV4cCI6MjA2MDA1Mzk1Mn0.JrzzM5ercSLxDQ9lxwyv9PBQSAF0qYZlk7F7o4IPGAc',
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
  
    runApp(
      BetterFeedback(
        child: GetMaterialApp(
   
       
          title: ConstsConfig.appname,
          debugShowCheckedModeBanner: false,
       
          //initialRoute: isFirstTime ? AppPages.ON_BOARDING : AppPages.MY_HOME,
          initialRoute: AppPages.INITIAL,
          initialBinding: SplashBinding(),
          getPages: AppPages.routes,
        ),
      ),
    );
  });
}

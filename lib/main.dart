import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'config/routes.dart';
import 'config/themes.dart';
import 'services/auth_service.dart';
import 'services/food_service.dart';
import 'services/order_service.dart';
import 'firebase_options.dart'; // Add this line

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // 👈 This is the fix
  );

  // Register Services
  Get.put(AuthService());
  Get.put(FoodService());
  Get.put(OrderService());

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'FoodMarket',
      theme: AppTheme.theme,
      initialRoute: '/splash',
      getPages: AppRoutes.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}

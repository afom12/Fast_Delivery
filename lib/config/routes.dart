// lib/config/routes.dart
import 'package:get/get.dart';
import '../screens/splash/splash_screen.dart';
import '../screens/auth/sign_in_screen.dart';
import '../screens/auth/sign_up_screen.dart';
import '../screens/auth/address_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/food/food_details_screen.dart';
import '../screens/order/order_screen.dart';
import '../screens/order/order_detail_screen.dart';
import '../screens/order/order_success_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/payment/payment_screen.dart';

class AppRoutes {
  static final routes = [
    GetPage(
      name: '/splash',
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: '/sign-in',
      page: () => SignInScreen(),
    ),
    GetPage(
      name: '/sign-up',
      page: () => SignUpScreen(),
    ),
    GetPage(
      name: '/address',
      page: () => AddressScreen(),
    ),
    GetPage(
      name: '/home',
      page: () => HomeScreen(),
    ),
    GetPage(
      name: '/food-details',
      page: () => const FoodDetailsScreen(),
    ),
    GetPage(
      name: '/orders',
      page: () => const OrderScreen(),
    ),
    GetPage(
      name: '/order-detail',
      page: () => const OrderDetailScreen(),
    ),
    GetPage(
      name: '/order-success',
      page: () => const OrderSuccessScreen(),
    ),
    GetPage(
      name: '/profile',
      page: () => ProfileScreen(),
    ),
    GetPage(
      name: '/payment',
      page: () => PaymentScreen(),
    ),
  ];
}

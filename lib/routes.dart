import 'package:get/get.dart';
import 'package:pharmacy_managment_system/binding/home_binding.dart';
import 'package:pharmacy_managment_system/view/screen/admin/admin_screen.dart';
import 'package:pharmacy_managment_system/view/screen/drug/display_drug_screen.dart';
import 'package:pharmacy_managment_system/view/screen/favorite/favorite_screen.dart';
import 'package:pharmacy_managment_system/view/screen/image/image_screen.dart';
import 'package:pharmacy_managment_system/view/screen/order/add_order_screen.dart';

import 'core/constant/routes_name.dart';
import 'core/middleware/middleware.dart';
import 'view/screen/auth/login_screen.dart';
import 'view/screen/auth/register_screen.dart';
import 'view/screen/auth/success_screen.dart';
import 'view/screen/category/add_category_screen.dart';
import 'view/screen/category/category_screen.dart';
import 'view/screen/drug/add_drug_screen.dart';
import 'view/screen/drug/drug_screen.dart';
import 'view/screen/home/home.dart';
import 'view/screen/on_boarding/on_boarding_screen.dart';
import 'view/screen/order/order_screen.dart';
import 'view/screen/splash/splash_screen.dart';

List<GetPage<dynamic>> routes = [
  GetPage(name: AppRoute.splashPage, page: () => const SplashScreen()),
  GetPage(
    name: AppRoute.onBoardingPage,
    page: () => const OnBoardingScreen(),
    middlewares: [MyMiddleware()],
  ),
  GetPage(name: AppRoute.loginPage, page: () => const LoginScreen()),
  GetPage(name: AppRoute.registerPage, page: () => const RegisterScreen()),
  GetPage(name: AppRoute.successPage, page: () => const SuccessScreen()),
  GetPage(
    name: AppRoute.homePage,
    page: () => const HomePage(),
    binding: HomeBinding(),
  ),
  GetPage(name: AppRoute.categoryPage, page: () => const CategoryScreen()),
  GetPage(
      name: AppRoute.addCategoryPage, page: () => const AddCategoryScreen()),
  GetPage(name: AppRoute.drugPage, page: () => const DrugScreen()),
  GetPage(name: AppRoute.addDrugPage, page: () => const AddDrugScreen()),
  GetPage(
      name: AppRoute.displayDrugPage, page: () => const DisplayDrugScreen()),
  GetPage(name: AppRoute.adminPage, page: () => const AdminScreen()),
  GetPage(name: AppRoute.addOrderPage, page: () => const AddOrderScreen()),
  GetPage(name: AppRoute.orderPage, page: () => const OrderScreen()),
  GetPage(name: AppRoute.favoritePage, page: () => const FavoriteScreen()),
];

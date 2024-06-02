import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:shoesly/app_routes/routes_const.dart';
import 'package:shoesly/screens/cart_screen/screen/cart_screen.dart';
import 'package:shoesly/screens/discover_screen/screens/discover_detail_screen.dart';
import 'package:shoesly/screens/discover_screen/screens/discover_screen.dart';
import 'package:shoesly/screens/discover_screen/screens/product_filter_screen.dart';
import 'package:shoesly/screens/order_summary_screen/order_summary_screen.dart';
import 'package:shoesly/screens/reviews_screen/screens/all_review_screen.dart';

class MyRoute {
  static final routes = [
    GetPage(
        name: AppRouteConst.discoverScreen,
        page: () => const DiscoverScreen(),
        transition: Transition.fadeIn
    ),
    GetPage(
        name: AppRouteConst.discoverDetailScreen,
        page: () => const DiscoverDetailScreen(),
        transition: Transition.fadeIn
    ),
    GetPage(
        name: AppRouteConst.allReviewScreen,
        page: () => AllReviewScreen(),
        transition: Transition.fadeIn
    ),
    GetPage(
        name: AppRouteConst.cartScreen,
        page: () => const CartScreen(),
        transition: Transition.fadeIn
    ),
    GetPage(
        name: AppRouteConst.orderSummaryScreen,
        page: () => const OrderSummaryScreen(),
        transition: Transition.fadeIn
    ),
    GetPage(
        name: AppRouteConst.productFilterScreen,
        page: () => const ProductFilterScreen(),
        transition: Transition.fadeIn
    ),
  ];
}

import '../global/singelton_class.dart';

class AppRouteConst {

  AppRouteConst._();

  static AppRouteConst getInstance() {
    return Singleton(AppRouteConst, () => AppRouteConst._()) as AppRouteConst;
  }

  static const discoverScreen = "/discover_screen";
  static const discoverDetailScreen = "/discover_detail_screen";
  static const allReviewScreen = "/all_review_screen";
  static const cartScreen = "/cart_screen";
  static const orderSummaryScreen = "/order_summary_screen";
  static const productFilterScreen = "/product_filter_screen";
}
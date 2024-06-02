import 'package:shoesly/constants/colors.dart';
import 'package:shoesly/global/custom_dialogue_box.dart';

import '../constants/enum.dart';
import '../global/singelton_class.dart';
import 'package:http/http.dart' as http;

import '../screens/cart_screen/model/cart_model.dart';
import '../screens/discover_screen/models/product_image_model.dart';
import '../screens/discover_screen/models/products_model.dart';
import '../screens/discover_screen/models/users_model.dart';
import '../screens/reviews_screen/model/reviews_model.dart';

class ModelHandler {
  ModelHandler._();

  static ModelHandler getInstance() {
    return Singleton(ModelHandler, () => ModelHandler._()) as ModelHandler;
  }

  static addDataToModel(
      {MH? modelManager, http.Response? response, var decodedResponse}) {
    switch (modelManager ?? "") {
      case MH.products:
        return productsModelFromJson(response!.body);
      case MH.productImages:
        return productsImagesModelFromJson(response!.body);
      case MH.users:
        return usersModelFromJson(response!.body);
      case MH.reviews:
        return reviewsModelFromJson(response!.body);
      case MH.cart:
        return cartModelFromJson(response!.body);
      default:
        break;
    }
  }
}

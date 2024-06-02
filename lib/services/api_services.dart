import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/route_manager.dart';
import 'package:shoesly/constants/colors.dart';
import 'package:shoesly/constants/controllers.dart';
import 'package:shoesly/global/custom_dialogue_box.dart';
import 'package:shoesly/screens/cart_screen/model/cart_model.dart';
import 'package:shoesly/services/response_handler.dart';

import '../constants/enum.dart';
import '../global/singelton_class.dart';
import '../screens/discover_screen/models/product_image_model.dart';
import '../screens/discover_screen/models/products_model.dart';
import '../screens/discover_screen/models/users_model.dart';
import '../screens/reviews_screen/model/reviews_model.dart';
import 'api_routing/api_routing.dart';
import 'package:http/http.dart' as http;

import 'api_utils.dart';
import 'error_handling.dart';

class ApiServices {
  ApiServices._();

  static ApiServices getInstance() {
    return Singleton(ApiServices, () => ApiServices._()) as ApiServices;
  }

  static Future<ProductsModel> fetchProducts() async {
    try {
      String url = ApiRoutes.getProducts();
      http.Response response = await ApiUtils.getResponse(url, headers: {
        "Content-Type": "application/json"
      });
      return ResponseHandler.getResponse(
          response: response, modelManager: MH.products);
    } catch (e) {
      rethrow;
    }
  }

  static Future<ProductsImagesModel> fetchSubCollections(
      String documentPath) async {
    String subCollectionPath = '$documentPath/images';
    String url = ApiRoutes.getImages(subCollectionPath);
    http.Response response = await ApiUtils.getResponse(url, headers: {
      "Content-Type": "application/json"
    });
    return ResponseHandler.getResponse(
        response: response, modelManager: MH.productImages);
  }

  static Future<UsersModel> fetchUsers() async {
    try {
      String url = ApiRoutes.getUsers();
      http.Response response = await ApiUtils.getResponse(url, headers: {
        "Content-Type": "application/json"
      });
      return ResponseHandler.getResponse(
          response: response, modelManager: MH.users);
    } catch (e) {
      rethrow;
    }
  }

  static Future<ReviewsModel> fetchReviews() async {
    try {
      String url = ApiRoutes.getReviews();
      http.Response response = await ApiUtils.getResponse(url, headers: {
        "Content-Type": "application/json"
      });
      return ResponseHandler.getResponse(
          response: response, modelManager: MH.reviews);
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> addDataToCart(String productId, double price, int quantity, String title, String shoeSize, String colorName, String colorHexCode, String shoeImage, String brandName) async {
    try {
      FirebaseFirestore fireStore = FirebaseFirestore.instance;
      CollectionReference cartCollection = fireStore.collection('Cart');
      await cartCollection.add({
        "price": price,
        "productId": productId,
        "quantity": quantity,
        "title": title,
        "size": shoeSize,
        "color": colorName,
        "colorHexCode": colorHexCode,
        "image": shoeImage,
        "brandName": brandName,
      }).then((_) {}).whenComplete(() {
        CustomDialogues.flutterToastDialogueBox(
            "Successfully added", color: AppColors.successColor,
            textColor: AppColors.primaryColor);
        Get.back();
        discoverCtrl.cartProductQty.value = 1;
      });
    } catch (e) {
      ErrorHandler.handleError(e);
    }
  }

  static Future<void> updateCartQuantity(String documentId, int newQuantity) async {
    try {
      log("This is documentId: $documentId");
      FirebaseFirestore fireStore = FirebaseFirestore.instance;
      CollectionReference cartCollection = fireStore.collection('Cart');
      await cartCollection.doc(documentId.split("Cart/")[1]).update({
        "quantity": newQuantity,
      }).then((_) {
        CustomDialogues.flutterToastDialogueBox(
            "Quantity updated successfully", color: AppColors.successColor,
            textColor: AppColors.primaryColor);
      }).whenComplete(() {});
    } catch (e) {
      ErrorHandler.handleError(e);
    }
  }

  static Future<void> deleteCartQuantity(String documentId) async {
    try {
      log("This is documentId: $documentId");
      FirebaseFirestore fireStore = FirebaseFirestore.instance;
      CollectionReference cartCollection = fireStore.collection('Cart');
      await cartCollection.doc(documentId.split("Cart/")[1]).delete().then((_) {
        CustomDialogues.flutterToastDialogueBox(
            "Deleted successfully", color: AppColors.successColor,
            textColor: AppColors.primaryColor);
      }).whenComplete(() {});
    } catch (e) {
      ErrorHandler.handleError(e);
    }
  }

  static Future<CartModel> fetchCart() async {
    try {
      String url = ApiRoutes.getCarts();
      http.Response response = await ApiUtils.getResponse(url, headers: {
        "Content-Type": "application/json"
      });
      return ResponseHandler.getResponse(
          response: response, modelManager: MH.cart);
    } catch (e) {
      rethrow;
    }
  }

}
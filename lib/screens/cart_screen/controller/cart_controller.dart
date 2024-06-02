
import 'package:get/get.dart';
import 'package:shoesly/screens/cart_screen/model/cart_model.dart';
import 'package:shoesly/services/api_services.dart';

class CartController extends GetxController{
  static final CartController instance = Get.find();
  Rx<CartModel> cartData = Rx(CartModel());
  RxBool isFetchingCartData = false.obs;
  RxInt cartNumber = 1.obs;
  RxDouble grandTotal = 0.0.obs;
  RxDouble totalOrderPrice = 0.0.obs;

  ///Fetch cart data from database
  fetchCartData()async{
    try{
      grandTotal.value = 0.0;
      isFetchingCartData(true);
      cartData.value = await ApiServices.fetchCart();
      if((cartData.value.documents??[]).isNotEmpty){
        calculateGrandTotal();
      }
    }catch(e){
      isFetchingCartData(false);
      rethrow;
    }finally{
      isFetchingCartData(false);
    }
  }

  ///Update cart data
  updateCartData(String documentId, int newQuantity)async{
    try{
      await ApiServices.updateCartQuantity(documentId, newQuantity);
    }catch(e){
      rethrow;
    }finally{

    }
  }

  deleteCartData(String documentId)async{
    try{
      await ApiServices.deleteCartQuantity(documentId);
    }catch(e){
      rethrow;
    }finally{

    }
  }

  ///This function is to fetch the grand total
  calculateGrandTotal() {
    for (Document document in (cartData.value.documents ?? [])) {
      double price = double.parse(document.fields?.price?.doubleValue.toString() ?? "");
      int quantity = int.parse(document.fields?.quantity?.integerValue ?? "");
      grandTotal.value += price * quantity;
    }
  }
}
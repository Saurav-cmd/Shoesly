import '../../global/singelton_class.dart';

class ApiRoutes {
  ApiRoutes._();

  static ApiRoutes getInstance() {
    return Singleton(ApiRoutes, () => ApiRoutes._()) as ApiRoutes;
  }

  static const baseUrl = "https://firestore.googleapis.com/v1/projects/shoesly-8bd52/databases/(default)/documents";
  static const productSubCollectionBaseUrl = "projects/shoesly-8bd52/databases/(default)/documents/products/";

  static String getProducts(){
    return "$baseUrl/products/";
  }

  static String getImages(String subCollectionPath){
    return "https://firestore.googleapis.com/v1/$subCollectionPath";
  }

  static String getReviews(){
    return "$baseUrl/Reviews/";
  }

  static String getUsers(){
    return "$baseUrl/User/";
  }

  static String addToCart(){
    return "$baseUrl/Cart";
  }

  static String getCarts(){
    return "$baseUrl/Cart/";
  }

}
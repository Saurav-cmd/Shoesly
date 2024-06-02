import 'dart:developer';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shoesly/screens/discover_screen/models/combined_model.dart';
import 'package:shoesly/screens/discover_screen/models/product_image_model.dart';
import 'package:shoesly/screens/discover_screen/models/users_model.dart';
import 'package:shoesly/screens/reviews_screen/model/review_custom_model.dart';
import 'package:shoesly/screens/reviews_screen/model/reviews_model.dart';
import 'package:shoesly/services/api_routing/api_routing.dart';
import 'package:shoesly/services/api_services.dart';

import '../models/products_model.dart';

class DiscoverController extends GetxController {
  static final DiscoverController instance = Get.find();

  ///Discover and Discover Detail page variables..............................................
  Rx<ProductsModel> productsData = Rx(ProductsModel());
  Rx<ProductsImagesModel> pImageData = Rx(ProductsImagesModel());
  RxBool isFetchingProducts = false.obs;
  RxList<CombinedModel> combinedProductData = RxList();
  RxDouble selectedSize = (0.0).obs;
  RxDouble averageRating = 0.0.obs;
  RxInt carousalSliderIndex = 0.obs;
  List<ProductImages> imagesList = [];
  RxString selectedImage = "".obs;
  RxString selectedImageColor = "".obs;
  RxString selectedImageHex = "".obs;
  List<String> brandList = ["All", "Nike", "Vans", "Adidas", "Reebok",];

  ///Users variables.............................................................................
  Rx<UsersModel> userData = Rx(UsersModel());

  ///Reviews Variables..........................................................................
  Rx<ReviewsModel> reviewsData = Rx(ReviewsModel());
  RxList<CustomReviewModel> customReviewData = RxList();
  RxBool isFetchingUserAndReview = false.obs;
  List<String> reviewsList = [
    "All",
    "5 Stars",
    "4 Stars",
    "3 Stars",
    "2 Stars",
    "1 Stars"
  ];

  ///Cart Product Variables.....................................................................
  RxInt cartProductQty = 1.obs;
  RxBool isAddingToCart = false.obs;

  ///Product Filter screen variables...........................................................
  RxInt selectedBrandIndex = (-1).obs;
  RxInt selectedSortByIndex = (-1).obs;
  RxInt selectedGenderIndex = (-1).obs;
  RxInt selectedColorIndex = (-1).obs;
  RxInt totalFilterCount = 0.obs;

  RxString filterBrandName = "".obs;
  RxDouble minPrice = (-1.0).obs;
  RxDouble maxPrice = (-1.0).obs;
  RxString selectedSortByName = "".obs;
  RxString selectedGenderName = "".obs;
  RxString selectedColorName = "".obs;
  RxString selectedColorHex = "".obs;
  RxString selectedBrandName = "".obs;

  RxBool brandFilterApplied = false.obs;
  RxBool priceRangeFilterApplied = false.obs;
  RxBool sortByFilterApplied = false.obs;
  RxBool genderFilterApplied = false.obs;
  RxBool colorFilterApplied = false.obs;
  final selectedFilter = "All".obs;


  ///Function to fetch products data from the firebase database
  Future<void> getProducts() async {
    try {
      combinedProductData.clear();
      isFetchingProducts(true);
      productsData.value = await ApiServices.fetchProducts();
      if ((productsData.value.documents ?? []).isNotEmpty) {
        for (Document data in productsData.value.documents ?? []) {
          await fetchSubCollections(data.name ?? "");
        }
      }
    } catch (e) {
      isFetchingProducts(false);
      log("Error Occurred: ${e.toString()}");
    } finally {
      isFetchingProducts(false);
    }
  }

  ///Function to fetch subCollection of the products
  Future<void> fetchSubCollections(String collectionName) async {
    try {
      pImageData.value = await ApiServices.fetchSubCollections(collectionName);
      addDataToCombinedModel();
    } catch (e) {
      log("Error Occurred: ${e.toString()}");
    }
  }

  ///Filtering logic the first if condition does filter from the discover screen brand name
  ///and else filtering is done by product-filter page
  List<CombinedModel> filterProductsByBrand() {
    List<CombinedModel> filteredData = [];

    if (selectedBrandName.value.isEmpty ||
        (minPrice.value == 0.0 && maxPrice.value == 0.0)) {
      if (selectedFilter.value == "All") {
        return combinedProductData;
      } else {
        return combinedProductData
            .where((data) =>
        data.brandName?.toLowerCase() == selectedFilter.value.toLowerCase())
            .toList();
      }
    } else {
      // Filter by brand name and/or price range
      filteredData = combinedProductData
          .where((data) =>
      (data.brandName?.toLowerCase() ==
          selectedBrandName.value.toLowerCase()) ||
          ((minPrice.value == 0.0 && maxPrice.value == 0.0) ||
              ((data.productPrice ?? 0.0) >= minPrice.value &&
                  (data.productPrice ?? 0.0) <= maxPrice.value)))
          .toList();
      return filteredData;
    }
  }

  void sortByMostRecent() {
    // Implement logic to sort products by most recent
    combinedProductData.sort((a, b) => (b.productDate ?? DateTime.now()).compareTo(a.productDate ?? DateTime.now()));
  }

  void sortByLowestPrice() {
    // Implement logic to sort products by lowest price
    combinedProductData.sort((a, b) =>(a.productPrice??0.0).compareTo(b.productPrice ?? 0.0));
  }

  void sortByHighestPrice() {
    // Implement logic to sort products by highest price
    combinedProductData.sort((a, b) => (b.productPrice ?? 0.0).compareTo(a.productPrice ?? 0.0));
  }


  List<CombinedModel> filterAndSortProducts() {
    // Apply existing filters
    List<CombinedModel> filteredData = filterProductsByBrand();

    // Apply sorting based on selected option
    switch (selectedSortByName.value) {
      case "Most Recent":
        sortByMostRecent();
        break;
      case "Lowest Price":
        sortByLowestPrice();
        break;
      case "Highest Price":
        sortByHighestPrice();
        break;
    }

    return filteredData;
  }


  ///Fetched products list and particular products images from firebase and then stored that data in our own custom model
  ///for better control over the data and to centralized the product data in single place for easier approach
  void addDataToCombinedModel() {
    try {
      //first loop through the products list
      for (Document dData in productsData.value.documents ?? []) {
        Fields? fieldsData = dData.fields;
        if (fieldsData != null) {
          List<ProductImages> productImagesList = [];

          //then loop through the images
          for (ImageDocument imageData in pImageData.value.documents ?? []) {
            if (imageData.fields?.productId?.referenceValue == dData.name) {
              //imageUrls are in array so grab the images urls
              List<String>? imageUrls = imageData
                  .fields?.images?.arrayValue?.values
                  ?.map((image) => image.stringValue ?? "")
                  .toList();

              //add the data to the productImageList
              productImagesList.add(ProductImages(
                imageId: imageData.name,
                colorHex: imageData.fields?.colorHex?.stringValue,
                colorName: imageData.fields?.colorName?.stringValue,
                images: imageUrls,
              ));
            }
          }

          //shoes are in array so fetch all the shoes list and add it it shoeSizes
          List<String> shoeSizes = [];
          if (fieldsData.sizes?.arrayValue?.values != null) {
            for (var size in fieldsData.sizes!.arrayValue!.values!) {
              shoeSizes.add(size.stringValue.toString());
            }
          }

          //at the end after we have all the data we add all our data in our own custom model which will have all the information
          //about the products and its images
          if (productImagesList.isNotEmpty) {
            combinedProductData.add(
              CombinedModel(
                productId: dData.name,
                productName: fieldsData.productName?.stringValue,
                productDescription: fieldsData.productDescription?.stringValue,
                productPrice: double.tryParse(
                    fieldsData.productPrice?.integerValue ?? "") ??
                    0.0,
                productReview: fieldsData.productReview?.doubleValue ?? 0.0,
                quantity:
                int.tryParse(fieldsData.quantity?.integerValue ?? "") ?? 0,
                reviewId: fieldsData.reviewId?.referenceValue,
                gender: fieldsData.gender?.stringValue,
                brandName: fieldsData.brandName?.stringValue ?? "",
                brandLogo: fieldsData.brandLogo?.stringValue ?? "",
                pImages: productImagesList,
                shoeSizes: shoeSizes,
                productDate: dData.createTime
              ),
            );
          }
        }
      }
    } catch (e) {
      log("Error Occurred: ${e.toString()}");
    }
  }

  ///Function to fetch users
  Future<void> fetchUsers() async {
    try {
      isFetchingUserAndReview(true);
      userData.value = await ApiServices.fetchUsers();
    } catch (e) {
      isFetchingUserAndReview(false);
      rethrow;
    } finally {}
  }

  ///Function to fetch reviews and check the condition to get the reviews of particular product by the particular user
  Future<void> fetchReviews(String passedProductId) async {
    try {
      // Assuming isFetchingUserAndReview is defined somewhere in your controller
      isFetchingUserAndReview(true);

      // Fetch the review data
      reviewsData.value = await ApiServices.fetchReviews();

      // Check if reviewsData and userData are not empty
      if ((reviewsData.value.documents ?? []).isNotEmpty &&
          (userData.value.documents ?? []).isNotEmpty) {
        // Clear previous data
        customReviewData.clear();

        for (ReviewDocument data in reviewsData.value.documents ?? []) {
          // Check if the productId matches
          if (passedProductId ==
              data.fields?.productId?.referenceValue?.split("products/")[1]) {
            for (UserDocument userDoc in userData.value.documents ?? []) {
              String userId = (userDoc.name ?? "").split("User/")[1];
              String userIdInReview =
              (data.fields?.userId?.referenceValue ?? "").split("User/")[1];

              // Check if userId matches
              if (userId == userIdInReview) {
                customReviewData.add(CustomReviewModel(
                  review: data.fields?.description?.stringValue,
                  reviewNumber:
                  int.parse(data.fields?.reviewNumber?.integerValue ?? "0"),
                  reviewDate: data.fields?.dateAndTime?.stringValue,
                  reviewId: data.name?.split("Reviews/")[1],
                  personFirstName: userDoc.fields?.firstName?.stringValue,
                  personSecondName: userDoc.fields?.lastName?.stringValue,
                  personImage: userDoc.fields?.image?.stringValue,
                ));
              }

              if (customReviewData.isNotEmpty) {
                calculateAverageRating();
              }
            }
          }
        }
      }
    } catch (e) {
      log("Error Occurred: ${e.toString()}");
      rethrow;
    } finally {
      isFetchingUserAndReview(false);
    }
  }

  addDataToCart(String productId,
      double price,
      int quantity,
      String title,
      String shoeSize,
      String brandName) async {
    try {
      isAddingToCart(true);
      await ApiServices.addDataToCart(
          productId,
          price,
          quantity,
          title,
          shoeSize,
          selectedImageColor.value,
          selectedImageHex.value,
          selectedImage.value,
          brandName);
    } catch (e) {
      isAddingToCart(false);
      rethrow;
    } finally {
      isAddingToCart(false);
    }
  }

  ///This calculates the average rating of that particular product
  calculateAverageRating() {
    int totalRatings = customReviewData.length;
    if (totalRatings == 0) return 0.0;

    int sumOfRatings = customReviewData
        .map((review) => review.reviewNumber ?? 0)
        .reduce((a, b) => a + b);
    averageRating.value = sumOfRatings / totalRatings;
  }

  ///This will give you text like if the date matches it will give today and if it passed today yesterday...
  String getFormattedDate(String passedDate) {
    DateTime givenDate = DateFormat('yyyy/MM/dd').parse(passedDate);

    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime yesterday = today.subtract(const Duration(days: 1));

    // Compare given date with today and yesterday
    if (givenDate.year == today.year &&
        givenDate.month == today.month &&
        givenDate.day == today.day) {
      return 'Today';
    } else if (givenDate.year == yesterday.year &&
        givenDate.month == yesterday.month &&
        givenDate.day == yesterday.day) {
      return 'Yesterday';
    } else {
      // If past yesterday, you can return some matching text
      return 'Past yesterday';
    }
  }


  ///This function will show some trancate text like if the text length passes max length of 20 then text will be showin in
  ///this format london ontario...
  String truncateText(String text, {int maxLength = 20}) {
    if (text.length > maxLength) {
      return '${text.substring(0, maxLength)}...';
    }
    return text;
  }

  void updateImageIndex(index) {
    carousalSliderIndex.value = index;
  }

  String getImageUrl(String imageUrl) {
    String fullImageUrl =
    imageUrl.replaceFirst('gs://', '${ApiRoutes.baseUrl}/');
    return fullImageUrl;
  }
}

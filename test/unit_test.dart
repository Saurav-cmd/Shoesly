import 'package:flutter_test/flutter_test.dart';
import 'package:shoesly/screens/discover_screen/controller/discover_controller.dart';
import 'package:shoesly/screens/discover_screen/models/combined_model.dart';

void main() {
  group('DiscoverController Tests', () {
    late DiscoverController discoverCtrl;

    setUp(() {
      discoverCtrl = DiscoverController();
    });

    test('Test filterProductsByBrand', () {
      discoverCtrl.combinedProductData.addAll([
        CombinedModel(
          productId: '1',
          brandName: 'Nike',
          productPrice: 100.0,
        ),
        CombinedModel(
          productId: '2',
          brandName: 'Adidas',
          productPrice: 80.0,
        ),
        CombinedModel(
          productId: '3',
          brandName: 'Vans',
          productPrice: 120.0,
        ),
      ]);

      discoverCtrl.selectedBrandName.value = 'Nike';
      var filteredData = discoverCtrl.filterProductsByBrand();

      expect(filteredData.length, 1);
      expect(filteredData.first.brandName, 'Nike');
    });

    test('Test sortByMostRecent', () {
      discoverCtrl.combinedProductData.addAll([
        CombinedModel(productId: '1', productDate: DateTime(2024, 6, 1)),
        CombinedModel(productId: '2', productDate: DateTime(2024, 5, 30)),
        CombinedModel(productId: '3', productDate: DateTime(2024, 5, 31)),
      ]);

      discoverCtrl.sortByMostRecent();

      expect(discoverCtrl.combinedProductData.first.productId, '1');
      expect(discoverCtrl.combinedProductData.last.productId, '2');
    });
  });
}

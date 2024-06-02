import '../global/singelton_class.dart';

class ImagesConst {
  ImagesConst._();

  static ImagesConst getInstance() {
    return Singleton(ImagesConst, () => ImagesConst._()) as ImagesConst;
  }

  static const bag = "assets/bag.png";
  static const product = "assets/product.png";
  static const setting = "assets/setting.png";
  static const nike = "assets/nike.png";
  static const puma = "assets/puma.png";
  static const adidas = "assets/adiads.png";
  static const reebok = "assets/reekbok.png";
  static const noImage = "assets/no-pictures.png";
}
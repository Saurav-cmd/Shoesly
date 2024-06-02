
import 'package:get/get.dart';
import 'package:shoesly/global_controllers/network_controller.dart';

class Binder extends Bindings{
  @override
  void dependencies() {
    Get.put(NetworkController(), permanent: true);
    Get.lazyPut(() => NetworkController());
  }
}
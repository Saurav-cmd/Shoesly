import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  static final NetworkController instance = Get.find();

  /// This variable represents the connection type:
  /// 0 = No Internet, 1 = connected to WiFi, 2 = connected to Mobile Data.
  RxInt connectionType = 0.obs;

  /// Instance of Flutter Connectivity
  final Connectivity _connectivity = Connectivity();

  /// StreamSubscription to keep listening to network changes
  late StreamSubscription<List<ConnectivityResult>> _streamSubscription;

  /// A method to get the current connection type
  Future<void> getConnectionType() async {
    List<ConnectivityResult> connectivityResults;
    try {
      connectivityResults = await _connectivity.checkConnectivity();
      _updateState(connectivityResults);
    } on PlatformException {
      // Handle platform exceptions if needed
      return;
    }
  }

  /// Update the state based on the connectivity result
  void _updateState(List<ConnectivityResult> connectivityResults) async{
    final ConnectivityResult connectivityResult = connectivityResults.isNotEmpty
        ? connectivityResults.first
        : ConnectivityResult.none;

    switch (connectivityResult) {
      case ConnectivityResult.wifi:
        connectionType.value = 1;
        update();
        break;
      case ConnectivityResult.mobile:
        connectionType.value = 2;
        update();
        break;
      case ConnectivityResult.none:
        connectionType.value = 0;
        update();
        break;
      default:
        break;
    }
  }


  @override
  void onInit() {
    getConnectionType();
    _streamSubscription =
        _connectivity.onConnectivityChanged.listen((List<ConnectivityResult> connectivityResults) {
          _updateState(connectivityResults);
        });
    super.onInit();
  }

  @override
  void onClose() {
    _streamSubscription.cancel();
    super.onClose();
  }
}

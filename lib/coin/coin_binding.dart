import 'package:cryto/coin/coin_controller.dart';
import 'package:get/get.dart';

class CoinBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<CoinController>(CoinController());
  }
}

import 'package:coingecko_api/coingecko_api.dart';
import 'package:coingecko_api/coingecko_result.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  var serverUp = false;
  var checkServer = true;

  final _coinApi = CoinGeckoApi();

  Future<CoinGeckoResult<bool>> ping() {
    return _coinApi.ping.ping();
  }

  updateServerStatus(bool status) {
    serverUp = status;
    update();
  }

  disableServerCheck() {
    checkServer = false;
    update();
  }
}

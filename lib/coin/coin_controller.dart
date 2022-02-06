import 'package:coingecko_api/coingecko_api.dart';
import 'package:coingecko_api/coingecko_result.dart';
import 'package:coingecko_api/data/coin_short.dart';
import 'package:coingecko_api/data/market.dart';
import 'package:get/get.dart';

class CoinController extends GetxController {
  final _coinApi = CoinGeckoApi();

  final _fetching = true;

  List<Market> markets = [];

  var showCoins = false.obs;

  Future<CoinGeckoResult<List<CoinShort>>> getCoins() {
    return _coinApi.coins.listCoins();
  }

  Future<CoinGeckoResult<List<Market>>> getCoinMarkets(
      String currency, List<String> ids) {
    return _coinApi.coins.listCoinMarkets(
        vsCurrency: currency,
        coinIds: ids,
        sparkline: true,
        priceChangePercentageIntervals: ['24h', '7d']);
  }

  bool get getFetchingCoinMarkets {
    return _fetching;
  }

  set setFetchingCoinMarket(fetching) {
    fetching = fetching;
  }

  set setMarkets(markets) {
    this.markets = markets;
  }

  List<Market> get getMarkets {
    return markets;
  }

  void updateShowCoins(bool value) {
    showCoins.value = value;
    update();
  }
}

import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import 'coin_controller.dart';

class CoinListView extends GetView<CoinController> {
  const CoinListView({Key? key}) : super(key: key);

  @override
  StatelessElement createElement() {
    controller.getCoinMarkets("usd", [
      "bitcoin",
      "ethereum",
      "binancecoin",
      "ripple",
      "dai",
      "matic-network",
      "polkadot",
      "cardano",
      "solana",
      "litecoin",
      "zcash",
      "tether",
      "terra-luna",
      "avalanche-2",
      "dogecoin",
      "shiba-inu",
      "chainlink",
      "decentraland",
      "vechain",
      "elrond-erd-2",
      "iota"
    ]).then((value) {
      controller.setMarkets = value.data;
      controller.updateShowCoins(true);
    }).onError((error, stackTrace) {
      //TODO Error handling should be implemented for production app
    });
    return super.createElement();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(slivers: [
      SliverAppBar(
          backgroundColor: Colors.black,
          pinned: true,
          leading: const Icon(Icons.menu),
          expandedHeight: 200,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              "Coins/Tokens",
              style: GoogleFonts.aleo(color: Colors.amberAccent),
            ),
            background: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  "images/chart.jpeg",
                  fit: BoxFit.fill,
                ),
                Row(
                  children: [
                    const Spacer(
                      flex: 2,
                    ),
                    Flexible(
                        flex: 6,
                        child: Opacity(
                          opacity: 0.6,
                          child: Image.asset(
                            "images/tokens.png",
                          ),
                        )),
                    const Spacer(
                      flex: 2,
                    )
                  ],
                )
              ],
            ),
          )),
      Obx(() {
        return controller.showCoins.value
            ? SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  var market = controller.markets[index];
                  var prices = market.sparklineIn7d!.price;
                  var priceIncreased = prices.last - prices.first >= 0;
                  return Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1, color: Colors.grey),
                      ),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 40.0,
                                  height: 40.0,
                                  child: Image.network(market.image!),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      market.name,
                                      style: GoogleFonts.lato(
                                          color: Colors.lightBlue),
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      "${market.marketCapRank}. ${market.symbol.toUpperCase()}",
                                      style:
                                          GoogleFonts.lato(color: Colors.black),
                                    ),
                                  ],
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                )
                              ],
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  Text(
                                    "\$${market.currentPrice}",
                                    style:
                                        GoogleFonts.roboto(color: Colors.amber),
                                  ),
                                  SizedBox(
                                    height: 50,
                                    child: Sparkline(
                                      lineColor: priceIncreased
                                          ? Colors.green
                                          : Colors.red,
                                      data: prices,
                                    ),
                                  ),
                                ],
                              )),
                          Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: Column(
                                children: [
                                  Text(
                                    "1d %: ${market.priceChangePercentage24h!.toStringAsFixed(2)}",
                                    style:
                                        GoogleFonts.lato(color: Colors.purple),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    "7d %: ${market.priceChangePercentage7dInCurrency!.toStringAsFixed(2)}",
                                    style: GoogleFonts.lato(
                                        color: Colors.deepPurpleAccent),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    "1d \$: ${market.priceChange24h!.toStringAsFixed(2)}",
                                    style: GoogleFonts.lato(
                                        color: Colors.teal),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }, childCount: controller.markets.length),
              )
            : SliverToBoxAdapter(
                child: Shimmer.fromColors(
                  direction: ShimmerDirection.ltr,
                  baseColor: Colors.green[300]!,
                  highlightColor: Colors.green[100]!,
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (_, __) => Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 45.0,
                                      height: 45.0,
                                      color: Colors.purple,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          height: 10,
                                          width: 100,
                                          color: Colors.purple,
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        Container(
                                          height: 10,
                                          width: 100,
                                          color: Colors.purple,
                                        ),
                                      ],
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      itemCount: 20,
                    ),
                  ),
                ),
              );
      }),
    ]));
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}

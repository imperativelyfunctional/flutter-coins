import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cryto/coin/coin_binding.dart';
import 'package:cryto/coin/coin_list.dart';
import 'package:cryto/main/main_binding.dart';
import 'package:cryto/main/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(GetMaterialApp(
      initialBinding: MainBinding(),
      getPages: [
        GetPage(name: "/", page: () => const Home(), binding: MainBinding()),
        GetPage(
            name: "/coins",
            page: () => const CoinListView(),
            binding: CoinBinding())
      ],
      debugShowCheckedModeBanner: false,
      title: 'Crypto Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const Home()));
}

class Home extends GetView<MainController> {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (controller.checkServer) {
      controller.ping().then((value) {
        var serverUp = value.data;
        controller.updateServerStatus(serverUp);
        if (serverUp) {
          Timer(const Duration(seconds: 5), () {
            Get.toNamed("coins");
          });
        }
      }).onError((error, stackTrace) {
        Get.snackbar(
            "Warning", "There is an issue trying to connect to the server.",
            backgroundColor: Colors.amber, snackPosition: SnackPosition.BOTTOM);
      });
      controller.checkServer = false;
    }
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "images/chart.png",
                    fit: BoxFit.contain,
                  ),
                  FadeInLeft(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: BounceInDown(
                            child: Text(
                              'Crypto Tracker',
                              style: GoogleFonts.alfaSlabOne(
                                  color: Colors.orange, fontSize: 30),
                            ),
                          ),
                          flex: 8,
                        ),
                        Flexible(
                          child: Spin(
                            delay: const Duration(seconds: 2),
                            child: Image.asset(
                              "images/moon.png",
                              fit: BoxFit.contain,
                            ),
                          ),
                          flex: 1,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Row(
                children: [
                  Flexible(
                      flex: 1,
                      child: FlipInX(
                          delay: const Duration(seconds: 1),
                          child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Image.asset("images/eth.png")))),
                  Flexible(
                      flex: 1,
                      child: FlipInY(
                          delay: const Duration(seconds: 2),
                          child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Image.asset("images/bit.png")))),
                  Flexible(
                      flex: 1,
                      child: FlipInX(
                          delay: const Duration(seconds: 1),
                          child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Image.asset("images/ada.png")))),
                  Flexible(
                      flex: 1,
                      child: FlipInY(
                          delay: const Duration(seconds: 2),
                          child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Image.asset("images/polkadot.png")))),
                ],
              ),
            ),
            Flexible(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SpinKitHourGlass(
                      duration: Duration(seconds: 1),
                      color: Colors.lightBlue,
                      size: 20.0,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    FadeIn(
                      child: const Text(
                        "Checking server status",
                        style: TextStyle(
                            color: Colors.amber, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ))
          ],
        ),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/bg.jpg"), fit: BoxFit.cover),
        ),
      ),
    );
  }
}

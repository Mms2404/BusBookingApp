import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loaders {

  static Widget bigLoader() {
    return Center(
      child: Lottie.asset(
        'assets/loader.json',
        width: 300,
        height: 300,
        fit: BoxFit.contain,
      ),
    );
  }


  static Widget smallLoader() {
    return SizedBox(
      width: 30,
      height: 30,
      child: Lottie.asset(
        'assets/loader.json',
        fit: BoxFit.contain,
      ),
    );
  }

  static Widget busLoader() {
    return SizedBox(
      width: 200,
      height: 200,
      child: Lottie.asset(
        'assets/bus.json',
        fit: BoxFit.contain,
      ),
    );
  }
}






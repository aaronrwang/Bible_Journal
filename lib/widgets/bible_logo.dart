import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class BibleLogo extends StatelessWidget {
  const BibleLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset('assets/lotties/welcome.json', repeat: false);
  }
}

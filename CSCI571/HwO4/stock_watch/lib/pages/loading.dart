import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Future.delayed(const Duration(milliseconds: 500), () {
      Navigator.of(context).pushReplacementNamed("/home");
    });

    return const SafeArea(
      child: Center(
        child: SpinKitDualRing(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}


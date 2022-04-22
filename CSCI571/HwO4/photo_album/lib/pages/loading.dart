import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 500), () async {
      final prefs = await SharedPreferences.getInstance();
      Navigator.pushReplacementNamed(context, '/home',
          arguments: {'images': prefs.getStringList('images') ?? []});
    });
    return const Scaffold(
        body: Center(
            child:
                SpinKitWanderingCubes(color: Colors.blueAccent, size: 50.0)));
  }
}

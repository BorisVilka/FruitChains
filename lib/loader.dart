

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoaderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.popAndPushNamed(context, '/menu');
    });
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/images/loaderbg.png"), fit: BoxFit.fill)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Image.asset("assets/images/logo.png",width: 300,),
            const Spacer(),
            const CircularProgressIndicator(color: Colors.purple,strokeWidth: 15,strokeAlign: 3,),
            const Spacer(),
          ],
        ),
      ),
    );
  }

}

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/images/bg.png"), fit: BoxFit.fill)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 5,),
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/game');
                },
                icon: Image.asset("assets/images/play.png",width: 300)),
            const Spacer(),
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/settings');
                },
                icon: Image.asset("assets/images/options.png",width: 250)),
            const Spacer(flex: 3,),
            IconButton(
                onPressed: () {
                  exit(0);
                },
                icon: Image.asset("assets/images/exit.png",width: 200)),
            const Spacer(flex: 3,)
          ],
        ),
      ),
    );
  }

}
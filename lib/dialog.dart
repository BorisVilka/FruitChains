
import 'dart:ffi';

import 'package:flutter/material.dart';

class WinDialog extends StatefulWidget {

  var score = 0;

  WinDialog(this.score);

  @override
  State<WinDialog> createState() {
    // TODO: implement createState
    print("DIALOG");
    return WinState();
  }

}
class WinState extends State<WinDialog> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Container(
        padding: const EdgeInsets.all(10),
        alignment: Alignment.center,
        width: 300,
        height: 300,
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Color.fromARGB(255,255, 168, 0),Color.fromARGB(255,255, 138, 0),]),
          borderRadius: BorderRadius.circular(20),

        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            const Text("You Lose!", style: TextStyle(fontFamily: 'font',fontSize: 60, color: Colors.amber,)),
            Text("${widget.score}", style: const TextStyle(fontFamily: 'font',fontSize: 40,color: Color.fromARGB(255, 71, 12, 0)),),
            const Text("miles ", style: TextStyle(fontFamily: 'font',fontSize: 40,color: Color.fromARGB(255, 71, 12, 0)),),
            const Spacer(),
            TextButton(onPressed: () {
              Navigator.popAndPushNamed(context, '/game');
            },
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.amber),
              padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 25)),
              ), child: const Text("Try again",style: TextStyle(fontFamily: 'font',fontSize: 30,color: Colors.purple)),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

}
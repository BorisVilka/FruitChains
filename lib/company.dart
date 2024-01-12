
import 'package:flutter/material.dart';

class CompanyScreen extends StatelessWidget {
  const CompanyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.popAndPushNamed(context, '/loader');
    });
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset("assets/images/company.png",width: 300,),
      ),
    );
  }

}
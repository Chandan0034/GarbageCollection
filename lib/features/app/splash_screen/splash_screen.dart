import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/Dashboard.dart';
import 'package:flutter_firebase/features/user_auth/presentation/pages/login_page.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
final auth=FirebaseAuth.instance;
final user=auth.currentUser;
class _SplashScreenState extends State<SplashScreen> {
@override
  void initState() {
  if(user!=null){
    Geolocator.requestPermission();
    Future.delayed(
        Duration(seconds: 3),(){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Dashboard()), (route) => false);
    }
    );

  }else{
    Geolocator.requestPermission();
    Future.delayed(
        Duration(seconds: 3),(){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
    }
    );
  }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Text(
          "Welcome to the garbage collection app",
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

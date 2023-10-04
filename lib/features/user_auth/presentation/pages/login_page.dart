
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/Dashboard.dart';
import 'package:flutter_firebase/features/user_auth/presentation/pages/sign_up_page.dart';
import 'package:flutter_firebase/features/user_auth/presentation/widgets/form_container_widget.dart';
import 'package:geolocator/geolocator.dart';

import '../../firebase_auth_implementation/firebase_auth_services.dart';



class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}
final auth =FirebaseAuth.instance;
String text="";
class _LoginPageState extends State<LoginPage> {

  bool _isSigning = false;

  final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Login",
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              FormContainerWidget(
                controller: _emailController,
                hintText: "Email",
                isPasswordField: false,
              ),
              SizedBox(height: 10,),
              FormContainerWidget(
                controller: _passwordController,
                hintText: "Password",
                isPasswordField: true,
              ),
              SizedBox(height: 20,),
              Text(text,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.red),),
              SizedBox(height: 10,),
              GestureDetector(
                onTap: _signIn,
                child: Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child:
                    Text("Login",
                      style: TextStyle(color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  SizedBox(width: 5,),
                  GestureDetector(
                      onTap: (){
                        setState(() {
                          text="";
                        });
                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (context) => SignUpPage()), (route) => false);
                      },
                      child: Text("Sign Up",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _signIn() async {
    LocationPermission permission=await Geolocator.checkPermission();
    if(permission==LocationPermission.denied||permission==LocationPermission.deniedForever){
      Geolocator.requestPermission();
    }else{
      Geolocator.requestPermission();
    }
    String email = _emailController.text;
    String password = _passwordController.text;
    User? user = await _auth.signInWithEmailAndPassword(email, password);
    if (user!= null){
      setState(() {
        text="";
      });
      print("User is successfully signedIn");
      // Navigator.pushNamed(context, "/home");
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => Dashboard()), (route) => false);
    } else{
      setState(() {
        text="User Doesn't Exist";
      });
      print("not exist");
    }

  }
}
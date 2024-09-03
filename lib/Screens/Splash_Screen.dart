import 'package:ecommerce/Screens/Home_Screen.dart';
import 'package:ecommerce/Screens/Login_Screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SplashScreen extends StatefulWidget {

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    Future.delayed(Duration(seconds: 3),(){
      getToken();
    }
    );
  }
  void getToken()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access-token');
    if(token != null && token.isNotEmpty)
    {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context)=> HomeScreen()),
            (route) => false,
      );

    }
    else{
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context)=> LoginScreen()),
            (route) => false,
      );

    }

  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF40BFFF),
      body: Center(
        child: Image.asset('assets/Images/logo.png'),
      ),
    );
  }

}


import 'package:ecommerce/Cubits/auth_cubit/auth_cubit.dart';
import 'package:ecommerce/Screens/Home_Screen.dart';
import 'package:ecommerce/Screens/Register_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isObscure = true;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.sizeOf(context).width;
    double heightScreen = MediaQuery.sizeOf(context).height;
    return Form(
      key: formKey,
      child: Scaffold(
        backgroundColor: Colors.white,
        body:
        BlocListener<AuthCubit,AuthState>(
        listener: (context,state) {
      if(state is AuthNotValid){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            )
        );

      }
      if(state is AuthFailed){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            )
        );
      }
      if(state is AuthSuccess){
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>  const HomeScreen()),(route) => false);

      }


    },
    child:  BlocBuilder<AuthCubit,AuthState>(
    builder: (context,state) {
    if(state is LoadingAuthState){
    return  const Center(child: CircularProgressIndicator());
    }


    return SafeArea(
    child: Container(
    margin: EdgeInsets.symmetric(horizontal: widthScreen*0.04),
    width: MediaQuery.of(context).size.width, // in Column
    child: SingleChildScrollView(
    child: Column(
    children: [
      SizedBox( height: heightScreen*0.075,),
    Image.asset('assets/Images/Vector.png',
    height: heightScreen*0.11,
      width: widthScreen*0.2,
    ),
     SizedBox( height: heightScreen*0.02,),
    Text('Welcome to Lafyuu',
    style: TextStyle(fontSize: widthScreen*0.05,
    color:  const Color(0xFF223263),
    fontWeight: FontWeight.bold
    ),
    ),
     SizedBox( height: heightScreen*0.012,),
    Text('sign in to continue',
    style: TextStyle(fontSize: widthScreen*0.03,
    color:  const Color(0xFF9098B1),
    fontWeight: FontWeight.w400,
    ),

    ),
     SizedBox( height: heightScreen*0.04,),
    TextFormField(
    keyboardType: TextInputType.emailAddress,
    controller: emailController,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    decoration:  const InputDecoration(
    hintText: 'Your Email',
    border: OutlineInputBorder(),
    prefixIcon: Icon(
    Icons.email_outlined,
    color: Color(0xFF9098B1),
    ),
    ),
    validator: (value){
    if(!(value!.contains('@')
    && value.contains('.')
    &&value.length>8)
    )
    {
    return "Email not valid!";
    }
    return null;
    },
    ),
     SizedBox( height: heightScreen*0.02,),
    TextFormField(
      controller: passwordController,
    keyboardType: TextInputType.visiblePassword,
    obscureText: isObscure,
    decoration: InputDecoration(
    hintText: 'Password',
    border:  const OutlineInputBorder(),
    prefixIcon:  const Icon(Icons.lock,color:Color(0xFF9098B1),),
    suffixIcon:IconButton(
    icon:isObscure?  const Icon(Icons.visibility_off): const Icon(Icons.visibility),
    onPressed:(){
    setState(() {
    if(isObscure==true){
    isObscure= false;
    }
    else
    {
    isObscure=true;
    }
    });
    },
    ),
    ),
    ),
     SizedBox( height: heightScreen*0.03,),
    ElevatedButton(onPressed: (){



    context.read<AuthCubit>().login(
    emailController.text, passwordController.text);




    },
    style: ElevatedButton.styleFrom(
    backgroundColor:  const Color(0xFF40BFFF),
    shadowColor:  const Color(0xFF40BFFF),
    fixedSize: Size(widthScreen,heightScreen*0.08),
    ),
    child:  const Text('Sign In'
    ,style: TextStyle(fontWeight: FontWeight.bold,
    color: Colors.white),),


    ),
     SizedBox( height: heightScreen*0.03,),

    SizedBox(
    width: MediaQuery.of(context).size.width,
    child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Expanded(
    child: Divider(

    color: Color(0xFFEBF0FF),
    ),
    ),
      SizedBox( height: heightScreen*0.02,),
    Center(
    child: Container(
    margin: EdgeInsets.symmetric(horizontal: widthScreen*0.05),
    child:  const Text('OR',
    style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xFF9098B1),),),
    ),
    ),
      SizedBox( height: heightScreen*0.03,),
      const Expanded(
    child: Divider(
    //thickness: 1,
    color: Color(0xFFEBF0FF),
    //  indent: 20,
    ),
    ),
    ],
    ),
    ),
     SizedBox( height: heightScreen*0.02,),
    OutlinedButton.icon(
    icon: Image.asset('assets/Images/Google.png'),
    onPressed: (){}, label:  const Center(child: Text('Login with Google',
    style: TextStyle(color: Color(0xff9098B1),
    fontWeight: FontWeight.w700
    ),
    )
    ),
    style: OutlinedButton.styleFrom(
    fixedSize: Size( widthScreen, heightScreen*0.08)
    ),
    ),

     SizedBox( height: heightScreen*0.012,),
    OutlinedButton.icon(
    icon: Image.asset('assets/Images/Facebook.png'),
    onPressed: (){}, label:  const Center(child:  Text('Login with Facebook',style: TextStyle(color:  Color(0xff9098B1),
    fontWeight: FontWeight.w700
    ),
    ),
    ),
    style: OutlinedButton.styleFrom(
    fixedSize:  Size( widthScreen, heightScreen*0.08)
    ),
    ),
     SizedBox( height: heightScreen*0.02,),
    GestureDetector(
    onTap: (){},
    child:  const Text('Forget Password',
    style:  TextStyle(color:  Color(0xFF40BFFF),
    fontWeight: FontWeight.bold),),
    ),
     SizedBox( height: heightScreen*0.012,),
    Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text('Don\'t have a account?',
    style: TextStyle(color: Color(0xFF9098B1),
    fontWeight: FontWeight.bold),
    ),

    GestureDetector(
    onTap: (){
    Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (context){
    return  const RegisterScreen();
    }
    )
    );
    },
    child:  const Text('Register',
    style: TextStyle(color: Color(0xFF40BFFF),
    fontWeight: FontWeight.bold),
    ),
    ),
    ],
    ),
      SizedBox( height: heightScreen*0.012,),
    ],
    ),
    ),
    ),
    );

    }),
    )));
  }
}




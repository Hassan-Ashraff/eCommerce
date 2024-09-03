import 'package:ecommerce/Cubits/auth_cubit/auth_cubit.dart';
import 'package:ecommerce/Screens/Home_Screen.dart';
import 'package:ecommerce/Screens/Login_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.sizeOf(context).width;
    double heightScreen = MediaQuery.sizeOf(context).height;
    return  Form(
      key: formKey,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocListener<AuthCubit,AuthState>(
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
         Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=> const HomeScreen()),(route) => false);

        }


    },
            child:  BlocBuilder<AuthCubit,AuthState>(
              builder: (context,state) {
                if(state is LoadingAuthState){
                  return const Center(child: CircularProgressIndicator());
                }
                return SafeArea(
                  child: Container(
                    width: widthScreen,
                    height: heightScreen,
                    padding: EdgeInsets.all(widthScreen*0.04),
                    child: SingleChildScrollView(
                      child: Column(children: [
                         SizedBox( height: heightScreen*0.04,),
                        Image.asset('assets/Images/logo.png',
                          height: heightScreen*0.11,
                          width: widthScreen*0.2,
                        ),
                        SizedBox( height: heightScreen*0.02,),
                        Text('Welcome to Lafyuu',
                          style: TextStyle(fontSize: widthScreen*0.04,
                              color: const Color(0xFF223263),
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox( height: heightScreen*0.01,),
                        Text('sign in to continue',
                          style: TextStyle(fontSize:widthScreen*0.03,
                            color:  const Color(0xFF9098B1),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox( height: heightScreen*0.04,),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,

                          controller: nameController,
                          validator: (value){
                            if(value!.isEmpty)
                              {
                                return "Name can't be empty";
                              }
                            return null;
                          },
                          decoration: const InputDecoration(
                            border:   OutlineInputBorder(),
                              hintText: 'Full Name',
                              hintStyle: TextStyle(
                                  color: Color(0xff9098B1),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400


                              ),
                              prefixIcon: Icon(Icons.person_2_outlined, color: Color(0xff9098B1),),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF9098B1),
                              ),
                            ),
                          ),

                        ),
                        SizedBox( height: heightScreen*0.015,),

                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: const InputDecoration(
                              hintText: 'Your Email',
                              hintStyle: TextStyle(
                                  color: Color(0xff9098B1),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400

                              ),
                            border:   OutlineInputBorder(),
                              prefixIcon: Icon(Icons.email_outlined, color: Color(0xff9098B1),),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF9098B1),
                              ),
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
                        SizedBox( height: heightScreen*0.015,),
                        TextFormField(
                          validator: (value){
                            if (!(value!.startsWith('011') ||
                                value.startsWith('012') ||
                                value.startsWith('010') ||
                                value.startsWith('015')
                                && value.length!=11
                            ))
                            {
                              return "Number of phone not correct";
                            }
                            return null;},
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            border:   OutlineInputBorder(),
                              hintText: 'Phone',
                              hintStyle: TextStyle(
                                  color: Color(0xff9098B1),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400


                              ),
                              prefixIcon: Icon(Icons.phone_android_outlined, color: Color(0xff9098B1),),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF9098B1),
                              ),
                            ),
                          ),

                        ),
                        SizedBox( height: heightScreen*0.015,),

                        TextFormField(
                          controller: passwordController,
                          decoration: const InputDecoration(
                            border:   OutlineInputBorder(),
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                  color: Color(0xff9098B1),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400


                              ),
                              prefixIcon: Icon(Icons.lock_outline, color: Color(0xff9098B1),),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF9098B1),
                              ),
                            ),
                          ),

                        ),
                        SizedBox( height: heightScreen*0.015,),

                        TextFormField(
                          controller: confirmPasswordController,
                          decoration: const InputDecoration(
                            border:   OutlineInputBorder(),
                              hintText: 'Password Again',
                              hintStyle: TextStyle(
                                  color: Color(0xff9098B1),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400


                              ),
                              prefixIcon: Icon(Icons.lock_outline, color: Color(0xff9098B1),),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF9098B1),
                              ),
                            ),
                          ),

                        ),
                        SizedBox( height: heightScreen*0.02,),

                        ElevatedButton(onPressed: (){
                         if(formKey.currentState!.validate()) {
                           if (passwordController.text !=
                               confirmPasswordController.text) {
                             ScaffoldMessenger.of(context).showSnackBar(
                                 const SnackBar(
                                   duration: Duration(seconds: 4),
                                   content: Text('Password should identical'),
                                   backgroundColor: Colors.red,
                                 )
                             );
                           }
                           else {
                             context.read<AuthCubit>().register(
                                 nameController.text, phoneController.text,
                                 emailController.text, passwordController.text);
                           }
                         }
                        },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF40BFFF),
                        shadowColor: const Color(0xff40bfff),
                        fixedSize: Size(widthScreen,heightScreen*0.08),

                      ), child: const Text('Sign Up',
                            style: TextStyle(fontWeight: FontWeight.bold,
                            color: Colors.white),),
                        ),
                        SizedBox( height: heightScreen*0.03,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('have a account?',style: TextStyle(color:  const Color(0xFF9098B1),
                                fontSize: widthScreen*0.034,
                                fontWeight: FontWeight.w700),),
                            GestureDetector(
                              onTap: (){
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(builder: (context){
                                      return  const LoginScreen();
                                    }
                                    )
                                );
                              },
                              child: Text('Sign In',style: TextStyle(color:  const Color(0xff40BFFF),
                                  fontSize: widthScreen*0.034,
                                  fontWeight: FontWeight.bold),),
                            ),
                          ],
                        ),


                      ],
                      ),
                    ),
                  ),
                );
              }
                  )
        ),
      ),
    );
  }
}

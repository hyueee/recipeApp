
import 'package:firstapp/controller/authentication_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

//keep outside to stay text thr
TextEditingController emailController = TextEditingController();
TextEditingController pwController = TextEditingController();

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {

    // var emailController = TextEditingController();
    // var pwController = TextEditingController();
  
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xFFfcecd3),
        body: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Stack(
            children: [
              // Positioned(
              //   top:0,
              //   left: 0,
              //   height: MediaQuery.of(context).size.height,
              //   child: Container(
              //     height: MediaQuery.of(context).size.height,
              //     width: MediaQuery.of(context).size.width,
              //     decoration: const BoxDecoration(
              //         image: DecorationImage(
              //             image: AssetImage("images/main_bg.jpg"),
              //             fit:BoxFit.cover
              //         )
              //     ),
              //   ),
              // ),
              Container(
                height: h,
                child: Column(
                  children: [
                    const SizedBox(height: 30,),
                    SizedBox(
                      width: w,
                      height: h*0.3,
                      child: Center(
                        child: Container(
                          width: w*0.7,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("images/login_ui.jpg"),
                                fit:BoxFit.fill,
                            )
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Welcome back",
                      style: 
                        TextStyle(
                          fontSize: 28,
                          color: Colors.black,
                          fontWeight: FontWeight.bold 
                        ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: w*0.8,
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: "Email",
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          prefixIcon: const Icon(Icons.email),
                        ),
                      ) ,
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: w*0.8,
                      child: TextField(
                        controller: pwController,
                        decoration: InputDecoration(
                          labelText: "Password",
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          prefixIcon: const Icon(Icons.password_outlined),
                        ),
                        obscureText: true,
                      ) ,
                    ),
                    const SizedBox(height: 40),
                    GestureDetector(
                      onTap: (){
                        AuthenticationController.instance.login(emailController.text, pwController.text);
                        emailController.clear();
                        pwController.clear();
                      },
                      child: Container(
                        width: w*0.4,
                        height:50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xff66ffe0),
                          ),
                        child: const Center(
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.black),
                            ),
                          ),
                        ),

                    ),
                    SizedBox(height: h*0.05),
                    RichText(text: TextSpan(
                        text: "Don\'t have any account? ",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                        children: [
                          TextSpan(
                            text: "Create Now",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                            ),
                            recognizer: TapGestureRecognizer()..onTap=()=>Get.toNamed("/register")
                          )
                        ]
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ) 
      ),
    );
  }
}
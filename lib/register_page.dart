import 'package:firstapp/controller/authentication_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({ Key? key }) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

//keep outside to stay text thr
TextEditingController nameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController pwController = TextEditingController();

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {

    // var emailController = TextEditingController();
    // var pwController = TextEditingController();
  
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Positioned(
              top:0,
              left: 0,
              height: MediaQuery.of(context).size.height,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/main_bg.jpg"),
                        fit:BoxFit.cover
                    )
                ),
              ),
            ),
            Column(
              children: [
                const SizedBox(height: 10,),
                SizedBox(
                  width: w,
                  height: h*0.3,
                  child: Center(
                    child: Container(
                      width: w*0.7,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("images/task.png"),
                            fit:BoxFit.fill,
                        )
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Register now",
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
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: "Username",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      prefixIcon: const Icon(Icons.person)
                    ),
                  ) ,
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
                const SizedBox(height: 15),
                Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Text(
                    "*Password must be atleast 6 characters",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14
                    ),
                  ),
                
                ),
                const SizedBox(height: 25),
                GestureDetector(
                  onTap: (){
                    AuthenticationController.instance.register(nameController.text, emailController.text, pwController.text);
                    emailController.clear();
                    pwController.clear();
                    nameController.clear();
                  },
                  child: Container(
                    width: w*0.4,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xff66ffe0),
                      ),
                    child: const Center(
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.black),
                        ),
                      ),
                    ),

                ),
                SizedBox(height: h*0.05),
                Center(
                  child: Text(
                    "Create your own account now to set what you want to do!",
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
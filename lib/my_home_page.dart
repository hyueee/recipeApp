import 'package:firstapp/controller/recipe_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/authentication_controller.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final recipeController = Get.find<RecipeController>();

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      backgroundColor: const Color(0xFF69c5df),
      body: Stack(
          children: [
            Positioned(
              top:0,
              left: 0,
              height: 700,
              child: Container(
                height: 700,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/background.jpg"),
                        fit:BoxFit.cover
                    )
                ),
              ),
            ),
            Positioned(
                bottom: 60,
                left: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Store All Your Recipes",
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontWeight: FontWeight.w600
                      ),),
                      const Text("Contests",
                        style: TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                            fontWeight: FontWeight.w600
                        ),),
                      const SizedBox(height: 40,),
                      SizedBox(
                        width: MediaQuery.of(context).size.width-60,
                              child: const Text("No need to worry where to find your recipes. Everything is in here.",
                              style: TextStyle(
                                color: Colors.white60
                              ),)),
                      const SizedBox(height: 40,),
                      
                    ],
                )
            ),
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFffbc33e)
                  ),

                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      primary: const Color(0xFFfbc33e),
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),),
                    onPressed: 
                    // ()=>Get.to(()=>const ContentPage()),
                    () async {
                      AuthenticationController.instance.showDialog();
                      String status = await AuthenticationController.instance.viewUser();
                      status == "done" ? recipeController.checkRecentRecipe() : null;
                      String checkStatus = await recipeController.checkRecentRecipe();
                      checkStatus == "done" ? Get.offNamed("/content") : null;
                    },
                    child: const Text(
                      "Get started",
                      style: TextStyle(
                        color:Colors.white
                      ),
                    ),
                  ),

                ),
              ),
            )
          ],
        ),

    );
  }
}

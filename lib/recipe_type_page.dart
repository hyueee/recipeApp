import 'package:firstapp/controller/recipe_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecipeTypePage extends StatelessWidget {
  const RecipeTypePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final recipeController = Get.find<RecipeController>();

    return 
    Stack(
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
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            leading: IconButton(
              onPressed: () => Get.back(), 
              icon: const Icon(Icons.arrow_back_ios, color: Colors.black,)
            ),
            title: Text("Recipes", style: TextStyle(color: Colors.black),),
            centerTitle: true,
          ),
          body: SafeArea(
            child: Container(
       
              child: Column(
                  children: [
                    Obx(() => 
                      Expanded(
                        child:   
                            MediaQuery.removePadding(context: context,
                                removeTop: true,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: recipeController.recipeList.length,
                                    itemBuilder: (_, i){
                                      return GestureDetector(
                                        onTap: () async {
                                          String status = await recipeController.viewRecipe(recipeController.recipeList[i].id);
                                          status == "done" ? Get.toNamed("/detail") : null;
                                        },
                                        child: Container(
                                          width: MediaQuery.of(context).size.width,
                                          height: 100,
                                          margin: const EdgeInsets.only(left: 25, right: 25, top: 15),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color:Color(0xFFebf8fd),
                                          ),
                                          child: Container(
                                            padding: const EdgeInsets.only(left: 10),
                                            child: Row(
                                              children: [
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      recipeController.recipeList[i].name,
                                                      style: const TextStyle(
                                                        color:Color(0xFF3b3f42),
                                                        fontSize: 18,
                                                        decoration: TextDecoration.none
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10,),
                                                    SizedBox(
                                                      width: 170,
                                                      child: Text(
                                                        recipeController.recipeList[i].desc,
                                                        style: const TextStyle(
                                                          color:Colors.orangeAccent,
                                                          fontSize: 12,
                                                          decoration: TextDecoration.none
                                                        ),
                                                      ),
                                                    )

                                                  ],
                                                ),
                                                Expanded(child: Container()),
                                                Center(
                                                  child: Container(
                                                    margin: EdgeInsets.only(top: 25),
                                                    width: 100,
                                                    height: 100,
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [
                                                            Icon(Icons.timer, color: Colors.black, size: 20,),
                                                            SizedBox(width: 10,),
                                                            Text(
                                                              recipeController.recipeList[i].duration,
                                                              style: const TextStyle(
                                                                  fontSize: 15,
                                                                  decoration: TextDecoration.none,
                                                                  color:Color(0xFFb2b8bb)
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(height: 10,),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [
                                                            Icon(Icons.people, color: Colors.black, size: 20,),
                                                            SizedBox(width: 10,),
                                                            Text(
                                                              recipeController.recipeList[i].serving,
                                                              style: const TextStyle(
                                                                  fontSize: 15,
                                                                  decoration: TextDecoration.none,
                                                                  color:Color(0xFFb2b8bb)
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),

                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    })

                            )

                        ),
                    )
                  ],
                ),
            ),
            )
        )
      ]
    );
  }
}
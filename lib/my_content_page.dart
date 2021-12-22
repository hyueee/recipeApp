import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firstapp/controller/authentication_controller.dart';
import 'package:firstapp/controller/recipe_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContentPage extends StatefulWidget {
  const ContentPage({Key? key}) : super(key: key);

  @override
  _ContentPageState createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {

  final recipeController = Get.find<RecipeController>();
  List recipeType = [];

  _readData() async {
    await DefaultAssetBundle.of(context).loadString("json/recipeType.json").then((s){
      setState(() {
        recipeType = json.decode(s);
      });
    });
  }

  @override
  void initState(){
    _readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return
      Scaffold(
        backgroundColor: Color(0xffffe0b5),
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(top:50),
              child: Column(
                children: [
                  //user
                  Container(
                    width: width,
                    height: 100,
                    margin: const EdgeInsets.only(left: 25, right: 25),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color:const Color(0xFFebf8fd),
                    ),
                    child: Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        children: [
                          Obx(
                            () =>   
                            // FadeInImage.assetNetwork(
                            //   placeholder: 'images/pic-1.png',
                            //   image:  '${controller.image.value}',
                            // )
                            CircleAvatar(
                              radius:40,
                              backgroundImage: 
                                CachedNetworkImageProvider(
                                  AuthenticationController.instance.image.value
                                ),
                            ),
                          ),
                          const SizedBox(width: 10,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(
                                () => Text(AuthenticationController.instance.username.value,
                                style: const TextStyle(
                                    color:Color(0xFF3b3f42),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.none
                                ),
                                )
                              ),
                              const SizedBox(height: 5,),
                              Obx(
                                () => Text(AuthenticationController.instance.email.value,
                                style: const TextStyle(
                                    color:Colors.cyan,
                                    fontSize: 12,
                                    decoration: TextDecoration.none
                                ),
                                )
                              ),
                            ],
                          ),
                          Expanded(child: Container()),
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color:const Color(0xFFf3fafc)
                            ),
                            child: Center(
                              child: IconButton(
                                icon: const Icon(
                                Icons.logout,
                                color:Color(0xFF69c5df),
                                size: 30, 
                                ), onPressed: () {  
                                  AuthenticationController.instance.logout();
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  //recipe types
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 25, right: 25),
                        child: Row(
                          children: [
                            const Text(
                              "Types of Recipe",
                              style: TextStyle(
                                  color:Color(0xFF1f2326),
                                  fontSize: 20,
                                  decoration: TextDecoration.none
                              ),
                            ),
                            Expanded(child: Container()),
                            const Text(
                              "Add new",
                              style: TextStyle(
                                  color:Colors.black,
                                  fontSize: 15,
                                  decoration: TextDecoration.none
                              ),
                            ),
                            const SizedBox(width: 5,),
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xFFfdc33c)
                              ),
                              child: GestureDetector(
                                onTap: (){
                                  Get.toNamed("/addRecipe");
                                },
                                child: const Icon(Icons.add, color: Colors.white,)
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  //list
                  SizedBox(
                    height: 150,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          left: -140,
                          right: 0,
                          child: 
                          SizedBox(
                            height: 150,
                            child: PageView.builder(
                            controller: PageController(viewportFraction: 0.4),
                            itemCount: recipeType.length,
                            itemBuilder: (_, i){
                              return GestureDetector(
                                onTap: () async {
                                  // Get.toNamed("/recipeType", arguments: {
                                  //   "type" : recipeType[i]['name'].toString(), 
                                  // });
                                  String status = await recipeController.checkRecipeType(recipeType[i]['name'].toString());
                                  if (status == "done") {
                                    Get.back();
                                    Get.toNamed("/recipeType");
                                  } else {
                                    Get.back();
                                    Get.snackbar("Sorry", "You haven't added any recipe on this type yet.",
                                      backgroundColor: Colors.blueAccent,
                                      snackPosition: SnackPosition.BOTTOM,
                                    );
                                  }
                                   
                                },
                                child:  
                                Container(
                                  padding: const EdgeInsets.only(top: 10),
                                  height: 120,
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(recipeType[i]["img"],),
                                          colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
                                          fit:BoxFit.cover
                                      ),
                                      borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: 
                                    Text(
                                      recipeType[i]["name"],
                                      style: const TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.w500,
                                        color:Colors.black
                                      ),
                                    ),
                                  )
                                ),
                              );
                            }),
                          ),
                        )
                      ],
                    )
                    
                  ),
                  const SizedBox(height: 20,),
                  //recent contests
                  Container(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: Row(
                      children: [
                        const Text(
                          "Recent Recipes",
                          style: TextStyle(
                              color:Color(0xFF1f2326),
                              fontSize: 20,
                              decoration: TextDecoration.none
                          ),
                        ),
                        Expanded(child: Container()),
                        Text(
                          "Show all",
                          style: TextStyle(
                              color:Colors.black,
                              fontSize: 15,
                              decoration: TextDecoration.none
                          ),
                        ),

                        SizedBox(width: 5,),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xFFfdc33c)
                          ),
                          child: GestureDetector(
                            onTap: (){
                              recipeController.checkAllRecipe("none");
                            },
                            child: Icon(Icons.arrow_forward_ios, color: Colors.white,)
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Obx(() =>
                    recipeController.recentList.isNotEmpty ?
                    Expanded(
                      child:   
                        MediaQuery.removePadding(context: context,
                            removeTop: true,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: recipeController.recentList.length,
                                itemBuilder: (_, i){
                                  return GestureDetector(
                                    onTap: () async {
                                      String status = await recipeController.viewRecipe(recipeController.recentList[recipeController.recentList.length - 1 - i].id);
                                      status == "done" ? Get.toNamed("/detail") : null;
                                    },
                                    child: Container(
                                      width: width,
                                      height: 100,
                                      margin: const EdgeInsets.only(left: 25, right: 25, bottom: 15),
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
                                                    recipeController.recentList[recipeController.recentList.length - 1 - i].name,
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
                                                      recipeController.recentList[recipeController.recentList.length - 1 - i].desc,
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
                                                            recipeController.recentList[recipeController.recentList.length - 1 - i].duration,
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
                                                           recipeController.recentList[recipeController.recentList.length - 1 - i].serving,
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
                                      )
                                    ),
                                  );
                                })

                        )

                    )
                    : Container(
                        margin: EdgeInsets.only(top: 20),
                        child: const Center(child: Text("No recipe yet.", style: TextStyle(fontSize: 30, color: Colors.black),),)
                      )
                  )
                ],
              ),
            ),
          ],
        ),
      );
  }

}



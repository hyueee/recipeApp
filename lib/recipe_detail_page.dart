import 'package:cached_network_image/cached_network_image.dart';
import 'package:firstapp/controller/recipe_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class RecipeDetailPage extends StatefulWidget {
  const RecipeDetailPage({ Key? key }) : super(key: key);

  @override
  _RecipeDetailPageState createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> with TickerProviderStateMixin{

  final recipeController = Get.find<RecipeController>();

  @override
  Widget build(BuildContext context) {
    
    TabController _tabController = TabController(length: 4, vsync: this);
    
    return Stack(
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
            automaticallyImplyLeading: false,
            flexibleSpace: SafeArea(
              child: TabBar(
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.black,
                padding: EdgeInsets.only(top: 8),
                indicatorWeight: 4,
                indicatorSize: TabBarIndicatorSize.label,
                controller: _tabController,
                tabs: [
                  Tab(
                    text: "Detail",
                  ),
                  Tab(
                    text: "Ingredient",
                  ),
                  Tab(
                    text: "Step",
                  ),
                  Tab(
                    text: "Image",
                  ),
                ],
              ),
            ),
          ),
          body: SafeArea(
            child: Container(
              child: TabBarView(
                controller: _tabController,
                children: [
                  ListView(
                    padding: EdgeInsets.only(left: 8, right: 8, top: 12),
                    children: [
                      Obx( () =>
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Recipe name',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  recipeController.product[0].name.toString(),
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        )
                      ),
                      const SizedBox(height: 8),
                      Obx( () =>
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Description',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  recipeController.product[0].desc.toString(),
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        )
                      ),
                      const SizedBox(height: 8),
                      Obx( () =>
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Recipe type',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  recipeController.product[0].type.toString(),
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        )
                      ),
                      const SizedBox(height:8),
                      Obx( () =>
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Estimated serving',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  recipeController.product[0].serving.toString(),
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        )
                      ),
                      const SizedBox(height:8),
                      Obx( () =>
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Estimated duration',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  recipeController.product[0].duration.toString(),
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        )
                      ),
                    ],
        
                  ),
                  recipeController.ingredients.isNotEmpty ?
                  ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: recipeController.ingredients.length,
                    itemBuilder: (_, i){
                      return Container(
                          margin: const EdgeInsets.only(left: 8, right: 8, top: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color:Colors.white,
                          ),
                          child: Container(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Ingredient " + (i+1).toString(),
                                        style: const TextStyle(
                                          color:Colors.deepOrangeAccent,
                                          fontSize: 16,
                                          decoration: TextDecoration.none
                                        ),
                                      ),
                                      const SizedBox(height: 10,),
                                      SizedBox(
                                        width: 170,
                                        child: Text(
                                          recipeController.ingredients[i].toString(),
                                          style: const TextStyle(
                                            color:Colors.black,
                                            fontSize: 20,
                                            decoration: TextDecoration.none
                                          ),
                                        ),
                                      )

                                    ],
                                  ),
                                
                                ],
                              ),
                          )
                        
                      );
                  })
                  : Container(
                    child: Center(
                      child: Text("Please proceed to image."),
                    ),
                  ),
                  recipeController.steps.isNotEmpty ?
                  ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: recipeController.steps.length,
                    itemBuilder: (_, i){
                      return Container(
                          margin: const EdgeInsets.only(left: 8, right: 8, top: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color:Colors.white,
                          ),
                          child: Container(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Step " + (i+1).toString(),
                                        style: const TextStyle(
                                          color:Colors.deepOrangeAccent,
                                          fontSize: 16,
                                          decoration: TextDecoration.none
                                        ),
                                      ),
                                      const SizedBox(height: 10,),
                                      SizedBox(
                                        width: 170,
                                        child: Text(
                                          recipeController.steps[i].toString(),
                                          style: const TextStyle(
                                            color:Colors.black,
                                            fontSize: 20,
                                            decoration: TextDecoration.none
                                          ),
                                        ),
                                      )

                                    ],
                                  ),
                                ],
                              ),
                          )
                        
                      );
                  })
                  : Container(
                    child: Center(
                      child: Text("Please proceed to image."),
                    ),
                  ),
                  recipeController.image.isNotEmpty ?
                  ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: recipeController.image.length,
                    itemBuilder: (_, i){
                      return Container(
                          width: 400,
                          margin: const EdgeInsets.only(left: 8, right: 8, top: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color:Colors.white,
                          ),
                          child:  InteractiveViewer(
                            minScale: 1,
                            maxScale: 4,
                            child: CachedNetworkImage(
                              width: 400, 
                              imageUrl: recipeController.image[i],
                            ),
                          )
                          // Container(
                          //   width: 600,
                          //   padding: const EdgeInsets.all(16),
                          //   decoration: BoxDecoration(
                          //           image: DecorationImage(
                          //               image: CachedNetworkImageProvider(
                          //                 recipeController.items[i]
                          //               ),
                          //               fit:BoxFit.cover
                          //           ),
                          //           borderRadius: BorderRadius.circular(30),
                          //       ),
                          // )
                        
                      );
                  })
                  : Container(
                    child: Center(
                      child: Text("There is no image."),
                    ),
                  ),
                ]
              ),
            )
          ),
        ),
      ],
    );
  }
}
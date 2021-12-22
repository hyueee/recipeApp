import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/recipe_controller.dart';
import 'controller/step_controller.dart';

class AddRecipePage extends StatefulWidget {
  const AddRecipePage({ Key? key }) : super(key: key);

  @override
  _AddRecipePageState createState() => _AddRecipePageState();
}

TextEditingController nameController = new TextEditingController();
TextEditingController timeController = new TextEditingController();
TextEditingController descController = new TextEditingController();
TextEditingController servingController = new TextEditingController();

class _AddRecipePageState extends State<AddRecipePage> {

  final stepController = Get.put(StepController());
  final recipeController = Get.put(RecipeController());
  List types = ['Main dishes', 'Side dishes', 'Soups', 'Desserts', 'Appetizers', 'Bakery goods', 'Beverages', 'Others'];

  List<Step> stepList() => [
    Step(
      isActive: stepController.activeStepState.value >= 0,
      state: stepController.activeStepState.value <= 0 ? StepState.editing : StepState.complete,
      title: 
        Text("Basic Details"), 
      content: 
        SingleChildScrollView(
          child: SizedBox(
            height: 650,
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: "Name",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(height: 20,),
                Obx(() =>   
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black)
                    ),
                    padding: EdgeInsets.only(left: 10, right: 5),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: recipeController.type.value,
                        isExpanded: true,
                        onChanged: (value) {
                          recipeController.updateType(value!);
                        },
                        icon: const Icon(Icons.arrow_drop_down),
                        items: types.map((values){
                          return DropdownMenuItem<String>(
                            value: values,
                            child: Text(values),
                          );
                        }).toList()
                      )
                    )
                  )
                ),
                SizedBox(height: 20,),
                TextField(
                  controller: descController,
                  decoration: InputDecoration(
                    labelText: "Description",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(height: 20,),
                TextField(
                  controller: servingController,
                  decoration: InputDecoration(
                    labelText: "Estimated serving",
                    hintText: "ex: 2 person",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ), 
                SizedBox(height: 20,),
                TextField(
                  controller: timeController,
                  decoration: InputDecoration(
                    labelText: "Estimated cooking time",
                    hintText: "ex: 45min",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(height: 15,),
                Row(
                  children: [
                    ElevatedButton(
                        onPressed: () { 
                          recipeController.pickMultiFromGallery();
                        },
                        child: Text(
                          "Upload from gallery"
                        ),
                    ),
                    SizedBox(width: 20,),
                    Center(
                      child: ElevatedButton(
                        onPressed: () { 
                          recipeController.pickFromCamera();
                        },
                        child: Text(
                          "Take camera photo"
                        ),
                      )
                    ),
                  ],
                ),
                SizedBox(height: 15,),
                Obx(
                  () =>
                  recipeController.items.isNotEmpty ?
                  Center(
                    child: ElevatedButton(
                      onPressed: () { 
                        recipeController.removeItems();
                      },
                      child: Text(
                        "Clear all images"
                      ),
                    )
                  ) : Text("Select image (optional)")
                ),
                SizedBox(height: 20,),
                // Obx(() =>
                //   recipeController.imgPath.value == "" ? Text("Select image (optional)") : Image.file(File(recipeController.imgPath.value), width: 50, height: 50,)
                // ),
                Obx(
                  () => 
                  recipeController.items.isEmpty ? Text("* Maximum 10 images") : 
                  Expanded(
                    child:   
                    MediaQuery.removePadding(context: context,
                        removeTop: true,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: recipeController.items.length,
                            itemBuilder: (_, i){
                              return Container(
                                height: 100,
                                width: 100,
                                margin: const EdgeInsets.only(right: 25),
                                child: 
                                Image.file(File(recipeController.items[i]))
                              );
                              // return Container(
                              //   width: 100,
                              //   height: 100,
                              //   margin: const EdgeInsets.only(left: 25, right: 25, bottom: 20),
                              //   decoration: BoxDecoration(
                              //     borderRadius: BorderRadius.circular(20),
                              //     color:Color(0xFFebf8fd),
                              //   ),
                              //   child: Container(
                              //     // padding: const EdgeInsets.only(left: 10),
                              //     child: 
                                      
                              //   ),
                              // );
                            })
                    )
                  ),
                ),
              ],
            ),
          ),
        )
    ),
    Step(
      isActive: stepController.activeStepState.value >= 1,
      state: stepController.activeStepState.value <= 1 ? StepState.editing : StepState.complete,
      title: 
        Text("Ingredients"), 
      content: 
        SingleChildScrollView(
          child: SizedBox(
            height: 550,
            child: Column(
              children: [
                Obx(
                  () => 
                  recipeController.ingredientList.isEmpty ? Text("Please add your ingredient.") : 
                  Expanded(
                    child:   
                    MediaQuery.removePadding(context: context,
                        removeTop: true,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: recipeController.ingredientList.length,
                            itemBuilder: (_, i) => recipeController.ingredientList[i])
                    )
                  ),
                ),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () { 
                        recipeController.increment(recipeController.numIngredient, "ingredient");
                      },
                      child: Text(
                        "Add"
                      ),
                    ),
                    SizedBox(width: 15,),
                    ElevatedButton(
                      onPressed: () { 
                        recipeController.decrement(recipeController.numIngredient, "ingredient");
                      },
                      child: Text(
                        "Delete"
                      ),
                    )
                  ],
                ),
              ]
            ),
        )
      )
    ),
    Step(
      isActive: stepController.activeStepState.value >= 2,
      state: stepController.activeStepState.value <= 1 ? StepState.editing : StepState.complete,
      title: 
        Text("Steps"), 
      content: 
        SingleChildScrollView(
          child: SizedBox(
            height: 550,
            child: Column(
              children: [
                Obx(
                  () => 
                  recipeController.stepList.isEmpty ? Text("Please add your step.") : 
                  Expanded(
                    child:   
                    MediaQuery.removePadding(context: context,
                      removeTop: true,
                      child: 
                        ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: recipeController.stepList.length,
                          itemBuilder: (_, i) => recipeController.stepList[i]
                        )
                      )
                  )
                ),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () { 
                        recipeController.increment(recipeController.numStep, "step");
                      },
                      child: Text(
                        "Add"
                      ),
                    ),
                    SizedBox(width: 15,),
                    ElevatedButton(
                      onPressed: () { 
                        recipeController.decrement(recipeController.numStep, "step");
                      },
                      child: Text(
                        "Delete"
                      ),
                    )
                  ],
                ),
              ]
            ),
          ) 
        )
    ),
  ]; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFc5e5f3),
      appBar: AppBar(
        backgroundColor: Color(0xFFc5e5f3),
        leading: BackButton(
          color: Colors.black,
        ),
        title: 
          Text(
              "New Recipe",
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
        shadowColor: Colors.transparent,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          child: Column(
              children: [
                Expanded(
                  child: Theme(
                    data: ThemeData(
                      canvasColor: Color(0xFFc5e5f3),
                      primarySwatch: Colors.lightBlue,
                      colorScheme: ColorScheme.light(
                        primary: Colors.lightBlue
                      )
                    ),
                    child: Obx(() => 
                        Stepper(
                          type: StepperType.horizontal,
                          currentStep: stepController.activeStepState.value,
                          steps: stepList(),
                          onStepContinue: () {
                            if (stepController.activeStepState.value < (stepList().length - 1)) {
                              stepController.increment();
                            } else if (stepController.activeStepState.value == 2) {
                              if (nameController.text.isNotEmpty) {
                                if (recipeController.items.isNotEmpty) {

                                  recipeController.storeRecipe(nameController, timeController, descController, servingController); 
                                  
                                } else {
                                  if (recipeController.numIngredient.value == 1 || recipeController.numStep.value == 1) {
                                    Get.snackbar("Warning", "Please input all the required details. (ingredient and steps is required if there is no images uploaded)",
                                      backgroundColor: Colors.redAccent,
                                      snackPosition: SnackPosition.BOTTOM,
                                      duration: Duration(milliseconds: 4000),
                                    );
                                  } else {
                                    for (var widget in recipeController.ingredientList) {
                                      if(widget.ingredientController.text.isEmpty){
                                        Get.snackbar("Warning", "Please ensure all the ingredient and step input fields are filled in. (no blanks)",
                                          backgroundColor: Colors.redAccent,
                                          snackPosition: SnackPosition.BOTTOM,
                                          duration: Duration(milliseconds: 4000),
                                        );

                                        return;
                                      }
                                    }

                                    for (var widget in recipeController.stepList) {
                                      if(widget.stepController.text.isEmpty){
                                        Get.snackbar("Warning", "Please ensure all the ingredient and step input fields are filled in. (no blanks)",
                                          backgroundColor: Colors.redAccent,
                                          snackPosition: SnackPosition.BOTTOM,
                                          duration: Duration(milliseconds: 4000),
                                        );
                                        
                                        return;
                                      }
                                    }
                                    
                                    recipeController.storeRecipe(nameController, timeController, descController, servingController); 
                                  }
                                }
                                
                              } else {
                                Get.snackbar("Warning", "Please fill in the recipe name.",
                                  backgroundColor: Colors.redAccent,
                                  snackPosition: SnackPosition.BOTTOM,
                                );
                              }
                              
                            }

                            // recipeController.ingredientList.isEmpty ? null : recipeController.storeIngredients(recipeController.ingredientList);
                            // recipeController.stepList.isEmpty ? null : recipeController.storeStep(recipeController.stepList);

                          },
                          onStepCancel: (){
                            if (stepController.activeStepState.value > 0) {
                              stepController.decrement();
                            }
                          },
                          controlsBuilder: (context, {onStepContinue, onStepCancel}) {
                            return Container(
                              margin: EdgeInsets.only(top: 20),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: onStepContinue,
                                      child: 
                                      stepController.activeStepState.value == 2 ? 
                                      Text(
                                        "Confirm",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold
                                      ),
                                      ) :
                                      Text(
                                        "Next",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    )
                                  ),
                                  SizedBox(width: 10,),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: onStepCancel,
                                      child: 
                                      Text(
                                        "Back",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    )
                                  ),
                                ],
                              )
                            );
                          }
                          ,
                        ),
                      )
                    )
                )
              ],
            ),
          ),
        ),
    );
  }
}

class ingredientWidget extends StatelessWidget {
  TextEditingController ingredientController = new TextEditingController();
  final int num;

  ingredientWidget(this.num);


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: (
         TextField(
          controller: ingredientController,
          decoration: InputDecoration(
            labelText: "Ingredient " + num.toString(),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        )
      )
    );
  }
}

class stepWidget extends StatelessWidget {
  TextEditingController stepController = new TextEditingController();
  final int num;

  stepWidget(this.num);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: (
         TextField(
          controller: stepController,
          decoration: InputDecoration(
            labelText: "Step " + num.toString(),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        )
      )
    );
  }
}
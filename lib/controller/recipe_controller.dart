import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firstapp/add_recipe_page.dart';
import 'package:firstapp/controller/authentication_controller.dart';
import 'package:firstapp/controller/step_controller.dart';
import 'package:firstapp/model/recipe_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RecipeController extends GetxController{

  FirebaseAuth auth = FirebaseAuth.instance;
  final DatabaseReference myRef = FirebaseDatabase.instance.reference();
  final stepController = Get.put(StepController());

  var imgPath = "".obs;
  var type = "Main dishes".obs;
  var numIngredient = 1.obs;
  var numStep = 1.obs;
  var checkType = 1.obs;

  RxList<String> items = RxList<String>();
  RxList<ingredientWidget> ingredientList = RxList<ingredientWidget>();
  RxList<String> ingredients = RxList<String>();
  RxList<stepWidget> stepList = RxList<stepWidget>();
  RxList<String> steps = RxList<String>();
  RxList<RecipeModel> recipeList = RxList<RecipeModel>();
  RxList<RecipeModel> recentList = RxList<RecipeModel>();
  RxList<RecipeModel> product = RxList<RecipeModel>();
  RxList<String> imgUrl = RxList<String>();
  RxList<String> image = RxList<String>();

  updateType(String newValue){
    type.value = newValue;
  }

  numIncrement(String s){
    if (s == "ingredient") {
      numIngredient += 1;
    } else {
      numStep += 1;
    }
  }

  numDecrement(String s){
     if (s == "ingredient") {
      numIngredient -= 1;
    } else {
      numStep -= 1;
    }
  }

  increment(RxInt number, String s){
    int num = number.value;
    if (s == "ingredient") {
      ingredientList.add(ingredientWidget(num));
    } else {
      stepList.add(stepWidget(num));
      
    }
    numIncrement(s);
  }

  decrement(RxInt number, String s){
    if (s == "ingredient") {
      ingredientList.removeLast();
    } else {
      stepList.removeLast();
      
    }
    numDecrement(s);
  }

  pickFromCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) {
      Get.snackbar("Image load failed", "Please select image.",
      backgroundColor: Colors.blueAccent,
      snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      final imgTemp = File(image.path);
      items.add(imgTemp.path.toString());
    }
  }

  // *** for single image
  // pickFromGallery() async {
  //   final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (image == null) {
  //     Get.snackbar("Image load failed", "Please select image.",
  //     backgroundColor: Colors.blueAccent,
  //     snackPosition: SnackPosition.BOTTOM,
  //     );
  //   } else {
  //     imgPath.value = image.path;
  //   }
  // }

  pickMultiFromGallery() async {
    List<XFile>? image = await ImagePicker().pickMultiImage(maxWidth: 100, maxHeight: 100, imageQuality: 10);
    if (image == null) {
      Get.snackbar("Image load failed", "Please select image.",
      backgroundColor: Colors.blueAccent,
      snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      for (int i = 0; i<image.length; i++){
        items.add(image[i].path);
      }
      
    }
  }
  
  removeItems() {
    items.clear();
  }

  Future<void> storeRecipe(TextEditingController nameController, TextEditingController timeController, TextEditingController descController, TextEditingController servingController) async{
    AuthenticationController.instance.showDialog();

    String id = auth.currentUser!.uid;
    String name = nameController.text;
    String time = timeController.text;
    String desc = descController.text;
    String serving = servingController.text;

    //
    if (ingredientList.isNotEmpty) {
      ingredients.clear();

      for (var widget in ingredientList) {
        ingredients.add(widget.ingredientController.text);
      }
    }

    var i = 0;
    var mapIngredient = {for (var s in ingredients) (i++).toString(): s};

    //
    if (stepList.isNotEmpty) {
      steps.clear();

      for (var widget in stepList) {
        steps.add(widget.stepController.text);
      }

    }

    var l = 0;
    var mapStep = {for (var s in steps) (l++).toString(): s};

    //
    if (items.isNotEmpty) {
      
      imgUrl.clear();

      for (var imageFile in items) {
        var dbStorage = FirebaseStorage.instance.ref().child(id).child(imageFile.toString());
        UploadTask task = dbStorage.putFile(File(imageFile));

        TaskSnapshot snapshot = await task;
        
        String url = await snapshot.ref.getDownloadURL();
        imgUrl.add(url);
      }

    }

    var j = 0;
    var mapImage = {for (var s in imgUrl) (j++).toString(): s};

    // var steps = ['hi','bye','hy'];
    // var l = 0;
    // var mapStep = {for (var s in steps) l++: s};

    var timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    var key = timestamp + "-" + name;

    await myRef.child("Users").child(id).child("recipes").child(type.value).child(key).set({
      'name': name,
      'duration': time,
      'desc': desc,
      'serving': serving,
      'type': type.value,
      'id': key,
    });

    await myRef.child("Users").child(id).child("recipes").child(type.value).child(key).child("ingredients").set(mapIngredient);
    await myRef.child("Users").child(id).child("recipes").child(type.value).child(key).child("steps").set(mapStep);
    await myRef.child("Users").child(id).child("recipes").child(type.value).child(key).child("imgUrl").set(mapImage);
    
    await myRef.child("Users").child(id).child("recent").child(key).set({
      'name': name,
      'duration': time,
      'desc': desc,
      'serving': serving,
      'type': type.value,
      'id': key,
    });

    await myRef.child("Users").child(id).child("recent").child(key).child("ingredients").set(mapIngredient);
    await myRef.child("Users").child(id).child("recent").child(key).child("steps").set(mapStep);
    await myRef.child("Users").child(id).child("recent").child(key).child("imgUrl").set(mapImage);

    nameController.clear();
    timeController.clear();
    descController.clear();
    servingController.clear();
    updateType("Main dishes");
    ingredientList.clear();
    stepList.clear();
    stepController.returnZero();

    String status = await checkRecentRecipe();

    status == "done" ? Get.offAllNamed("/content") : null;
    Get.snackbar("Success", "You have added a new recipe successfully!",
      backgroundColor: Colors.blueAccent,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  Future<String> checkRecipeType(String type) async{
    AuthenticationController.instance.showDialog();

    String id = auth.currentUser!.uid;
    await myRef.child("Users").child(id).child("recipes").child(type).once().then((DataSnapshot? snapshot){
      recipeList.clear();

      if (snapshot!.exists) {
        var keys = snapshot.value.keys;
        var values = snapshot.value;

        for(var key in keys) {
          RecipeModel recipeModel = RecipeModel(
            values[key]["name"],
            values[key]["desc"],
            values[key]["duration"],
            values[key]["id"],
            values[key]["serving"],
            values[key]["type"],
          );

          recipeList.add(recipeModel);
        }
        checkType.value = 1;

      } else {
        checkType.value = 0;
      }
    });

    if (checkType.value == 1) {
      return "done";
    } else {
      return "noData";
    }
  }

  Future<String> checkRecentRecipe() async{
    String id = auth.currentUser!.uid;

    await myRef.child("Users").child(id).child("recent").limitToLast(10).once().then((DataSnapshot? snapshot){
      recentList.clear();

      if (snapshot!.exists) {
        var keys = snapshot.value.keys;
        var values = snapshot.value;

        for(var key in keys) {
          RecipeModel recipeModel = RecipeModel(
            values[key]["name"],
            values[key]["desc"],
            values[key]["duration"],
            values[key]["id"],
            values[key]["serving"],
            values[key]["type"],
          );

          recentList.add(recipeModel);
        }
      }
    });

    return "done";
  }

  Future<void> checkAllRecipe(String s) async{
    AuthenticationController.instance.showDialog();
    String id = auth.currentUser!.uid;

    await myRef.child("Users").child(id).child("recent").once().then((DataSnapshot? snapshot){
      recipeList.clear();

      if (snapshot!.exists) {
        var keys = snapshot.value.keys;
        var values = snapshot.value;

        for(var key in keys) {
          RecipeModel recipeModel = RecipeModel(
            values[key]["name"],
            values[key]["desc"],
            values[key]["duration"],
            values[key]["id"],
            values[key]["serving"],
            values[key]["type"],
          );

          recipeList.add(recipeModel);
        }
      }
    });
    
    Future.delayed(Duration(milliseconds: 3000), () {
      if (s == "none") {
        Get.back();
        Get.toNamed("/allRecipe");
      } else if(s == "delete") {
        Get.back();
        Get.back();
        Get.toNamed("/allRecipe");
        Get.snackbar("Success", "You have deleted your recipe successfully.",
          backgroundColor: Colors.blueAccent,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
      
    });
  }

  void deleteRecipe(String id, String type) {
    String uid = auth.currentUser!.uid; 
    Get.defaultDialog(
      title: "Delete?",
      middleText: "Are you confirm to delete the recipe?",
      titleStyle: TextStyle(color: Colors.black),
      middleTextStyle: TextStyle(color: Colors.black),
      textConfirm: "Yes",
      textCancel: "Cancel",
      cancelTextColor: Colors.black,
      confirmTextColor: Colors.black,
      buttonColor: Colors.red,
      barrierDismissible: false,
      onCancel: () {
        Get.back();
        Get.toNamed("/content");
        },
      onConfirm: () async {
        await myRef.child("Users").child(uid).child("recent").child(id).remove();
        await myRef.child("Users").child(uid).child("recipes").child(type).child(id).remove();
        String status = await checkRecentRecipe();
        status == "done" ? checkAllRecipe("delete") : null;

      }
    );
  }

  void editRecipe(String id, String type) {
    String uid = auth.currentUser!.uid; 

  }

  Future<String> viewRecipe(String id) async{
    AuthenticationController.instance.showDialog();
    String uid = auth.currentUser!.uid;
    
    await myRef.child("Users").child(uid).child("recent").child(id).once().then((DataSnapshot? snapshot){
      product.clear();

      if (snapshot!.exists) {
  
        RecipeModel recipeModel = RecipeModel(
          snapshot.value["name"],
          snapshot.value["desc"],
          snapshot.value["duration"],
          snapshot.value["id"],
          snapshot.value["serving"],
          snapshot.value["type"],
        );

        product.add(recipeModel);
      }

    });

    await myRef.child("Users").child(uid).child("recent").child(id).child("ingredients").once().then((DataSnapshot? snapshot){
      ingredients.clear();

      if (snapshot!.exists) {
       
        for(var data in snapshot.value) {
          ingredients.add(data);
        }
      }
    });

    await myRef.child("Users").child(uid).child("recent").child(id).child("steps").once().then((DataSnapshot? snapshot){
      steps.clear();

      if (snapshot!.exists) {
      
        for(var data in snapshot.value) {
          steps.add(data);
        }
      }
    });

    await myRef.child("Users").child(uid).child("recent").child(id).child("imgUrl").once().then((DataSnapshot? snapshot){
      image.clear();

      if (snapshot!.exists) {
      
        for(var data in snapshot.value) {
          image.add(data);
        }
      }
    });

    Get.back();
    return "done";
  
  }

}
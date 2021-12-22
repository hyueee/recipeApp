import 'dart:ffi';

import 'package:firstapp/controller/recipe_controller.dart';
import 'package:firstapp/login_page.dart';
import 'package:firstapp/my_home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class AuthenticationController extends GetxController{

  // FirebaseAuth _auth = FirebaseAuth.instance;
  // Rxn<User> _firebaseUser = Rxn<User>();

  static AuthenticationController instance = Get.find();
  final recipeController = Get.put(RecipeController());
  FirebaseAuth auth = FirebaseAuth.instance;
  final DatabaseReference myRef = FirebaseDatabase.instance.reference();

  late Rx<User?> _user;
  RxString username = "".obs;
  RxString email = "".obs;
  RxString image = "".obs;

  @override
  void onReady(){
    super.onReady();
    _user = Rx<User?>(auth.currentUser);

    //firebase user will be notified
    _user.bindStream(auth.userChanges());

    //listener and callback (listen when user status change)
    ever(_user, _initScreen);
  }

  _initScreen(User? user){
    if(user == null){
      Get.offAll(() => const LoginPage());
    } else {
      Get.offAll(() => const MyHomePage());
    }
  }

  Future<void> register(String username, String email, String password) async {
    try{
      await auth.createUserWithEmailAndPassword(email: email, password: password).then((result) {
        String id = result.user!.uid;
        addToFirebase(id, username, email);
      });
    }catch(e){
      Get.snackbar("Register failed", "message",
      backgroundColor: Colors.blueAccent,
      snackPosition: SnackPosition.BOTTOM,
      titleText: const Text(
        "Register failed",
        style: TextStyle(
          color: Colors.white),
      ), 
      messageText: Text(
        e.toString(),
        style: const TextStyle(
          color: Colors.white ),
      )
      );

    }
  }

  Future<void> login(String email, String password) async {
    try{
      await auth.signInWithEmailAndPassword(email: email, password: password);
    }catch(e){
      Get.snackbar("Login failed", "message",
      backgroundColor: Colors.blueAccent,
      snackPosition: SnackPosition.BOTTOM,
      titleText: const Text(
        "Login failed",
        style: TextStyle(
          color: Colors.white),
      ), 
      messageText: Text(
        e.toString(),
        style: const TextStyle(
          color: Colors.white ),
      )
      );

    }
  }

  Future<void> logout() async {
    await auth.signOut();
  }

  void addToFirebase (String id, String username, String email){
    myRef.child("Users").child(id).set({
      'name': username,
      'email': email,
      'id': id,
    }).whenComplete(() => 
      Get.snackbar("Success", "You have created your account successfully!",
        backgroundColor: Colors.blueAccent,
        snackPosition: SnackPosition.BOTTOM,
        )
    );
  }
    
  Future<String> viewUser() async {
    String id = auth.currentUser!.uid;
    await myRef.child("Users").child(id).once().then((DataSnapshot snapshot){
      username.value = snapshot.value['name'];
      email.value = snapshot.value["email"];
      image.value = snapshot.value["image"];

      // Map<dynamic, dynamic> values = snapshot.value;
      // values.forEach((key,values) {
      //   username.value = values[key]["name"];
      //   email.value = values[key]["email"];
      // });
    });

    return "done";
  }

  showDialog(){
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            height: 40,
            child: Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Loading",
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  
}


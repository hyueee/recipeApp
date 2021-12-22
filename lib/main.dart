import 'package:firebase_core/firebase_core.dart';
import 'package:firstapp/all_recipe_page.dart';
import 'package:firstapp/controller/authentication_controller.dart';
import 'package:firstapp/login_page.dart';
import 'package:firstapp/my_content_page.dart';
import 'package:firstapp/my_home_page.dart';
import 'package:firstapp/recipe_detail_page.dart';
import 'package:firstapp/recipe_type_page.dart';
import 'package:firstapp/register_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'add_recipe_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) => Get.put(AuthenticationController()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      // home: const MyHomePage(), ---> normal flutter
      initialRoute: "/" ,
      getPages: [
        GetPage(name: "/", page: ()=>const LoginPage()),
        GetPage(name: "/home", page: ()=>const MyHomePage()),
        GetPage(name: "/detail", page: ()=>const RecipeDetailPage()),
        GetPage(name: "/content", page: ()=>const ContentPage()),
        GetPage(name: "/register", page: ()=>const RegisterPage()),
        GetPage(name: "/addRecipe", page: ()=>const AddRecipePage()),
        GetPage(name: "/recipeType", page: ()=>const RecipeTypePage()),
        GetPage(name: "/allRecipe", page: ()=>const AllRecipePage()),
      ],
    );
  }
}




// import 'dart:convert';

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:firstapp/controller/authentication_controller.dart';
// import 'package:firstapp/recent_contests.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class ContentOldPage extends StatefulWidget {
//   const ContentOldPage({Key? key}) : super(key: key);

//   @override
//   _ContentOldPageState createState() => _ContentOldPageState();
// }

// class _ContentOldPageState extends State<ContentOldPage> {

//   List list = [];
//   List info = [];

//   _readData() async {
//     await DefaultAssetBundle.of(context).loadString("json/recent.json").then((s){
//       setState(() {
//         list = json.decode(s);
//       });
//     });
//     await DefaultAssetBundle.of(context).loadString("json/detail.json").then((s){
//       setState(() {
//         info = json.decode(s);
//       });
//     });
//   }

//   @override
//   void initState(){
//     _readData();
//     AuthenticationController.instance.viewUser();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//     int _currentIndex  = 0;
    
//     return
//       Scaffold(
//         body: Container(
//           padding: const EdgeInsets.only( top:50),
//           color:const Color(0xFFc5e5f3),
//           child: Column(
//             children: [
//               //user
//               Container(
//                 width: width,
//                 height: 100,
//                 margin: const EdgeInsets.only(left: 25, right: 25),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20),
//                   color:const Color(0xFFebf8fd),
//                 ),
//                 child: Container(
//                   padding: const EdgeInsets.only(left: 20, right: 20),
//                   child: Row(
//                     children: [
//                       Obx(
//                         () =>   
//                         // FadeInImage.assetNetwork(
//                         //   placeholder: 'images/pic-1.png',
//                         //   image:  '${controller.image.value}',
//                         // )
//                         CircleAvatar(
//                           radius:40,
//                           backgroundImage: 
//                             CachedNetworkImageProvider(
//                               AuthenticationController.instance.image.value
//                             ),
//                         ),
//                       ),
//                       const SizedBox(width: 10,),
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Obx(
//                             () => Text(AuthenticationController.instance.username.value,
//                             style: TextStyle(
//                                 color:Color(0xFF3b3f42),
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 decoration: TextDecoration.none
//                             ),
//                             )
//                           ),
//                           SizedBox(height: 5,),
//                           Obx(
//                             () => Text(AuthenticationController.instance.email.value,
//                             style: TextStyle(
//                                 color:Colors.cyan,
//                                 fontSize: 12,
//                                 decoration: TextDecoration.none
//                             ),
//                             )
//                           ),
//                         ],
//                       ),
//                       Expanded(child: Container()),
//                       Container(
//                         width: 50,
//                         height: 50,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20),
//                             color:const Color(0xFFf3fafc)
//                         ),
//                         child: Center(
//                           child: IconButton(
//                             icon: Icon(
//                             Icons.logout,
//                             color:Color(0xFF69c5df),
//                             size: 30, 
//                             ), onPressed: () {  
//                               AuthenticationController.instance.logout();
//                             },
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 30,),
//               //recipe types
//               Container(
//                 padding: const EdgeInsets.only(left: 25, right: 25),
//                 child: Row(
//                   children: [
//                     const Text(
//                       "Recipe Types",
//                       style: TextStyle(
//                           color:Color(0xFF1f2326),
//                           fontSize: 20,
//                           decoration: TextDecoration.none
//                       ),
//                     ),
//                     Expanded(child: Container()),
//                     const Text(
//                       "Show all",
//                       style: TextStyle(
//                           color:Colors.black,
//                           fontSize: 15,
//                           decoration: TextDecoration.none
//                       ),
//                     ),

//                     const SizedBox(width: 5,),
//                     Container(
//                       width: 50,
//                       height: 50,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           color: const Color(0xFFfdc33c)
//                       ),
//                       child: GestureDetector(
//                         onTap: (){
//                           Get.to(()=> const RecentContests());
//                         },
//                         child: Icon(Icons.arrow_forward_ios, color: Colors.white,)
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20,),
//               //list
//               SizedBox(
//                 height: 220,
//                 child: PageView.builder(
//                     controller: PageController(viewportFraction: 0.8),
//                     itemCount: info.length,
//                     itemBuilder: (_, i){
//                       return GestureDetector(
//                         onTap: (){
//                            Get.toNamed("/detail");
//                           // Get.toNamed("/detail", arguments: {
//                           //   "title" : info[i]['title'].toString(), 
//                           //   "name" : info[i]['name'].toString(),
//                           //   "img" : info[i]['img'].toString(),
//                           //   "text" : info[i]['text'].toString(), 
//                           //   "time" : info[i]['time'].toString(), 
//                           //   "prize" : info[i]['prize'].toString(), 
//                           // });
//                         },

//                         child: Container(
//                           padding: const EdgeInsets.only(left: 10, top: 10),
//                           height: 220,
//                           width: MediaQuery.of(context).size.width-20,
//                           margin: const EdgeInsets.only(right: 10),
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(30),
//                               color:i.isEven?Color(0xFF69c5df):Color(0xFF9294cc)
//                           ),
//                           child: Column(
//                             children: [
//                               Row(
//                                 children: [
//                                   Text(
//                                     info[i]['title'],
//                                     style: const TextStyle(
//                                         fontSize: 30,
//                                         fontWeight: FontWeight.w500,
//                                       color:Colors.white
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 10),
//                               SizedBox(
//                                 width: width,
//                                 child: Text(
//                                   info[i]['text'],
//                                   style: const TextStyle(
//                                       fontSize: 20,
//                                       color:Color(0xFFb8eefc)
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(height: 5,),
//                               const Divider(thickness: 1.0,),
//                               Row(
//                                   children:[
//                                     for(int i=0; i<4; i++)
//                                     SizedBox(
//                                       width: 50,
//                                       height: 50,
//                                       child: Container(

//                                         decoration: BoxDecoration(
//                                             borderRadius: BorderRadius.circular(25),
//                                             image: DecorationImage(
//                                                 image: AssetImage(
//                                                    info[i]['img'],
//                                                 ),
//                                                 fit: BoxFit.cover
//                                             )
//                                         ),
//                                       ),
//                                     )
//                                   ]
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     }),
//               ),
//               SizedBox(height: 30,),
//               //recent contests
//               Container(
//                 padding: const EdgeInsets.only(left: 25, right: 25),
//                 child: Row(
//                   children: [
//                     const Text(
//                       "Recent Contests",
//                       style: TextStyle(
//                           color:Color(0xFF1f2326),
//                           fontSize: 20,
//                           decoration: TextDecoration.none
//                       ),
//                     ),
//                     Expanded(child: Container()),
//                     Text(
//                       "Show all",
//                       style: TextStyle(
//                           color:Color(0xFFcfd5b3),
//                           fontSize: 15,
//                           decoration: TextDecoration.none
//                       ),
//                     ),

//                     SizedBox(width: 5,),
//                     Container(
//                       width: 50,
//                       height: 50,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           color: Color(0xFFfdc33c)
//                       ),
//                       child: GestureDetector(
//                         onTap: (){
//                           Get.to(()=> const RecentContests());
//                         },
//                         child: Icon(Icons.arrow_forward_ios, color: Colors.white,)
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               SizedBox(height: 20,),
//               Expanded(
//                child:   
//                   MediaQuery.removePadding(context: context,
//                       removeTop: true,
//                       child: ListView.builder(
//                           shrinkWrap: true,
//                           scrollDirection: Axis.vertical,
//                           itemCount: list.length,
//                           itemBuilder: (_, i){
//                             return Container(
//                               width: width,
//                               height: 100,
//                               margin: const EdgeInsets.only(left: 25, right: 25, bottom: 20),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(20),
//                                 color:Color(0xFFebf8fd),
//                               ),
//                               child: Container(
//                                 padding: const EdgeInsets.only(left: 10),
//                                 child: Row(
//                                   children: [
//                                     CircleAvatar(
//                                       radius:40,
//                                       backgroundImage: AssetImage(
//                                           list[i]["img"]
//                                       ),
//                                     ),
//                                     SizedBox(width: 10,),
//                                     Column(
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           list[i]["status"],
//                                           style: const TextStyle(
//                                               color:Colors.orangeAccent,
//                                               fontSize: 12,
//                                               decoration: TextDecoration.none
//                                           ),
//                                         ),
//                                         const SizedBox(height: 5,),
//                                         SizedBox(
//                                           width: 170,
//                                           child: Text(
//                                             list[i]["text"],
//                                             style: const TextStyle(
//                                                 color:Color(0xFF3b3f42),
//                                                 fontSize: 18,
//                                                 decoration: TextDecoration.none
//                                             ),
//                                           ),
//                                         )

//                                       ],
//                                     ),
//                                     Expanded(child: Container()),
//                                     Container(
//                                       width: 70,
//                                       height: 70,

//                                       child: Text(
//                                         list[i]["time"],
//                                         style: const TextStyle(
//                                             fontSize: 10,
//                                             decoration: TextDecoration.none,
//                                             color:Color(0xFFb2b8bb)
//                                         ),
//                                       ),
//                                     ),

//                                   ],
//                                 ),
//                               ),
//                             );
//                           })

//                   )

//               ),
//             ],
//           ),
//         ),
//       );


//   }
// }

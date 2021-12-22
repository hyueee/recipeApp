// import 'dart:convert';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_navigation/src/extension_navigation.dart';

// class RecentContests extends StatefulWidget {
//   const RecentContests({Key? key}) : super(key: key);

//   @override
//   _RecentContestsState createState() => _RecentContestsState();
// }

// class _RecentContestsState extends State<RecentContests> {

//   List info = [];

//   _readData() async {
//     await DefaultAssetBundle.of(context).loadString("json/detail.json").then((s){
//       setState(() {
//         info = json.decode(s);
//       });
//     });
//   }

//   @override
//   void initState(){
//     _readData();
//     super.initState();
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: Column(
//           children: [
//             Expanded(child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   for (int i = 0; i < info.length; i++)
//                     Container(
//                     alignment: Alignment.center,
//                     margin: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
//                     height: 200,
//                     child: GestureDetector(
//                         onTap: (){
//                           Get.toNamed("/detail", arguments: {
//                             "title" : info[i]['title'].toString(), 
//                             "name" : info[i]['name'].toString(),
//                             "img" : info[i]['img'].toString(),
//                             "text" : info[i]['text'].toString(), 
//                             "time" : info[i]['time'].toString(), 
//                             "prize" : info[i]['prize'].toString(), 
//                           });
//                         },

//                         child: Container(
//                           padding: const EdgeInsets.only(left: 10, top: 10),
//                           height: 200,
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
//                                   Expanded(child: Container())
//                                 ],
//                               ),
//                               const SizedBox(height: 10),
//                               SizedBox(
//                                 width: MediaQuery.of(context).size.width,
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
//                                   children:[for(int i=0; i<4; i++)
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
                      
//                     ),
//                     ),
                
//                 ],
//               )
//             ))
//           ]
//         )
//       ),
//     );
//   }
// }
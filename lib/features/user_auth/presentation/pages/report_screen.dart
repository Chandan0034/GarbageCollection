// import 'dart:async';
// import 'dart:ffi';
// import 'dart:io';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// class ReportScreen extends StatefulWidget {
//   const ReportScreen({super.key});
//
//   @override
//   State<ReportScreen> createState() => _ReportScreenState();
// }
//
// class _ReportScreenState extends State<ReportScreen> {
//   List<String> imageUrls = [];
//   List<Double> latitude = [];
//   List<Double> lognitude = [];
//
//   Future<void> getImageUrls() async {
//     final databaseReference = FirebaseDatabase.instance.reference();
//     DataSnapshot snapshot = (await databaseReference.child('images').once()) as DataSnapshot;
//     if (snapshot.value != null) {
//       Map<dynamic, dynamic> values = snapshot.value as Map<String,dynamic>;
//       values.forEach((key, value) {
//         imageUrls.add(value['imageUrl']);
//         latitude.add(value['latitude']);
//         lognitude.add(value['longitude']);
//       });
//     }
//   }
//
//   // int positionList=-1;
//   // List<String> imagesPath=[];
//   // List<String> latitue=[];
//   // List<String> lognitude=[];
//   // Future<void> fetchImagesUrls() async{
//   //   SharedPreferences preferences=await SharedPreferences.getInstance();
//   //   List<String> storedPath=preferences.getStringList("imagePath") ??[];
//   //   List<String> storeLatitute=preferences.getStringList("latitude")??[];
//   //   List<String> storeLognitude=preferences.getStringList("longitude")??[];
//   //   setState(() {
//   //     imagesPath=storedPath;
//   //     latitue=storeLatitute;
//   //     lognitude=storeLognitude;
//   //   });
//   //}
//   Widget _buildImageContainer(String imagePath,Double la,Double ln,String Stauts) {
//     return Container(
//       padding: EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         color: Colors.black12
//       ),
//       margin: EdgeInsets.all(10.0), // Add margin for spacing
//       child: Column(
//         children: [
//           Image.network(imagePath,width: double.infinity, height: 200,fit: BoxFit.cover,),
//
//           SizedBox(height: 20,),
//           Row(
//             children: [
//               Text(la as String,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 16),),
//               // Text(latitue[position]),
//               SizedBox(width: 20,),
//               Text(ln as String,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 16),),
//               // Text(lognitude[position]),
//               SizedBox(width: 10,),
//               Text('${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}'),
//             ],
//           ),
//           SizedBox(height: 8,),
//           Text(Stauts,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red,fontSize: 16),)
//         ],
//       ),
//     );
//   }
  // final DatabaseReference databaseReference=FirebaseDatabase.instance.ref().child('image');
  // List<Map<String,dynamic>> imageUrl=[];
  // Future<void> fetchImagesUrls()  async{
  //   DataSnapshot dataSnapshot=(await databaseReference.once()) as DataSnapshot;
  //   if(dataSnapshot.value!=null){
  //     Map<String,dynamic>imageData=dataSnapshot.value as Map<String,dynamic>;
  //     imageData.forEach((key, value) {
  //       imageUrl.add({
  //         'name':value['name'],
  //         'url':value['url']
  //       });
  //     });
  //     setState(() {
  //
  //     });
  //   }
 // }
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getImageUrls();
//   }
//   @override
//   Widget build(BuildContext context) {
//
//       return Scaffold(
//       appBar: AppBar(
//         title: Text("Report"),
//       ),
//       body: ListView.builder(
//         itemCount:imageUrls .length,
//           itemBuilder: (BuildContext context,int index){
//             if(index >= 0 && index <imageUrls .length) {
//               return _buildImageContainer(imageUrls[index],latitude[index],lognitude[index],index%2==0?"Completed":"In Process");
//             }},
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
//
//
// void main() {
//   runApp(ProviderScope(child: MyApp()));
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }
//
// class MyHomePage extends HookWidget {
//   @override
//   Widget build(BuildContext context) {
//     final textEditingController = useTextEditingController();
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Stack(
//         children: [
//           Container(
//             color: const Color(0xffE9EFFD),
//             padding: const EdgeInsets.only(top: kToolbarHeight),
//             child: Align(
//               alignment: Alignment.topCenter,
//               child: Text(
//                 'Calm tweeter',
//                 style: Theme.of(context).textTheme.headline4,
//               ),
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.all(12.0),
//             margin: const EdgeInsets.only(top: kToolbarHeight * 2),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(42),
//                 topRight: Radius.circular(42),
//               ),
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: <Widget>[
//                 Spacer(),
//                 TweetResponse(),
//                 Spacer(),
//                 CustomInputField(
//                   onPressed: () => postTweet(context, textEditingController),
//                   textEditingController: textEditingController,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void postTweet(BuildContext context, TextEditingController tweetTextEditingController) async {
//     if (tweetTextEditingController.text.isEmpty) return;
//
//     final result = await context.read(twitterControllerProvider).postTweet(tweetTextEditingController.text);
//     if (result.isRight()) {
//       tweetTextEditingController.clear();
//     }
//   }
// }
//
// class CustomInputField extends StatelessWidget {
//   const CustomInputField({
//     Key key,
//     @required this.textEditingController,
//     @required this.onPressed,
//   }) : super(key: key);
//
//   final TextEditingController textEditingController;
//   final VoidCallback onPressed;
//
//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       controller: textEditingController,
//       keyboardType: TextInputType.multiline,
//       minLines: 1,
//       maxLines: 4,
//       maxLength: 280,
//       maxLengthEnforced: true,
//       decoration: InputDecoration(
//         hintText: 'How are you all doing?',
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide.none,
//         ),
//         suffixIcon: ClipOval(
//           child: Material(
//             color: Colors.white.withOpacity(0.0),
//             child: IconButton(
//               onPressed: onPressed,
//               icon: Icon(Icons.send),
//             ),
//           ),
//         ),
//         filled: true,
//         fillColor: const Color(0xffF6F8FD),
//       ),
//     );
//   }
// }
//
// class TweetResponse extends HookWidget {
//   @override
//   Widget build(BuildContext context) {
//     final tweetControllerState = useProvider(twitterControllerProvider.state);
//     final theme = Theme.of(context).textTheme.headline6.copyWith(color: const Color(0xff2F3A5D));
//     return tweetControllerState.when(
//       data: (data) => Text(data.isEmpty ? 'Write a tweet 😊' : 'Tweet: $data', style: theme),
//       loading: () => CircularProgressIndicator(),
//       error: (err, sr) {
//         if (err is Failure) {
//           return Text(err.message, style: theme);
//         }
//         return Text('An unexpected error occurred 😢', style: theme);
//       },
//     );
//   }
// }
import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

//Future<List<String>> fetchData() async {
//   final databaseReference = FirebaseDatabase.instance.reference();
//   DataSnapshot snapshot = (await databaseReference.child('images').once()) as DataSnapshot;
//
//   final values = snapshot.value;
//   List<String> image=[];
//   if (values is Map<String, dynamic>?) {
//     // Cast to Map<String, dynamic> is successful and not null
//     final data = values;
//
//     // Now you can access the data within the map
//     String? someValue = data?['imageUrl'];
//
//     if (someValue != null) {
//
//     } else {
//       // Handle the case where 'someValue' is null
//       print('Data is null for someKey');
//     }
//   } else {
//     // Handle the case where 'values' is not a Map<String, dynamic> or is null
//     print('Invalid data structure or data is null');
//   }
// }

// Future<List<String>> getImageUrls() async {
//   final databaseReference = FirebaseDatabase.instance.reference();
//   DataSnapshot snapshot = (await databaseReference.child('images').once());
//
//   List<String> imageUrls = [];
//   if (snapshot.value != null) {
//    Object? values = snapshot.value ;
//    print("Object printed");
//    print(values);
//    Map<String, dynamic>? data = values as Map<String, dynamic>?;
//    if(data!=null){
//      String? someValue = data['imageUrl'];
//      imageUrls.add(someValue!);
//    }
//     // values.forEach((key, value) {
//     //   imageUrls.add(value['imageUrl']);
//     // });
//   }else {
//   }
//   return imageUrls;
// }
//
// class ReportScreen extends StatefulWidget {
//   @override
//   State<ReportScreen> createState() => _ReportScreenState();
// }
//
// class _ReportScreenState extends State<ReportScreen> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     getImageUrls();
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: getImageUrls(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator();
//         } else if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         } else if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
//           return Text('No images found.');
//         } else {
//           List<String> imageUrls = snapshot.data as List<String>;
//           return ListView.builder(
//             itemCount: imageUrls.length,
//             itemBuilder: (context, index) {
//               return Image.network(imageUrls[index]);
//             },
//           );
//         }
//       },
//     );
//   }
// }
//

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final databaseReference = FirebaseDatabase.instance.reference().child('images');
  List<String> imageUrls = [];

  @override
  void initState() {
    super.initState();
    // Retrieve image URLs from Firebase
    fetchImageUrls();
  }

  void fetchImageUrls() {
    databaseReference.once().then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        Map<dynamic, dynamic> values = snapshot.value as Map<dynamic,dynamic >;
        values.forEach((key, value) {
          if (value != null && value['imageUrl'] != null) {
            setState(() {
              imageUrls.add(value['imageUrl']);
            });
          }
        });
      }
    } as FutureOr Function(DatabaseEvent value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image List'),
      ),
      body: ListView.builder(
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return Image.network(imageUrls[index]);
        },
      ),
    );
  }
}

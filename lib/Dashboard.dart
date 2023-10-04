import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase/features/user_auth/presentation/pages/Feedback_page.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter_firebase/features/user_auth/presentation/pages/login_page.dart';
import 'package:flutter_firebase/features/user_auth/presentation/pages/report_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const MaterialApp(
    home: Dashboard(),
  ));
}
final auth=FirebaseAuth.instance;
late double latitudes;
late double longitudes;
// late StreamSubscription<Position> streamSubscription;
class Dashboard extends StatefulWidget {
  // void getCurrentPosition() async{
  //   LocationPermission locationPermission=await Geolocator.checkPermission();
  //   //Geolocator.requestPermission();
  //   if(locationPermission==LocationPermission.denied || locationPermission==LocationPermission.deniedForever){
  //     print("Permission Not Given");
  //   }else{
  //     // Position position=await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
  //     // longitudes=position.longitude.toString();
  //     // latitudes=position.latitude.toString();
  //     Geolocator.requestPermission();
  //     streamSubscription=Geolocator.getPositionStream().listen((Position position) {
  //       latitudes=position.latitude;
  //       longitudes=position.longitude;
  //       getAddressFromLang(position);
  //     });
  //   }
  // }
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}
class _DashboardState extends State<Dashboard> {
  late double latitudes;
  late double longitudes;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Geolocator.requestPermission();
  }
  final databaseReference=FirebaseDatabase.instance.ref();
   final FirebaseStorage firebaseStorage=FirebaseStorage.instance;
   File ? image;
    final  _picker=ImagePicker();
   // List<String> imagePath=[];
   // List<String> latitute=[];
   // List<String> longitude=[];
  Future<String?> uploadImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      final storageReference = FirebaseStorage.instance
          .ref()
          .child('images')
          .child('image_${DateTime.now().millisecondsSinceEpoch}.jpg');

      final uploadTask = storageReference.putFile(File(pickedFile.path));
      final snapshot = await uploadTask.whenComplete(() => null);

      if (snapshot.state == TaskState.success) {
        final downloadUrl = await storageReference.getDownloadURL();
        return downloadUrl;
      }
    }
    return null; // Return null if the upload fails.
  }

  Future<void> pickImageAndStore()async{
    // final pickerImage=await _picker.pickImage(source: ImageSource.camera);
    // LocationPermission permission=await Geolocator.checkPermission();
    // try{
    //   if(permission==LocationPermission.denied||permission==LocationPermission.deniedForever){
    //     Geolocator.requestPermission();
    //   }else{
    //     Position position=await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    //     latitute.add(position.latitude.toString());
    //     longitude.add(position.longitude.toString());
    //     Geolocator.requestPermission();
    //   }
    //
    // }catch(e){
    //   print(e.toString());
    // }
    try {
      LocationPermission permission=await Geolocator.checkPermission();
      try{
        if(permission==LocationPermission.denied||permission==LocationPermission.deniedForever){
          Geolocator.requestPermission();
        }else{
          Position position=await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
          latitudes=position.latitude;
          longitudes=position.longitude;
          Geolocator.requestPermission();
        }
      }catch(e){
        print(e);
      }
        String? imageUrl= await uploadImage();
        final databaseReference = FirebaseDatabase.instance.reference();
        final imageKey = databaseReference.child('images').push().key;

        await databaseReference.child('images/$imageKey').set({
          'imageUrl': imageUrl,
          'latitude':latitudes,
          'longitude':longitudes
        });
      // if (pickerImage != null) {
      //   final storageReference = FirebaseStorage.instance.ref().child('images').child(DateTime.now().toString() + '.jpg');
      //
      //   // Upload the image to Firebase Storage
      //   final uploadTask = storageReference.putFile(File(pickerImage!.path));
      //
      //   // Get the download URL after the image is uploaded
      //   final snapshot = await uploadTask.whenComplete(() => null);
      //   final downloadUrl = await snapshot.ref.getDownloadURL();
      //
      //   // Save the download URL in Firebase Realtime Database
      //   final databaseReference = FirebaseDatabase.instance.ref();
      //   final imageKey = databaseReference.child('images').push().key;
      //
      //   await databaseReference.child('images/$imageKey').set({
      //     'imageUrl': downloadUrl,
      //   });
        // if (pickerImage != null) {
        //   final imageKey=databaseReference.child('image').push().key;
        //   await databaseReference.child('image${imageKey}').set({
        //     'imageUrl':
        //   });
          // SharedPreferences preferences = await SharedPreferences.getInstance();
          // preferences.setStringList("imagePath", imagePath);
          // preferences.setStringList("latitude", latitute);
          // preferences.setStringList("longitude", longitude);
        //}
        //   if(image==null)return;
        //   final imageFile=File(image.path);
        //   // setState(() =>
        //   // this.image=imageTemp);
        //   //String fileName=DateTime.now().toString();
        //   TaskSnapshot snapshot=await firebaseStorage.ref().child('image/${DateTime.now()}.jpeg').putFile(imageFile);
        //   String imageUrl=await snapshot.ref.getDownloadURL();
        //   await databaseReference.child('image').push().set({
        //     'name':'Image name',
        //     'description':'Discription',
        //     'url':imageUrl,
        //   });
        //   print('Emage Url Given${imageUrl}');
        //   print("uploade Succefull");
        // }on PlatformException catch(e){
        //   print("Failed to pick image");
      } catch (e) {
        print(e.toString());
      }
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(icon:Icon(Icons.login_outlined),
          onPressed: (){
            auth.signOut().then((value) {
              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>LoginPage()));
            }).onError((error, stackTrace) {
              print("Error Occured" +error.toString());
            });
          },),
        ],
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.menu, color: Colors.white, size: 30.0),
                    // Image.asset("assets/images/girl.jpg", width: 50.0)
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(18.0),
                child: Text(
                  "Dashboard Options",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(
                  child: Wrap(
                    spacing: 20.0,
                    runSpacing: 20.0,
                    children: [
                      SizedBox(
                          width: 160.0,
                          height: 160.0,
                          child: InkWell(
                            onTap: (){
                              pickImageAndStore();
                              // getCurrentPosition();
                              // if(longitudes!=0 && latitudes!=0){
                              //
                              //     Longitude:longitudes,
                              //     Latitude: latitudes,
                              //   )));
                              // }else{
                              //   getCurrentPosition();
                              // }
                            },
                            child: Card(
                                color: const Color.fromARGB(255, 21, 21, 21),
                                elevation: 2.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
                                child: Center(
                                    child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(children: [

                                          //const SizedBox(height: 10.0),
                                          const Text("Report",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20.0)),
                                          const SizedBox(height: 5.0),
                                          const Text("Report Garbage",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w100,
                                              )),
                                        ])))),
                          )),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ReportScreen()));
                        },
                        child: SizedBox(
                            width: 160.0,
                            height: 160.0,
                            child: Card(
                                color: const Color.fromARGB(255, 21, 21, 21),
                                elevation: 2.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
                                child: Center(
                                    child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(children: [
                                          // Image.asset("assets/images/inboxmail.jpg",
                                          //     width: 64.0),
                                          const SizedBox(height: 10.0),
                                          const Text("Response",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20.0),),
                                          const SizedBox(height: 5.0),
                                          const Text("Check Response",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w100,
                                              ),),
                                        ],),),),),),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>FeedBackPage()));
                        },
                        child: SizedBox(
                            width: 160.0,
                            height: 160.0,
                            child: Card(
                                color: const Color.fromARGB(255, 21, 21, 21),
                                elevation: 2.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),),
                                child: Center(
                                    child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(children: [
                                          // Image.asset("assets/images/feed.jpg",
                                          //     width: 64.0),
                                          const SizedBox(height: 10.0),
                                          const Text("Feedback",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20.0),),
                                          const SizedBox(height: 5.0),
                                          const Text("Give Feedback",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w100,
                                              ),),
                                        ],),),),),),
                      ),
                      SizedBox(
                        width: 160.0,
                        height: 160.0,
                        child: Card(
                          color: const Color.fromARGB(255, 21, 21, 21),
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  // Image.asset("assets/images/partenrs.jpg",
                                  //     width: 64.0),
                                  const SizedBox(height: 10.0),
                                  const Text("Community",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0)),
                                  const SizedBox(height: 5.0,),
                                  const Text(
                                    "Join Community",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w100,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
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
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

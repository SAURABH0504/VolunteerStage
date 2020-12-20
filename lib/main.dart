import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:volunteerstage/Model/Application.dart';
import 'package:volunteerstage/Model/Field.dart';
import 'package:volunteerstage/Model/Location.dart';
import 'package:volunteerstage/Model/NGO.dart';
import 'package:volunteerstage/Model/Volunteer.dart';
import 'package:volunteerstage/Service/ApplicationService.dart';

void main() {
  runApp(new MaterialApp(
    home: Start(),
  ));
}

class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(seconds: 2,
      navigateAfterSeconds: FutureBuilder(
        // Initialize FlutterFire
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return Text('Connection Error');
          }
          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done){
            return MyApp();
          }
          // Otherwise, show something whilst waiting for initialization to complete
          return null;
        },
      ),
      title: Text('Volunteer Stage',style: TextStyle(
          color: Colors.black,
          fontSize: 25,
          fontWeight: FontWeight.bold
      ),),

      backgroundColor: Colors.white,
      photoSize: 100,
    );
  }
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  List<Widget> list=[
    Card(child: Image(image: AssetImage('Images/1.jpg'),),),
    Card(child: Image(image: AssetImage('Images/2.jpg'),),),
    Card(child: Image(image: AssetImage('Images/3.jpg'),),),
    Card(child: Image(image: AssetImage('Images/4.jpg'),),),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(title: Center(child: Text('Volunteer Stage')),backgroundColor: Colors.grey,),
        backgroundColor: Colors.white,
        body: Container(
          child: Column(
            children: [
              Expanded(flex:3,child: CarouselSlider(
                items: list,
                options: CarouselOptions(
                  aspectRatio: 1,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  autoPlayInterval: Duration(
                    seconds: 3,
                  ),
                ),
              ),),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Column(
                    children: [
                      Expanded(child: Text('Are you a ?',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),)),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            width:500,color: Colors.red.shade200,
                            child: FlatButton(child: Text('Volunteer',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),onPressed: (){
                            },),),
                        ),),
                      Expanded(flex: 1,child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(width:500,color: Colors.blue.shade100,child: FlatButton(child: Text('NGO',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),)),
                      ),),
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

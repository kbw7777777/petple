import 'dart:ui';

//import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:petple/main_page.dart';

//import 'package:petple/ui/user/user_widget.dart';


//void main() => runApp(MyApp());

//List<CameraDescription> cameras;

Future<Null> main() async {
  //WidgetsFlutterBinding.ensureInitialized();
 // cameras = await availableCameras();
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
        return new MaterialApp(
      title: "WhatsApp",
      theme: new ThemeData(
        primaryColor: Colors.white,
        accentColor: new Color(0xff25D366),
      ),
      debugShowCheckedModeBanner: false,
      home: new MainPage(),
    );
  }

}


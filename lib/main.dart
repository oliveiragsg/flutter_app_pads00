import 'package:flutter/material.dart';
import 'package:flutter_app_pads00/provider/users.dart';
import 'package:flutter_app_pads00/routes/app_routes.dart';
import 'package:flutter_app_pads00/views/bottomNavBar.dart';
import 'package:flutter_app_pads00/views/cameraScreen.dart';
import 'package:flutter_app_pads00/views/loginScreen.dart';
import 'package:flutter_app_pads00/views/partnersScreen.dart';
import 'package:flutter_app_pads00/views/profileScreen.dart';
import 'package:flutter_app_pads00/views/screen1_piano.dart';
import 'package:flutter_app_pads00/views/user_form.dart';
import 'package:flutter_app_pads00/views/user_list.dart';
import 'package:provider/provider.dart';
import 'views/screen0_home.dart';
import 'views/screen2_xylophone.dart';
import 'views/screen3_drum.dart';
import 'views/startScreen.dart';
import 'views/signupScreen.dart';
import 'package:camera/camera.dart';

Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;

  runApp(MyApp(camera: firstCamera));
}

class MyApp extends StatelessWidget {
  final camera;


  const MyApp({Key key, this.camera}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Users(),
      child: MaterialApp(
        title: 'Pads',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: "/",
          routes: {
            AppRoutes.START : (_) => startScreen(),
            AppRoutes.SIGNUP : (_) => signupScreen(),
            AppRoutes.LOGIN : (_) => loginScreen(),
            AppRoutes.HOME : (_) => Screen0(),
            AppRoutes.PIANO : (_) => Screen1(),
            AppRoutes.XYLOPHONE : (_) => Screen2(),
            AppRoutes.DRUM : (_) => Screen3(),
            AppRoutes.USER_FORM : (_) => UserForm(),
            AppRoutes.USER_LIST : (_) => UserList(),
            AppRoutes.PROFILE : (_) => profileScreen(),
            AppRoutes.BOTNAVBAR : (_) => MyStatefulWidget(),
            AppRoutes.PARTNERS : (_) => PartnersScreen(),
            AppRoutes.CAMERA : (_) => TakePictureScreen(camera: camera),
          },
      ),
    );
  }
}
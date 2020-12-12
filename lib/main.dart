import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_pads00/provider/users.dart';
import 'package:flutter_app_pads00/routes/app_routes.dart';
import 'package:flutter_app_pads00/views/albumScreen.dart';
import 'package:flutter_app_pads00/views/bottomNavBar.dart';
import 'package:flutter_app_pads00/views/cameraScreen.dart';
import 'package:flutter_app_pads00/views/gamesScreen.dart';
import 'package:flutter_app_pads00/views/loginScreen.dart';
import 'package:flutter_app_pads00/views/partnersScreen.dart';
import 'package:flutter_app_pads00/views/profileScreen.dart';
import 'package:flutter_app_pads00/views/registerScreen.dart';
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
  //Initialize Firebase it in the main() method after calling WidgetsFlutterBinding.ensureInitialized(); (get from https://stackoverflow.com/questions/63492211/no-firebase-app-default-has-been-created-call-firebase-initializeapp-in )
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

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
            AppRoutes.ALBUM : (_) => AlbumScreen(),
            AppRoutes.REGISTER : (_) => RegisterScreen(),
            AppRoutes.GAMES : (_) => GamesScreen(),
          },
      ),
    );
  }
}





// //1
//
// //Fazendo usando esse tutorial: https://medium.com/firebase-developers/dive-into-firebase-auth-on-flutter-email-and-link-sign-in-e51603eb08f8
//
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
//
// //2
// final FirebaseAuth _auth = FirebaseAuth.instance;
//
// void main() {
//   runApp(MyApp());
// }
//
//
//
// //3
// class MyApp extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Firebase Auth Demo',
//       home: MyHomePage(title: 'Firebase Auth Demo'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);
//   final String title;
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//
//   @override
//   void initState() {
//     super.initState();
//     Firebase.initializeApp().whenComplete(() {
//       print("completed");
//       setState(() {});
//     });
//   }
//
// //4
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//         actions: <Widget>[
//           Builder(builder: (BuildContext context) {
// //5
//             return FlatButton(
//               child: const Text('Sign out'),
//               textColor: Theme
//                   .of(context)
//                   .buttonColor,
//               onPressed: () async {
//                 final FirebaseUser user = await _auth.currentUser;
//                 if (user == null) {
// //6
//                   Scaffold.of(context).showSnackBar(const SnackBar(
//                     content: Text('No one has signed in.'),
//                   ));
//                   return;
//                 }
//                 await _auth.signOut();
//                 final String uid = user.uid;
//                 Scaffold.of(context).showSnackBar(SnackBar(
//                   content: Text(uid + ' has successfully signed out.'),
//                 ));
//               },
//             );
//           })
//         ],
//       ),
//       body: _RegisterEmailSection(),
//     );
//   }
// }
//
// class _RegisterEmailSection extends StatefulWidget {
//   final String title = 'Registration';
//   @override
//   State<StatefulWidget> createState() =>
//       _RegisterEmailSectionState();
// }
// class _RegisterEmailSectionState extends State<_RegisterEmailSection> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   bool _success;
//   String _userEmail;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Form(
//         key: _formKey,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             TextFormField(
//               controller: _emailController,
//               decoration: const InputDecoration(labelText: 'Email'),
//               validator: (String value) {
//                 if (value.isEmpty) {
//                   return 'Please enter some text';
//                 }
//                 return null;
//               },
//             ),
//             TextFormField(
//               controller: _passwordController,
//               decoration: const InputDecoration(labelText:
//               'Password'),
//               validator: (String value) {
//                 if (value.isEmpty) {
//                   return 'Please enter some text';
//                 }
//                 return null;
//               },
//             ),
//             Container(
//               padding: const EdgeInsets.symmetric(vertical: 16.0),
//               alignment: Alignment.center,
//               child: RaisedButton(
//                 onPressed: () async {
//                   if (_formKey.currentState.validate()) {
//                     _register();
//                   }
//                 },
//                 child: const Text('Submit'),
//               ),
//             ),
//             Container(
//               alignment: Alignment.center,
//               child: Text(_success == null
//                   ? ''
//                   : (_success
//                   ? 'Successfully registered ' + _userEmail
//                   : 'Registration failed')),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _register() async {
//     print("Registro!!!!!!!!!!!!!!");
//     final FirebaseUser user = (await
//     _auth.createUserWithEmailAndPassword(
//       email: _emailController.text,
//       password: _passwordController.text,
//     )
//     ).user;
//     if (user != null) {
//       setState(() {
//         _success = true;
//         _userEmail = user.email;
//       });
//     } else {
//       setState(() {
//         _success = true;
//       });
//     }
//   }
//
//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
//
//
//
// }
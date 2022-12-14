import 'package:chat_app_course/auth/sign_in_screen.dart';
import 'package:chat_app_course/auth/sign_up_screen.dart';
import 'package:chat_app_course/chat_screen.dart';
import 'package:chat_app_course/provider/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => AuthProvider()),
      ],
      child: MaterialApp(
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

        ),
        routes: {
          ChatScreen.routeName : (ctx) => ChatScreen(),
          LoginScreen.routeName : (ctx) => LoginScreen(),
          SignUpScreen.routeName : (ctx) => SignUpScreen(),

      },
        home: StreamBuilder(stream: FirebaseAuth.instance
            .idTokenChanges(), builder: (BuildContext context, AsyncSnapshot<User?> user) {
          if (user.data == null) {
            print('User is currently signed out!');
            return LoginScreen();
          } else {
            print('User is signed in!');
            return ChatScreen();
          }
        },),

      ),
    );
  }
}



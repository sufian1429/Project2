import 'package:ocr/Service/Auth_Service.dart';
import 'package:ocr/pages/HomePage.dart';
import 'package:ocr/pages/SignUpPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AuthClass authClass = AuthClass();
  Widget currentPage = SignUpPage();

  @override
  void initState() {
    super.initState();
    authClass.signOut();
    
    checkLogin();
  }

  checkLogin() async {
    String tokne = await authClass.getToken();
    print("tokne");
    if (tokne != null)
      setState(() {
        currentPage = HomePage();
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: currentPage,
      debugShowCheckedModeBanner: false,
      
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      //  RefreshIndicator(
      //     onRefresh : refresh),
    );
  }
}

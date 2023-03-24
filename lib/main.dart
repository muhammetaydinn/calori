// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:calori/screens/main_screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:calori/providers/daily_my_foods.dart';
import 'package:calori/providers/search_provider.dart';
import 'package:calori/screens/login.dart';

import 'providers/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String isToken = prefs.getString('token') ?? "false";
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AuthProvider()),
      ChangeNotifierProvider(
        create: (context) => SearchProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => DailyMyFoods(),
      )
    ],
    child: MyApp(
      isToken: isToken,
    ),
  ));
}

class MyApp extends StatelessWidget {
  final String isToken;
  const MyApp({
    Key? key,
    required this.isToken,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: isToken != "false" ? const MainScreens() : const LoginPage());
  }
}

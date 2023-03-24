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

// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';

// import 'firebase_options.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: 'Material App',
//       home: HomePahe(),
//     );
//   }
// }

// class HomePahe extends StatefulWidget {
//   const HomePahe({super.key});

//   @override
//   State<HomePahe> createState() => _HomePaheState();
// }

// class _HomePaheState extends State<HomePahe> {
//   final DatabaseReference _databaseReference =
//       FirebaseDatabase.instance.ref().child('myList');
//   final TextEditingController _textEditingController =
//       TextEditingController(text: "asdasd asdajdas");

//   List<String> _listItems = [];

//   final int _counter = 0;
//   @override
//   void initState() {
//     super.initState();
//     _loadList();
//   }

//   void _loadList() {
//     _databaseReference.onValue.listen((DatabaseEvent event) {
//       if (event.snapshot.value != null) {
//         List<String> tempList = [];
//         Map<dynamic, dynamic> map =
//             event.snapshot.value as Map<dynamic, dynamic>;
//         map.forEach((key, value) {
//           tempList.add(value.toString());
//         });
//         setState(() {
//           _listItems = tempList;
//         });
//       }
//     });
//   }

//   void _addItem(String itemName) {
//     if (itemName.isNotEmpty) {
//       _databaseReference.push().set([]);
//     }
//   }

//   void _removeItem(String itemName) {
//     _databaseReference
//         .orderByValue()
//         .equalTo(itemName)
//         .once()
//         .then((DatabaseEvent snapshot) {
//       if (snapshot.previousChildKey != null) {
//         Map<dynamic, dynamic> map =
//             snapshot.snapshot.value as Map<dynamic, dynamic>;
//         map.forEach((key, value) {
//           _databaseReference.child(key).remove();
//         });
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Counter exampler'),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             const Text('You have pushed the button this many times:'),
//             Text('$_counter'),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           setState(() {
//             // DatabaseReference databasee =
//             //     FirebaseDatabase.instance.ref().child("test");
//             // DatabaseReference database2 =
//             //     FirebaseDatabase.instance.ref("users/2/username");

//             // _counter++;
//             // databasee.set(["41", "42", "43", "44"]);
//             // database2.set(_counter);
//             // _addItem(_textEditingController.text.trim());

//             // _databaseReference.push().set([]);

//             // make Items list and add to database and remove  second  from database
//             List<String> items = ["item1", "item2", "item3"];
//             _databaseReference.set(items);
//             _databaseReference.child("item2").remove();
//           });
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

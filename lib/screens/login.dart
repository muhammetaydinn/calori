import 'package:calori/screens/register.dart';
import 'package:calori/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import 'main_screens.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    AuthService authService = AuthService();
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.grey,
            Colors.white,
            Colors.grey,
          ],
        )),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Container(
              decoration: _boxDecoration(Colors.black),
              margin: const EdgeInsets.symmetric(horizontal: 40),
              padding: const EdgeInsets.all(10),
              height: 350,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Giriş yap",
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 20),
                  _textfiled(authProvider.loginEmailnameController, "mal"),
                  _textfiled(authProvider.loginPasswordController, "Password"),
                  const SizedBox(height: 20),
                  _button(() async {
                    var a = await authService.login({
                      "returnSecureToken": true,
                      "email": authProvider.loginEmailnameController.text,
                      "password": authProvider.loginPasswordController.text,
                    });
                    if (a == "success") {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const MainScreens()));
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Giriş Başarılı")));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Giriş Başarısız $a")));
                    }
                  }, "Giriş", const Color.fromARGB(255, 4, 4, 4), Colors.white),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Hesabınız Yoksa"),
                      TextButton(
                          onPressed: () {
                            // print(
                            //     "loginEmailnameController: ${authProvider.loginEmailnameController.text}");
                            // print(
                            //     "loginPasswordController: ${authProvider.loginPasswordController.text}");

                            Navigator.pushReplacement(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      const RegisterPage(),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    const begin = Offset(0.0, 1.0);
                                    const end = Offset.zero;
                                    final tween = Tween(begin: begin, end: end);
                                    final offsetAnimation =
                                        animation.drive(tween);

                                    return SlideTransition(
                                      position: offsetAnimation,
                                      child: child,
                                    );
                                  },
                                ));
                          },
                          child: const Text("Kayıt Ol!")),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _textfiled(TextEditingController controller, String label) =>
      TextField(
        controller: controller,
        decoration: InputDecoration(labelText: label),
      );

  Widget _button(
      Function() onPressed, String text, Color bgColor, Color fgColor) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        foregroundColor: fgColor,
      ),
      child: Text(text),
    );
  }

  BoxDecoration _boxDecoration(Color colors) {
    return BoxDecoration(
      border: Border.all(color: colors, width: 3),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: colors,
          spreadRadius: 0,
          blurRadius: 0,
          offset: const Offset(7, 7),
        ),
      ],
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10)),
    );
  }
}

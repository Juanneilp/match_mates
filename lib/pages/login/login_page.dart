import 'package:flutter/material.dart';
import 'package:match_mates/pages/login/register_page.dart';

import '../bottom_nav.dart';

class LoginPage extends StatefulWidget {
  static const routeNamed = '/login_page';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final fieldText = TextEditingController();

  void clearText() {
    fieldText.clear();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      onVerticalDragEnd: (DragEndDetails details) =>
          FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
            // decoration: const BoxDecoration(
            //     image: DecorationImage(
            //         image: AssetImage('images/login_background.jpg'),
            //         fit: BoxFit.cover)),
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: Column(
                      children: const [
                        Text(
                          'Match Mates',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 50, left: 45, bottom: 20),
                  child: Row(
                    children: [
                      Text('LOG IN', style: TextStyle(fontSize: 25)),
                    ],
                  ),
                ),
                Container(
                  width: 320,
                  child: Column(
                    children: <Widget>[
                      LayoutBuilder(
                        builder: (context, constraints) {
                          return TextField(
                            decoration: InputDecoration(
                              icon: Icon(Icons.person),
                              labelText: 'Email',
                              suffixIcon: IconButton(
                                onPressed: clearText,
                                icon: Icon(
                                  Icons.close,
                                  size: 20,
                                ),
                              ),
                            ),
                            controller: fieldText,
                          );
                        },
                      ),
                      TextField(
                        decoration: InputDecoration(
                            icon: Icon(Icons.lock), labelText: 'Password'),
                        obscureText: true,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                  child: Container(
                    width: 300,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(BottomNavigation.routeNamed);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.lightBlueAccent,
                      ),
                      child: Text('Login'),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, RegisterPage.routeNamed);
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text('login with'),
                const SizedBox(
                  height: 10,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     IconButton(
                //       icon: Image.asset('images/ic_google.png'),
                //       iconSize: 50,
                //       onPressed: () {
                //         Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //                 builder: (context) => BottomNavigation()));
                //       },
                //     ),
                //     const SizedBox(width: 10),
                //     IconButton(
                //       icon: Image.asset('images/ic_github.png'),
                //       iconSize: 50,
                //       onPressed: () {
                //         Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //                 builder: (context) => BottomNavigation()));
                //       },
                //     ),
                //     const SizedBox(width: 10),
                //     IconButton(
                //       icon: Image.asset('images/ic_facebook.png'),
                //       iconSize: 50,
                //       onPressed: () {
                //         Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //                 builder: (context) => BottomNavigation()));
                //       },
                //     ),
                //   ],
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

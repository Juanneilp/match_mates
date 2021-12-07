import 'package:flutter/material.dart';

import '../bottom_nav.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  static const routeNamed = '/regis_page';

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      onVerticalDragEnd: (DragEndDetails details) =>
          FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10, left: 15, bottom: 5),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, LoginPage.routeNamed);
                        },
                        icon: const Icon(Icons.arrow_back, size: 30, color: Colors.redAccent,))
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30, left: 25, bottom: 20),
                child: Row(
                  children: [
                    Text('SIGN UP', style: TextStyle(fontSize: 25)),
                  ],
                ),
              ),
              Container(
                // color: Colors.grey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 330,
                      child: Column(
                        children: const <Widget>[
                          TextField(
                            decoration: InputDecoration(labelText: 'Full Name'),
                          ),
                          SizedBox(height: 10,),
                          TextField(
                            // controller: _username,
                            decoration: InputDecoration(labelText: 'Email'),
                          ),
                          SizedBox(height: 15,),
                          TextField(
                            decoration: InputDecoration(labelText: 'Password'),
                            obscureText: true,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                      child: Container(
                        width: 300,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (context) =>
                            //         Home(username: _username.text)));
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BottomNavigation()));
                            // Navigator.pushReplacementNamed(
                            //     context, BottomNavigation.routeName);
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.lightBlueAccent,
                          ),
                          child: Text('SIGN UP'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}

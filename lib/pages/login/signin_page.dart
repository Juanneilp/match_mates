import 'package:flutter/material.dart';
import 'package:match_mates/pages/login/signup_page.dart';
import 'package:match_mates/service/auth_service.dart';
import 'package:provider/provider.dart';

import '../bottom_nav.dart';

class SignInPage extends StatefulWidget {
  static const routeNamed = '/login_page';

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscureText = true;
  bool _isLoading = false;

  // void clearText() {
  //   fieldText.clear();
  // }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthServices>(context);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      onVerticalDragEnd: (DragEndDetails details) =>
          FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
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
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            icon: Icon(Icons.person),
                            labelText: 'Email',
                            // suffixIcon: IconButton(
                            //   onPressed: clearText,
                            //   icon: Icon(
                            //     Icons.close,
                            //     size: 20,
                            //   ),
                            // ),
                          ),
                        );
                      },
                    ),
                    TextField(
                      controller: _passwordController,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        icon: Icon(Icons.lock),
                        labelText: 'Password',
                        suffixIcon: IconButton(
                          icon: Icon(_obscureText
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                      ),
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
                    style: ElevatedButton.styleFrom(
                      primary: Colors.lightBlueAccent,
                    ),
                    child: Text('Login'),
                    onPressed: () async {
                      setState(() {
                        _isLoading = true;
                      });
                      try {
                        await authService.signIn(
                            _emailController.text, _passwordController.text);
                        Navigator.pushReplacementNamed(
                            context, BottomNavigation.routeNamed);
                      } catch (e) {
                        final snackBar = SnackBar(
                            content:
                                Text("User tidak ditemukan"));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } finally {
                        setState(() {
                          _isLoading = false;
                        });
                      }
                      // Navigator.of(context)
                      //     .pushReplacementNamed(BottomNavigation.routeNamed);
                    },
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
                      Navigator.pushNamed(context, SignUpPage.routeNamed);
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
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

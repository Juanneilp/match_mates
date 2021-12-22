import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:match_mates/service/auth_service.dart';
import 'package:provider/provider.dart';

import 'signin_page.dart';

class SignUpPage extends StatefulWidget {
  static const routeNamed = '/signup_page';

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscureText = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthServices>(context);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      onVerticalDragEnd: (DragEndDetails details) =>
          FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : Container(),
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 15, bottom: 5),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, SignInPage.routeNamed);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          size: 30,
                          color: Colors.redAccent,
                        ),
                      )
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
                          children: <Widget>[
                            TextField(
                              controller: _fullNameController,
                              decoration:
                                  InputDecoration(labelText: 'Full Name'),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(labelText: 'Email'),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextField(
                              controller: _passwordController,
                              obscureText: _obscureText,
                              decoration: InputDecoration(
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
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                        child: Container(
                          width: 300,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.lightBlueAccent,
                            ),
                            child: Text('SIGN UP'),
                            onPressed: () async {
                              try {
                                await authService.signUp(
                                    _emailController.text,
                                    _passwordController.text,
                                    _fullNameController.text);
                                Navigator.pushReplacementNamed(
                                    context, SignInPage.routeNamed);
                              } catch (e) {
                                final snackBar = SnackBar(
                                    content:
                                        Text('Email dan Password tidak valid'));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              } finally {
                                setState(() {
                                  _isLoading = false;
                                });
                              }
                            },
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
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

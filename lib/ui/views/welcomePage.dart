import 'package:flutter/material.dart';

import '../../animation/FadeAnimation.dart';
import '../form/login.dart';
import '../form/signup.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  FadeAnimation(
                      1,
                      const Text(
                        "Welcome",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            fontFamily: "Helvetica"),
                      )),
                  const SizedBox(
                    height: 3,
                  ),
                  FadeAnimation(
                      1.1,
                      const Text(
                        "To",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            fontFamily: "Helvetica"),
                      )),
                  const SizedBox(
                    height: 3,
                  ),
                  FadeAnimation(
                      1.2,
                      const Text(
                        "Books to Look",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            fontFamily: "Helvetica"),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
              FadeAnimation(
                  1.4,
                  Container(
                    height: MediaQuery.of(context).size.height / 3.3,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/childBook.png'))),
                  )),
              Column(
                children: <Widget>[
                  FadeAnimation(
                      1.5,
                      MaterialButton(
                        minWidth: double.infinity,
                        height: 60,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(5)),
                        child: const Text(
                          "Login",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              fontFamily: "Helvetica"),
                        ),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  FadeAnimation(
                      1.6,
                      Container(
                        padding: const EdgeInsets.only(top: 3, left: 3),
                        child: MaterialButton(
                          minWidth: double.infinity,
                          height: 60,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignupPage()));
                          },
                          color: Colors.red,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          child: const Text(
                            "Sign up",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: Colors.white,
                                fontFamily: "Helvetica"),
                          ),
                        ),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scalp_smart/colors.dart';
import 'package:scalp_smart/screens/patient_screens/signup_page.dart';

import '../../auth/authServices.dart';
import '../../auth/authWrapper.dart';
import '../../widgets/customTextField.dart';
import '../../widgets/widget_support.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController resetPasswordController = TextEditingController();

  void resetPassword() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: dialogboxColor,
              title: Text("Forgot password"),
              content: CustomTextField(
                  hintText: "email",
                  icon: Icon(Icons.email),
                  obscureText: false,
                  textEditingController: resetPasswordController),
              actions: [
                TextButton(
                    onPressed: () {

                      FirebaseAuth.instance.sendPasswordResetEmail(
                          email: resetPasswordController.text);
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                            SnackBar(content: Text("Email sent Successfully")));
                      resetPasswordController.clear();
                      Navigator.pop(context);
                    },

                    child: Text(
                      "Submit",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: appBarColor),
                    ))
              ],
            ));
  }

  void login() async {
    final authService = AuthService();

    try {
      await authService.loginEmailPassword(
          emailController.text.toString(), passwordController.text.toString());
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => AuthWrapper(
                tutorial: false,
              )));
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(e.toString()),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.5,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                      appBarColor,
                      Colors.cyan,
                    ])),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 3),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.5,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: Text(""),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                child: Column(
                  children: [
                    // Image.asset("assets/images/logo.png",
                    //     width: MediaQuery.of(context).size.width/1.3),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.3,
                      margin: EdgeInsets.only(top: 30),
                      alignment: Alignment.center,
                      child: Text(
                        "Scalp Smart",
                        style: AppWidget.headlineTextStyle()
                            .copyWith(fontSize: 30),
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    Material(
                      elevation: 10,
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(20),
                        height: 500,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Login",
                                  style: AppWidget.headlineTextStyle(),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                CustomTextField(
                                  hintText: "Email",
                                  icon: Icon(Icons.email),
                                  obscureText: false,
                                  textEditingController: emailController,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                CustomTextField(
                                  hintText: "Password",
                                  icon: Icon(Icons.no_encryption_rounded),
                                  obscureText: true,
                                  textEditingController: passwordController,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Align(
                                    alignment: Alignment.centerRight,
                                    child: InkWell(
                                        onTap: resetPassword,
                                        child: Text(
                                          "Forgot Password ? ",
                                          style: AppWidget.lightTextStyle(),
                                        ))),
                              ],
                            ),
                            Material(
                              elevation: 5,
                              borderRadius: BorderRadius.circular(20),
                              child: InkWell(
                                onTap: () {
                                  login();
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 70, vertical: 10),
                                  decoration: BoxDecoration(
                                      color: appBarColor,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Text(
                                    "Login",
                                    style: AppWidget.boldTextStyle().copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 100,
                    ),

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Text(
                            "Don't Have an Account ?",
                            style: TextStyle(fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => SignUpPage()));
                              },
                              child: Text(" Sign Up ",
                                  style: TextStyle(
                                      fontSize: 18, color: appBarColor))),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

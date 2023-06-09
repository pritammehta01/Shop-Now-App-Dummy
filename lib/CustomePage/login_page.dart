import 'package:flutter/material.dart';
import 'package:my_app/CustomePage/home_page.dart';
import 'package:my_app/widgets/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String name = "";
  bool chanchedButton = false;
  bool isEmpty = true;
  final _formkey = GlobalKey<FormState>();
  moveToHome(BuildContext context) async {
    //If sucsessful Login
    var sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.setBool(SplashScreenState.KEYLOGIN, true);
    if (_formkey.currentState!.validate()) {
      setState(() {
        chanchedButton = true;
      });
      await Future.delayed(Duration(seconds: 1));
      var sharedPrefs = await SharedPreferences.getInstance();
      sharedPrefs.setBool(SplashScreenState.KEYLOGIN, true);
      await Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ));
      setState(() {
        chanchedButton = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: context.cardColor,
        body: ColoredBox(
          color: context.cardColor,
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  SizedBox(
                    height: 280,
                    width: 450,
                    child: Image.asset(
                      "assets/images/hey.png",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Welcome $name",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 24.0),
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: " Enter UserName",
                              labelText: "UserName"),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "user name can't be empty";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            name = value;
                            setState(() {});
                          },
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          obscureText: true,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: " Enter Pasword",
                              labelText: "Pasword"),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "pasword can't be empty";
                            } else if (value.length < 6) {
                              return "pasword should be atleast 6";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Material(
                          color: Colors.deepPurple,
                          borderRadius:
                              BorderRadius.circular(chanchedButton ? 50 : 8),
                          child: InkWell(
                            onTap: () => moveToHome(context),
                            child: AnimatedContainer(
                              duration: Duration(seconds: 1),
                              alignment: Alignment.center,
                              width: chanchedButton ? 50 : 120,
                              height: 50,
                              child: chanchedButton
                                  ? Icon(
                                      Icons.done,
                                      color: Colors.blue,
                                    )
                                  : Text(
                                      "Login",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

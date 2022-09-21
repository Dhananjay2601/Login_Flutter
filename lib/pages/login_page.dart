// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, avoid_print, unnecessary_new
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:reseller_apk/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  bool _isObscure = true;
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

//function to store user token locally
  static Future<bool> storeToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('token', value);
  }

  //function to store user ID locally
  static Future<bool> storeId(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('userId', value);
  }

//POST req, Login function
  void login(String email, password) async {
    try {
      Response response = await post(
        Uri.parse('http://192.168.43.238:3000/auth/signin'),
        body: {
          'phoneOrEmail': email,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        setState(() {
          _isLoading = false;
        });
        // _isLoading = false;
        //saving user data after successfull login
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('email', 'phoneOrEmail');

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext ctx) => HomePage(),
          ),
        );
        //take user token from API and store it locally for auth
        var data = jsonDecode(response.body.toString());
        storeToken(data['token']);
        storeId(data['userId']);
        print(data['userId']);
        print(data['token']);
        print('Login Successfully');
      } else {
        print('Login Failed');
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Login Failed! Please Enter Valid User Details'),
          ),
          barrierDismissible: true,
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

//function to validate email
  static validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value)) {
      return 'Enter a valid email address';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Widget loadingIndicator = _isLoading
    //     ? Container(
    //         color: Colors.grey[300],
    //         width: 70.0,
    //         height: 70.0,
    //         child: new Padding(
    //           padding: const EdgeInsets.all(5.0),
    //           child: new Center(
    //             child: new CircularProgressIndicator(),
    //           ),
    //         ),
    //       )
    //     : Container();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[300],
        title: Text(
          'Goa',
          style: TextStyle(color: Colors.black),
        ),
      ),
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //welcome resller
              Text(
                'Hello Re-Seller!',
                style: GoogleFonts.bebasNeue(fontSize: 50),
              ),
              SizedBox(height: 20),

              //email testfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailcontroller,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => validateEmail(value),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: ('Email'),
                          prefixIcon: Visibility(
                            child: Icon(
                              Icons.email,
                              color: Colors.black,
                            ),
                          )),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),

              //password textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: TextFormField(
                      controller: passwordcontroller,
                      obscureText: _isObscure,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: ('Password'),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isObscure
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                          ),
                          prefixIcon: Visibility(
                            child: Icon(
                              Icons.lock,
                              color: Colors.black,
                            ),
                          )),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),

              //login button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextButton(
                  onPressed: () {
                    // _isLoading
                    //     ? Center(
                    //         child: CircularProgressIndicator(),
                    //       )
                    //     :
                    setState(() {
                      _isLoading = true;
                    });
                    login(
                      emailcontroller.text.toString(),
                      passwordcontroller.text.toString(),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(13),
                    decoration: BoxDecoration(
                      color: Colors.orange[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),

              //not a resller? Join Us Now!
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not a Resller?',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    ' Join Us Now!',
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

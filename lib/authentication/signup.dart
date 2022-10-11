import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../methods/auth_methods.dart';
import '../other/utils.dart';
import 'login.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;
  // bool textfield1selected = false;
  // bool textfield2selected = false;
  // bool textfield3selected = false;
  bool _passwordVisible = false;
  String oneValue = '';
  var countryIndex;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    // _bioController.dispose();
    _usernameController.dispose();
  }

  void signUpUser() async {
    // Validates username
    String? userNameValid =
        await usernameValidator(username: _usernameController.text);
    if (userNameValid != null) {
      showSnackBar(userNameValid, context);
      return;
    }
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
      username: _usernameController.text.trim(),
      aEmail: _emailController.text.trim(),
      password: _passwordController.text,
    );

    if (res != "success") {
      Future.delayed(const Duration(milliseconds: 1500), () {
        setState(() {
          _isLoading = false;
        });
      });
      showSnackBar(res, context);
    } else {
      showSnackBar("Welcome, ${_usernameController.text.trim()}!", context);
      goToHome(context);
    }
  }

  void navigateToLogin() {
    Future.delayed(const Duration(milliseconds: 150), () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    });
  }

  Widget build(BuildContext context) {
    var safePadding = MediaQuery.of(context).padding.top;
    var appBarPadding = AppBar().preferredSize.height;

    // var countryIndex = long.indexOf(oneValue);
    // if (countryIndex >= 0) {
    //   country = short[countryIndex];

    //   print(country);
    // }
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.transparent,
        child: SafeArea(
          child: Container(
            color: Colors.white,
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 1,
            child: ListView(
              shrinkWrap: true,
              // reverse: true,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal:
                          MediaQuery.of(context).size.width > 600 ? 100 : 32),
                  child: Column(children: [
                    SizedBox(
                        height:
                            MediaQuery.of(context).size.width > 600 ? 30 : 65),

                    SizedBox(
                        height:
                            MediaQuery.of(context).size.width > 600 ? 30 : 65),
                    Padding(
                      padding: const EdgeInsets.only(top: 0.0),
                      child: Container(
                        // color: Colors.blue,
                        height: 60,
                        // width:
                        //     MediaQuery.of(context).size.width * 1 -
                        //         64,
                        // height: 70,
                        child: TextField(
                          textInputAction: TextInputAction.next,
                          controller: _usernameController,
                          maxLength: 16,
                          decoration: new InputDecoration(
                              counterText: '',
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 36, 64, 101),
                                    width: 2),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1),
                              ),
                              // hintText: 'Username',
                              labelText: 'Username',
                              labelStyle:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                              hintStyle:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                              // labelText: 'Username',
                              fillColor: Color.fromARGB(255, 245, 245, 245),
                              filled: true,
                              prefixIcon: Icon(
                                Icons.person_outlined,
                                // color: textfield1selected == false
                                //     ? Colors.grey
                                //     : Colors.blueGrey,
                              )),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),
                    TextField(
                      textInputAction: TextInputAction.next,
                      controller: _emailController,
                      decoration: new InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 36, 64, 101),
                                width: 2),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1),
                          ),
                          // hintText: 'Email Address',
                          labelText: 'Email Address',
                          labelStyle:
                              TextStyle(fontSize: 14, color: Colors.grey),
                          hintStyle:
                              TextStyle(fontSize: 14, color: Colors.grey),
                          // labelText: 'Email Address',
                          fillColor: Color.fromARGB(255, 245, 245, 245),
                          filled: true,
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            // color: textfield2selected == false
                            //     ? Colors.grey
                            //     : Colors.blueGrey,
                          )),
                    ),
                    const SizedBox(height: 24),
                    // SizedBox(
                    //   height: 48,
                    //   child: FlatButton(
                    //     onPressed: () {
                    //       Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => RegisterCountries()),
                    //       ).then((value) => {getValue()});
                    //     },
                    //     padding: EdgeInsets.only(left: 8.0),
                    //     textColor: Colors.black,
                    //     color: Color(0xFFEDEDED),
                    //     shape: RoundedRectangleBorder(
                    //         side: const BorderSide(
                    //             color: Color(0XFFD0D0D0),
                    //             width: 0.5,
                    //             style: BorderStyle.solid),
                    //         borderRadius: BorderRadius.circular(5)),
                    //     child: country == "us"
                    //         ? const Align(
                    //             alignment: Alignment.centerLeft,
                    //             child: Text("Select your Country",
                    //                 textAlign: TextAlign.left,
                    //                 style: TextStyle(
                    //                   color: Color(0XFFA8A8A8),
                    //                   fontSize: 16,
                    //                   fontWeight: FontWeight.normal,
                    //                   fontFamily: 'Roboto',
                    //                 )),
                    //           )
                    //         : Align(
                    //             alignment: Alignment.centerLeft,
                    //             child: Text("$country",
                    //                 textAlign: TextAlign.left,
                    //                 style: TextStyle(
                    //                   color: Colors.black,
                    //                   fontSize: 16,
                    //                   fontWeight: FontWeight.normal,
                    //                   fontFamily: 'Roboto',
                    //                 )),
                    //           ),
                    //   ),
                    // ),

                    // const SizedBox(height: 24),
                    TextField(
                      controller: _passwordController,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 36, 64, 101),
                              width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: Colors.grey, width: 1),
                        ),
                        labelText: 'Password',
                        labelStyle: TextStyle(fontSize: 14, color: Colors.grey),
                        hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                        // labelText: 'Password',
                        // labelStyle: TextStyle(
                        //     color: Colors.grey, fontStyle: FontStyle.italic),
                        fillColor: Color.fromARGB(255, 245, 245, 245),
                        filled: true,
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          // color: textfield3selected == false
                          //     ? Colors.grey
                          //     : Colors.blueGrey,
                        ),

                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                          child: Icon(
                            // Based on passwordVisible state choose the icon
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                            size: 22,
                          ),
                        ),
                      ),
                      obscureText: !_passwordVisible,
                    ),
                    const SizedBox(height: 24),
                    // TextFieldInputDone(
                    //   hintText: 'Enter your bio',
                    //   textInputType: TextInputType.text,
                    //   textEditingController: _bioController,
                    // ),
                    // const SizedBox(height: 24),
                    //signup button
                    Material(
                      color: Color.fromARGB(255, 36, 64, 101),
                      borderRadius: BorderRadius.circular(25),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(50),
                        splashColor: Colors.black.withOpacity(0.3),
                        onTap: signUpUser,
                        child: Container(
                          child: _isLoading
                              ? const Center(
                                  child: SizedBox(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                      height: 18,
                                      width: 18),
                                )
                              : const Text('Sign Up',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.5)),
                          width: double.infinity,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: const ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(25),
                              ),
                            ),
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    Container(
                      // color: Colors.orange,
                      // height: (MediaQuery.of(context).size.height -
                      //         395 -
                      //         safePadding -
                      //         appBarPadding) *
                      //     0.5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(25),
                              splashColor: Colors.grey.withOpacity(0.3),
                              onTap: navigateToLogin,
                              child: Container(
                                // width: 30,

                                height: 45,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Text("Already have an account?",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 13)),
                                    ),
                                    Container(
                                      child: const Text(
                                        "Log In",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color:
                                                Color.fromARGB(255, 81, 81, 81),
                                            fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // getValue() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     oneValue = prefs.getString('selected_radio') ?? '';

  //     var countryIndex = long.indexOf(oneValue);
  //     if (countryIndex >= 0) {
  //       country = short[countryIndex];

  //       print('abc');
  //       print(country);

  //       prefs.setString('cont', country);
  //     }
  //   });
  // }
}

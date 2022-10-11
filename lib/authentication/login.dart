import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/authentication/signup.dart';
import '../methods/auth_methods.dart';
import '../other/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _passwordVisible = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  void loginUser() async {
    // Future.delayed(const Duration(milliseconds: 50), () async {
    setState(() {
      _isLoading = true;
    });
    // String email = _emailController.text;
    String email = _emailController.text.toLowerCase();

    // Login with username
    if (!email.contains('@')) {
      var user = await FirebaseFirestore.instance
          .collection('users')
          // .where('username', isEqualTo: email)
          .where('usernameLower', isEqualTo: email)
          .get();
      if (user.docs.isNotEmpty) {
        email = user.docs.first.data()['aEmail'];
      }
    }
    String res = await AuthMethods()
        .loginUser(email: email, password: _passwordController.text);

    if (res != "success") {
      Future.delayed(const Duration(milliseconds: 1500), () {
        setState(() {
          _isLoading = false;
        });
      });
      showSnackBar(res, context);
    } else if (res == "success") {
      goToHome(context);
      showSnackBar("Successfully logged in.", context);
    } else {}
    setState(() {
      _isLoading = false;
    });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: ListView(
            shrinkWrap: true,
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
                  TextField(
                    textInputAction: TextInputAction.next,
                    controller: _emailController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 36, 64, 101), width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(color: Colors.grey, width: 1),
                      ),
                      labelText: 'Username or Email',
                      labelStyle: TextStyle(fontSize: 14, color: Colors.grey),
                      // labelText: 'Username',
                      fillColor: Color.fromARGB(255, 245, 245, 245),
                      filled: true,
                      prefixIcon: const Icon(
                        Icons.person_outlined,
                      ),
                    ),
                    //   Icon(
                    //     Icons.email_outlined,
                    //   ),
                    // ],
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: _passwordController,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 36, 64, 101), width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(color: Colors.grey, width: 1),
                      ),
                      labelText: 'Password',
                      labelStyle:
                          const TextStyle(fontSize: 14, color: Colors.grey),
                      hintStyle:
                          const TextStyle(fontSize: 14, color: Colors.grey),
                      // labelText: 'Password',
                      // labelStyle: TextStyle(
                      //     color: Colors.grey, fontStyle: FontStyle.italic),
                      fillColor: Color.fromARGB(255, 245, 245, 245),
                      filled: true,
                      prefixIcon: const Icon(
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
                  Material(
                    color: const Color.fromARGB(255, 36, 64, 101),
                    borderRadius: BorderRadius.circular(25),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(50),
                      splashColor: Colors.black.withOpacity(0.3),
                      onTap: loginUser,
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
                            : const Text('Log In',
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width > 600
                            ? MediaQuery.of(context).size.width / 2 - 130
                            : MediaQuery.of(context).size.width / 2 - 70,
                        // MediaQuery.of(context).size.width / 2 - 194,
                        decoration: const BoxDecoration(
                          // color: Colors.red,
                          border: Border(
                            top: BorderSide(width: 1, color: Colors.grey),
                          ),
                        ),
                      ),
                      Container(
                        width: 33,
                        alignment: Alignment.center,
                        child: const Text('or',
                            style:
                                TextStyle(fontSize: 16, color: Colors.black)),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width > 600
                            ? MediaQuery.of(context).size.width / 2 - 130
                            : MediaQuery.of(context).size.width / 2 - 70,
                        decoration: const BoxDecoration(
                          // color: Colors.red,
                          border: Border(
                            top: BorderSide(width: 1, color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Material(
                    color: const Color.fromARGB(255, 179, 179, 179),
                    borderRadius: BorderRadius.circular(25),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(25),
                      splashColor: Colors.white.withOpacity(0.5),
                      onTap: () {
                        Future.delayed(const Duration(milliseconds: 150), () {
                          goToHome(context);
                        });
                      },
                      child: Container(
                        child: const Text('Continue as a Guest',
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
                            color: Colors.transparent),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Column(
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(25),
                          splashColor: Colors.grey.withOpacity(0.3),
                          onTap: () {
                            Future.delayed(const Duration(milliseconds: 150),
                                () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignupScreen()),
                              );
                            });
                          },
                          child: SizedBox(
                            width: 160,
                            height: 45,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Don't have an account?",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 13)),
                                Container(height: 2),
                                const Text(
                                  "Sign Up",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromARGB(255, 81, 81, 81),
                                      fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

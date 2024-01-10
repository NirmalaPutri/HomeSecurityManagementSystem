import 'package:flutter/material.dart';
import 'package:security_system/ui/home.dart';
import 'package:security_system/ui/signup.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('P R O T E K S I',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 2, 63, 23),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/login.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 20,
                  bottom: 180,
                  child: SizedBox(
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 10),
                          width: 300,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(
                              controller: email,
                              cursorColor: Colors.grey,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                prefixIcon: const Icon(
                                  Icons.email_outlined,
                                  color: Colors.grey,
                                ),
                                hintText: 'Email',
                              ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (email) => email != null &&
                                      !EmailValidator.validate(email)
                                  ? 'Enter a valid email'
                                  : null,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  bottom: 70,
                  child: SizedBox(
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 10),
                          width: 300,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(
                              controller: password,
                              cursorColor: Colors.grey,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                prefixIcon: const Icon(
                                  Icons.password_outlined,
                                  color: Colors.grey,
                                ),
                                hintText: 'Password',
                              ),
                              obscureText: true,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) =>
                                  value != null && value.length < 6
                                      ? 'Enter min. 6 characters'
                                      : null,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 150,
                  left: 15,
                  right: 15,
                  child: SizedBox(
                    child: Form(
                      key: formKey,
                      child: GestureDetector(
                        onTap: () {
                          FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: email.text.trim(),
                                  password: password.text.trim())
                              .then((value) {
                            print("Successfully Logged In");
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Home()),
                            );

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Login successful"),
                                duration: Duration(seconds: 3),
                              ),
                            );
                          }).catchError((error) {
                            print('Error ${error.toString()}');

                            if (email.text.isEmpty || password.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Username and Password cannot be empty'),
                                  duration: Duration(seconds: 3),
                                ),
                              );
                              return;
                            }

                            if (error is FirebaseAuthException) {
                              if (error.code == 'wrong-password' ||
                                  error.code == 'user-not-found') {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Invalid email and password'),
                                    duration: Duration(seconds: 3),
                                  ),
                                );
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('An error occurred'),
                                  duration: Duration(seconds: 3),
                                ),
                              );
                            }
                          });
                        },
                        child: Container(
                          height: 50,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 2, 63, 23),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: const Center(
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 100,
                  child: Row(
                    children: [
                      Text(
                        "Don't Have an Account?",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: Color(0xFF1C2321),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Registration(),
                            ),
                          );
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF1C2321),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

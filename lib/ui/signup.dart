import 'package:flutter/material.dart';
import 'package:security_system/main.dart';
import 'package:security_system/ui/login.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  bool isChecked = false;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      throw e;
    }
  }

  Future<void> sendEmailVerification() async {
    User user = FirebaseAuth.instance.currentUser!;
    await user.sendEmailVerification();
  }

  void _register() async {
    if (formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await registerWithEmailAndPassword(
          email.text.trim(),
          password.text.trim(),
        );
        await sendEmailVerification();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      } on FirebaseAuthException catch (e) {
        print('Error during registration: ${e.message}');
      }
    }
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();

    super.dispose();
  }

  Future signup() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e);

      Utils.showSnackBar(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign Up',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
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
              children: [
                Container(
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
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      prefixIcon: const Icon(
                                        Icons.people_outline_outlined,
                                        color: Colors.grey,
                                      ),
                                      hintText: 'Email',
                                    ),
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
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      prefixIcon: const Icon(
                                        Icons.password_outlined,
                                        color: Colors.grey,
                                      ),
                                      hintText: 'Password',
                                    ),
                                    obscureText: true,
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
                                signup();
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Email verification'),
                                      content: Text(
                                          'Please verify your email address'),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        const Login()));
                                          },
                                          child: Text("OK"),
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Color(0xFF1C2321)),
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Container(
                                  height: 50,
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 2, 63, 23),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: const Center(
                                    child: Text('Sign Up',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        )),
                                  )),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Have an Account?",
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
                                    builder: (context) => Login(),
                                  ),
                                );
                              },
                              child: Text(
                                'Sign In',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

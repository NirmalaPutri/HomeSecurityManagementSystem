import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:security_system/ui/detail_profile.dart';
import 'package:security_system/ui/faq.dart';
import 'package:security_system/ui/login.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 78, 114, 91),
      appBar: AppBar(
        title: Text('Profile',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Color(0xFF1C2321),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        child: Column(children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
            child: Row(
              children: [
                const Icon(
                  Icons.person_2_rounded,
                  color: Colors.white,
                ),
                SizedBox(width: 10),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailProfile()),
                      );
                    },
                    child: Text(
                      'My Profile',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ))
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
            child: Row(
              children: [
                const Icon(
                  Icons.question_answer_outlined,
                  color: Colors.white,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => faq()),
                      );
                    },
                    child: Text(
                      'FAQ',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ))
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
            child: Row(
              children: [
                const Icon(
                  Icons.logout_sharp,
                  color: Colors.white,
                ),
                SizedBox(width: 10),
                TextButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut().then((value) {
                        print("Signed out");
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      });
                    },
                    child: Text(
                      'Log out',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ))
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

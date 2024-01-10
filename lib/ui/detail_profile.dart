import 'package:flutter/material.dart';
import 'package:security_system/ui/home.dart';

class DetailProfile extends StatelessWidget {
  const DetailProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 78, 114, 91),
        elevation: 0,
        leading: BackButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Home(),
              ),
            );
          },
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        padding:
            const EdgeInsets.only(top: 60, bottom: 60, left: 20, right: 20),
        child: Column(children: [
          Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              clipBehavior: Clip.antiAlias,
              child: Image.asset(
                'assets/lala.jpg',
                fit: BoxFit.cover,
                width: 100,
                height: 100,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 0, bottom: 0, left: 5, right: 5),
            child: Container(
              width: 700,
              height: 70,
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                )),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                child: Text(
                  "Username\n\nNirmala Putri Ismail",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF2D3259),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 0, bottom: 0, left: 5, right: 5),
            child: Container(
              width: 700,
              height: 90,
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                )),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                child: Text(
                  "Bio\n\nVisi Foya Misi Foya Visi Misi Foya Foya",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF2D3259),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 0, bottom: 0, left: 5, right: 5),
            child: Container(
              width: 700,
              height: 70,
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                )),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                child: Text(
                  "No. Handphone\n\n*****39",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF2D3259),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 0, bottom: 0, left: 5, right: 5),
            child: Container(
              width: 700,
              height: 70,
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                )),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                child: Text(
                  "Email\n\nni***a@gmail.com",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF2D3259),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

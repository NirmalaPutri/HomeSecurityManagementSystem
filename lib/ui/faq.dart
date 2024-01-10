import 'package:flutter/material.dart';
import 'package:security_system/ui/home.dart';

class faq extends StatelessWidget {
  const faq({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: Text('FAQ',
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
      body: SingleChildScrollView(
        child: Container(
          padding:
              const EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
          child: Column(children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 0, bottom: 0, left: 5, right: 5),
              child: Container(
                width: 700,
                height: 250,
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                    color: Colors.black,
                    width: 0.5,
                  )),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "What is the Home Security Application?",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D3259),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "The Home Security Application is a comprehensive security solution designed to monitor and protect your home. It incorporates advanced features such as sensor detection and a 7-day historical data viewing capability.",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF2D3259),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 0, bottom: 0, left: 5, right: 5),
              child: Container(
                width: 500,
                height: 250,
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                    color: Colors.grey,
                    width: 0.5,
                  )),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "How does the sensor detection feature work?",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D3259),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        " The sensor detection feature utilizes various sensors strategically placed around your home to identify any unusual activities or intrusions. When a sensor is triggered, the application sends real-time alerts to your device, allowing you to stay informed about potential security issues.",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF2D3259),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 0, bottom: 0, left: 5, right: 5),
              child: Container(
                width: 700,
                height: 250,
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                    color: Colors.grey,
                    width: 0.5,
                  )),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "What types of sensors are supported by the application?",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D3259),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        " The application supports a range of sensors, including motion sensors, door/window contact sensors, and other smart sensors compatible with the system. These sensors collectively contribute to creating a robust security network for your home.",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF2D3259),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 0, bottom: 0, left: 5, right: 5),
              child: Container(
                width: 700,
                height: 250,
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                    color: Colors.grey,
                    width: 0.5,
                  )),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "How does the 7-day historical data viewing feature work?",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D3259),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        " The application stores and organizes data collected by the sensors over the past 7 days. Users can access a visual representation of this data through intuitive graphs and charts, allowing them to review historical security events and patterns.",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF2D3259),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

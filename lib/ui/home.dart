import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:security_system/ui/detail_door.dart';
import 'package:security_system/ui/detail_flame.dart';
import 'package:security_system/ui/detail_gas.dart';
import 'package:security_system/ui/detail_suhu.dart';
import 'package:security_system/ui/history.dart';
import 'package:security_system/ui/managesensor.dart';
import 'package:security_system/ui/profile.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:security_system/ui/realtime.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late MqttManager mqttManager;

  late String temperature = '0';
  late String humidity = '0';
  late String flame = '0';
  late String door = '0';

  final items = const [
    Icon(Icons.home, size: 25),
    Icon(Icons.settings_applications, size: 25),
    Icon(Icons.history, size: 25),
    Icon(Icons.people, size: 25),
  ];

  int index = 0;

  @override
  void initState() {
    super.initState();
    mqttManager = MqttManager();
    mqttManager.connect().then((result) {
      if (result is int && result == -1) {}
    });

    mqttManager.datatemperature.addListener(() {
      setState(() {
        temperature = mqttManager.datatemperature.value;
      });
    });

    mqttManager.humidityData.addListener(() {
      setState(() {
        humidity = mqttManager.humidityData.value;
      });
    });

    mqttManager.flameData.addListener(() {
      setState(() {
        flame = mqttManager.flameData.value;
      });
    });

    mqttManager.doorData.addListener(() {
      setState(() {
        door = mqttManager.doorData.value;
      });
    });
  }

  @override
  void dispose() {
    mqttManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    List<Widget> widgets = [
      SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
          child: Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
                child: Text(
                  'P R O T E K S I',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Bellefair',
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "Today's Detection",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 160,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 5, bottom: 5, left: 10, right: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF1C2321),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 82, 81, 81)
                                  .withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .center, // Center horizontally
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  margin: EdgeInsets.only(
                                      top: 10, bottom: 10, left: 10, right: 5),
                                  decoration: BoxDecoration(
                                    color:
                                        (double.tryParse(temperature) ?? 0.0) >
                                                45
                                            ? Colors.red
                                            : Colors.green,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        temperature + '°C',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Temp',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 60,
                                  height: 60,
                                  margin: EdgeInsets.only(left: 5, right: 5),
                                  decoration: BoxDecoration(
                                    color:
                                        (double.tryParse(humidity) ?? 0.0) < 80
                                            ? Colors.green
                                            : Colors.red,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: IntrinsicHeight(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          humidity + '%RH',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Humidity',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 60,
                                  height: 60,
                                  margin: EdgeInsets.only(left: 5, right: 5),
                                  decoration: BoxDecoration(
                                    color: (double.tryParse(flame) ?? 0.0) > 0.0
                                        ? Colors.red
                                        : Colors.green,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        double.tryParse(flame) == 1.0
                                            ? 'Yes'
                                            : 'No',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Flame',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 60,
                                  height: 60,
                                  margin: EdgeInsets.only(left: 5, right: 10),
                                  decoration: BoxDecoration(
                                    color: (double.tryParse(door) ?? 0.0) <= 0
                                        ? Colors.green
                                        : Colors.red,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        double.tryParse(door) == 1.0
                                            ? 'Open'
                                            : 'Close',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Door',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: 260,
                              height: 55,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin: EdgeInsets.only(
                                top: 5,
                                bottom: 5,
                                left: 5,
                                right: 5,
                              ),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  margin: EdgeInsets.only(top: 5, left: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Status:',
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        (double.tryParse(temperature) ?? 0.0) >
                                                    45 ||
                                                (double.tryParse(humidity) ??
                                                        0.0) >
                                                    80 ||
                                                double.tryParse(flame) == 1 ||
                                                double.tryParse(door) == 1
                                            ? 'DANGER!'
                                            : 'SAFE',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: (double.tryParse(
                                                              temperature) ??
                                                          0.0) >
                                                      45 ||
                                                  (double.tryParse(humidity) ??
                                                          0.0) >
                                                      80 ||
                                                  double.tryParse(flame) == 1 ||
                                                  double.tryParse(door) == 1
                                              ? Colors.red
                                              : Colors.green,
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
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "Your Sensor",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 100,
                          width: 120,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 5, bottom: 5, left: 10, right: 5),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailSuhu(),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFF1C2321),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 82, 81, 81)
                                          .withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.thermostat_auto_outlined,
                                      color: Colors.blue,
                                      size: 40,
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'Temp',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 100,
                          width: 120,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 5, bottom: 5, left: 10, right: 5),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailGas(),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFF1C2321),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 82, 81, 81)
                                          .withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.water_drop_outlined,
                                      color: Colors.green,
                                      size: 40,
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'Humidity',
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 100,
                          width: 120,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 5, bottom: 5, left: 10, right: 5),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailFlame(),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFF1C2321),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 82, 81, 81)
                                          .withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.fireplace_outlined,
                                      color: Colors.orange,
                                      size: 40,
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'Flame',
                                      style: TextStyle(
                                        color: Colors.orange,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 100,
                          width: 120,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 5, bottom: 5, left: 10, right: 5),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailDoor(),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFF1C2321),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 82, 81, 81)
                                          .withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.lock_open_rounded,
                                      color: Colors.purple,
                                      size: 40,
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'Door',
                                      style: TextStyle(
                                        color: Colors.purple,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "7-Day Sensor Detection Overview",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    height: 400,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 5, bottom: 5, left: 10, right: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 82, 81, 81)
                                  .withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(top: 20, bottom: 5),
                          child: Column(
                            children: [
                              Expanded(
                                child: RealtimeWidget(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      ManageSensor(),
      MyApp(),
      Profile(),
    ];

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 78, 114, 91),
      body: widgets[index],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Color(0xFF1C2321),
        items: items,
        index: index,
        onTap: (selectedIndex) {
          print(selectedIndex);
          setState(() {
            index = selectedIndex;
            print(index);
          });
        },
        animationDuration: const Duration(milliseconds: 300),
      ),
    );
  }
}

class MqttManager with ChangeNotifier {
  final ValueNotifier<String> datatemperature = ValueNotifier<String>("");
  final ValueNotifier<String> humidityData = ValueNotifier<String>("");
  final ValueNotifier<String> flameData = ValueNotifier<String>("");
  final ValueNotifier<String> doorData = ValueNotifier<String>("");
  late MqttServerClient client;

  Future<Object> connect() async {
    client = MqttServerClient.withPort(
        'broker.hivemq.com', '6e02c2e3-0105-46fb-98d4-b1b32bc25480', 1883);
    client.logging(on: true);
    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    client.onUnsubscribed = onUnsubscribed;
    client.onSubscribed = onSubscribed;
    client.onSubscribeFail = onSubscribeFail;
    client.pongCallback = pong;
    client.keepAlivePeriod = 60;
    client.logging(on: true);

    client.setProtocolV311();

    final connMessage = MqttConnectMessage()
        .withWillTopic('willtopic')
        .withWillMessage('Will message')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);

    print('MQTT_LOGS::Mosquitto client connecting....');

    client.connectionMessage = connMessage;
    try {
      await client.connect();
    } catch (e) {
      print('Exception: $e');
      client.disconnect();
    }

    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      print('MQTT_LOGS::Mosquitto client connected');
    } else {
      print(
          'MQTT_LOGS::ERROR Mosquitto client connection failed - disconnecting, status is ${client.connectionStatus}');
      client.disconnect();
      return -1;
    }

    print('MQTT_LOGS::Subscribing to the test/lol topic');
    const topicTemperature = 'IOT-SECURITY DD SUHU';
    const topicHumidity = 'IOT-SECURITY DD KELEMBAPAN';
    const topicGas = 'IOT-SECURITY DD SENSOR API';
    const topicMotion = 'IOT-SECURITY DD SENSOR PINTU';

    client.subscribe(topicTemperature, MqttQos.atMostOnce);
    client.subscribe(topicHumidity, MqttQos.atMostOnce);
    client.subscribe(topicGas, MqttQos.atMostOnce);
    client.subscribe(topicMotion, MqttQos.atMostOnce);

    client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final recMess = c![0].payload as MqttPublishMessage;
      final pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      String topic = c[0].topic;
      if (topic == topicTemperature) {
        datatemperature.value = pt;
      } else if (topic == topicHumidity) {
        humidityData.value = pt;
      } else if (topic == topicGas) {
        flameData.value = pt;
      } else if (topic == topicMotion) {
        doorData.value = pt;
      }
      notifyListeners();
      print(
          'MQTT_LOGS:: New data arrived: topic is <${c[0].topic}>, payload is $pt');
      print('');
    });

    return client;
  }

  void onConnected() {
    print('MQTT_LOGS:: Connected');
  }

  void onDisconnected() {
    print('MQTT_LOGS:: Disconnected');
  }

  void onSubscribed(String topic) {
    print('MQTT_LOGS:: Subscribed topic: $topic');
  }

  void onSubscribeFail(String topic) {
    print('MQTT_LOGS:: Failed to subscribe $topic');
  }

  void onUnsubscribed(String? topic) {
    print('MQTT_LOGS:: Unsubscribed topic: $topic');
  }

  void pong() {
    print('MQTT_LOGS:: Ping response client callback invoked');
  }

  void publishMessage(String message) {
    const topicsuhu = 'IOT-SECURITY DD SUHU/connection';
    const topicHumidity = 'IOT-SECURITY DD KELEMBAPAN/connection';
    const topicGas = 'IOT-SECURITY DD SENSOR API/connection';
    const topicMotion = 'IOT-SECURITY DD SENSOR PINTU/connectioN';
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);

    if (client.connectionStatus?.state == MqttConnectionState.connected) {
      client.publishMessage(topicsuhu, MqttQos.atMostOnce, builder.payload!);
    } else if (client.connectionStatus?.state ==
        MqttConnectionState.connected) {
      client.publishMessage(
          topicHumidity, MqttQos.atMostOnce, builder.payload!);
    } else if (client.connectionStatus?.state ==
        MqttConnectionState.connected) {
      client.publishMessage(topicGas, MqttQos.atMostOnce, builder.payload!);
    } else {
      client.publishMessage(topicMotion, MqttQos.atMostOnce, builder.payload!);
    }
  }

  @override
  void dispose() {
    datatemperature.dispose();
    humidityData.dispose();
    flameData.dispose();
    doorData.dispose();
    super.dispose();
  }
}

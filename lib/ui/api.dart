import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  await Firebase.initializeApp();
  FirebaseDatabase.instance.setPersistenceEnabled(true);
  FirebaseDatabase.instance.setPersistenceCacheSizeBytes(10000000);
  MyDataUploader().startUpload();
}

class MyDataUploader {
  final DatabaseReference _database = FirebaseDatabase.instance.reference();
  late Timer _timer;

  final CollectionReference _firestoreCollection =
      FirebaseFirestore.instance.collection('data-sensor');

  void startUpload() {
    // Start a timer to fetch and upload data every second
    _timer = Timer.periodic(Duration(minutes: 5), (timer) {
      uploadDataFromApi();
    });
  }

  Future<List<Map<String, dynamic>>> fetchData() async {
    const apiUrl =
        'http://api.weatherapi.com/v1/current.json?key=ce260719f283437797822357232712&q=Bandung&q=6.8982,107.6358';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return List<Map<String, dynamic>>.from([jsonData]);
      } else {
        throw Exception(
            'Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }

  Future<void> uploadDataFromApi() async {
    try {
      final List<Map<String, dynamic>> jsonData = await fetchData();

      // Extract relevant data (temperature and humidity) and store in Firebase
      for (var data in jsonData) {
        // Convert temp_c and humidity to double if they are of type int
        final double temp_c = data['current']['temp_c'].toDouble();
        final double humidity = data['current']['humidity'].toDouble();
        final String localtimeString = data['location']['localtime'];
        final DateTime localtime = DateTime.parse(localtimeString);
        final String formattedLocaltime =
            DateFormat("yyyy-MM-dd HH:mm:ss").format(localtime);
        // Create a new JSON object with only temperature and humidity
        final Map<String, dynamic> newData = {
          'temp_c': temp_c,
          'humidity': humidity,
          'localtime': formattedLocaltime,
        };

        // Upload the new data to Firebase
        DatabaseReference newChildReference = _database.push();
        await newChildReference.set(newData);

        // Automatically send the data to Firestore without specifying a path
        await _firestoreCollection.add(newData);

        print('Data uploaded to Realtime Database and Firestore.');
      }

      print(
          'Temperature, humidity and localdatetime data uploaded to Firebase Realtime Database.');
      //await transferDataFromRealtimeDatabaseToFirestore();
    } catch (e) {
      print('Error uploading data: $e');
    }
  }

  void dispose() {
    // Cancel the timer when done
    _timer.cancel();
  }
}

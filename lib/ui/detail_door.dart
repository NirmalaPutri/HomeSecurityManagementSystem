import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DetailDoor extends StatefulWidget {
  const DetailDoor({super.key});

  @override
  State<DetailDoor> createState() => _DetailDoorState();
}

Future<List<FlSpot>> fetchData() async {
  try {
    final response = await http.get(Uri.parse(
        'https://securityappitenas.000webhostapp.com/security-app/door7hari.php'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);

      final List<FlSpot> chartData = [];

      for (var i = 0; i < jsonData.length; i++) {
        final String humidityString = jsonData[i]['rata-rata motion_detected'];
        chartData.add(FlSpot(i.toDouble(), double.parse(humidityString)));
      }

      return chartData;
    } else {
      print('API Request Error - Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
      return [];
    }
  } catch (error) {
    print('Error: $error');
    return [];
  }
}

class _DetailDoorState extends State<DetailDoor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Door Chart',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Color(0xFF1C2321),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ChartWidget(),
      ),
    );
  }
}

class ChartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FlSpot>>(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError || snapshot.data == null) {
          return Text('Error: Failed to load data');
        } else {
          return LineChart(
            LineChartData(
              gridData: FlGridData(show: true),
              titlesData: FlTitlesData(show: true),
              borderData: FlBorderData(
                show: true,
                border: Border.all(
                  color: const Color(0xff37434d),
                  width: 1,
                ),
              ),
              minX: 0,
              maxX: snapshot.data!.length.toDouble() - 1,
              minY: 0,
              maxY: 1.5,
              lineBarsData: [
                LineChartBarData(
                  spots: snapshot.data!,
                  isCurved: true,
                  color: Colors.purple,
                  dotData: FlDotData(show: false),
                  belowBarData: BarAreaData(show: false),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

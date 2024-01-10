import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, List<FlSpot>>> fetchData() async {
  try {
    final response = await http.get(Uri.parse(
        'https://securityappitenas.000webhostapp.com/security-app/data_kemarin.php'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);

      final Map<String, List<FlSpot>> chartDataMap = {
        'temperature': [],
        'humidity': [],
        'flame': [],
        'motion_detected': [],
      };

      for (var i = 0; i < jsonData.length; i++) {
        final String temperatureString = jsonData[i]['rata-rata temperature'];
        final String humidityString = jsonData[i]['rata-rata humidity'];
        final String flameString = jsonData[i]['rata-rata flame'];
        final String motionDetectedString =
            jsonData[i]['rata-rata motion_detected'];

        chartDataMap['temperature']!
            .add(FlSpot(i.toDouble(), double.parse(temperatureString)));
        chartDataMap['humidity']!
            .add(FlSpot(i.toDouble(), double.parse(humidityString)));
        chartDataMap['flame']!
            .add(FlSpot(i.toDouble(), double.parse(flameString)));
        chartDataMap['motion_detected']!
            .add(FlSpot(i.toDouble(), double.parse(motionDetectedString)));
      }

      return chartDataMap;
    } else {
      print('API Request Error - Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
      return {};
    }
  } catch (error) {
    print('Error: $error');
    return {};
  }
}

class RealtimeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, List<FlSpot>>>(
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
                  color: Color.fromARGB(255, 159, 187, 206),
                  width: 1,
                ),
              ),
              minX: 0,
              maxX: snapshot.data!['temperature']!.length.toDouble() - 1,
              minY: 0,
              maxY: 100,
              lineBarsData: [
                _buildLineChartBarData(
                    snapshot.data!['temperature']!, Colors.blue),
                _buildLineChartBarData(
                    snapshot.data!['humidity']!, Colors.green),
                _buildLineChartBarData(snapshot.data!['flame']!, Colors.orange),
                _buildLineChartBarData(
                    snapshot.data!['motion_detected']!, Colors.purple),
              ],
            ),
          );
        }
      },
    );
  }

  LineChartBarData _buildLineChartBarData(List<FlSpot> spots, Color color) {
    return LineChartBarData(
      spots: spots,
      isCurved: true,
      color: color,
      dotData: FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
    );
  }
}

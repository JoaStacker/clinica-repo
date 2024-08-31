import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const BASE_URL = 'http://localhost:8001';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  List<dynamic> _weatherData = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  Future<void> fetchWeatherData() async {
    final url = Uri.parse((BASE_URL) + '/weatherforecast');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          _weatherData = json.decode(response.body);
          _isLoading = false;
        });
      } else {
        // Handle server errors
        throw Exception('Failed to load weather data');
      }
    } catch (error) {
      // Handle network errors
      print('Error fetching weather data: $error');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Forecast'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _weatherData.length,
              itemBuilder: (context, index) {
                final weather = _weatherData[index];
                return ListTile(
                  title: Text('Date: ${weather['date']}'),
                  subtitle: Text('Temperature: ${weather['temperatureC']}°C'),
                );
              },
            ),
    );
  }
}

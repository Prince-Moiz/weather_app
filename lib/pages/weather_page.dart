import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  //api key

  final _weatherService = WeatherService('58e9631b762ee9396f8585975d54b60d');
  Weather? _weather;

//fetch weather

  _fetchWether() async {
    //get current city
    String cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  //weather animations
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null || mainCondition.isEmpty) {
      return 'assets/loading.json'; // Use a loading animation instead of sunny
    }

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloudy.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rain.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //fetch weather on startup
    _fetchWether();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on_sharp,
              color: Colors.grey[400],
            ),
            const SizedBox(
              height: 24,
            ),
            _weather?.cityName != null
                ? Text(_weather!.cityName,
                    style: TextStyle(
                        color: Colors.grey[400],
                        fontWeight: FontWeight.bold,
                        fontSize: 23)) // Show city name when available
                : Lottie.asset('assets/nameload.json',
                    width: 50, height: 50), // Show animation when loading

            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
            _weather?.cityName != null
                ? Text("${_weather?.tempreture.round()}ºC",
                    style: TextStyle(
                        color: Colors.grey[400],
                        fontWeight: FontWeight.bold,
                        fontSize: 23)) // Show city name when available
                : Lottie.asset('assets/nameload.json', width: 50, height: 50),
            Text(
              _weather?.mainCondition ?? 'Cannot find the city weather',
              style: TextStyle(
                  color: Colors.grey[400],
                  fontWeight: FontWeight.bold,
                  fontSize: 23),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_application/provider/weather_provider.dart';
import 'package:weather_application/utils/location_utils.dart';

class WeatherPage extends StatefulWidget {
  static const String routeName = '/weather-page';
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  late WeatherProvider provider;
  bool isFirst = true;
  @override
  void didChangeDependencies() {
    if(isFirst){
      provider = Provider.of<WeatherProvider>(context);
      _getData();
      isFirst = false;
    }
    super.didChangeDependencies();
  }

  _getData() {
    determinePosition().then((position) {
      provider.setNewLocation(position.latitude, position.longitude);
      provider.getWeatherData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade600,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Weather'),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.location_searching),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Center(
        child: provider.hasDataLoaded ? ListView() :
        const Text('Please Wait....'),
      ),
    );
  }
}

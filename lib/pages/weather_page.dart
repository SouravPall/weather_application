import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_application/provider/weather_provider.dart';
import 'package:weather_application/utils/constants.dart';
import 'package:weather_application/utils/helper_function.dart';
import 'package:weather_application/utils/location_utils.dart';
import 'package:weather_application/utils/text_styles.dart';

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
        child: provider.hasDataLoaded ? ListView(
          padding: const EdgeInsets.all(8),
          children: [
             _currentWeatherSection(),
              _forecastWeatherSection(),
          ],
        ) :
        const Text('Please Wait....', style: textNormal16,),
      ),
    );
  }

  Widget _currentWeatherSection() {
    final response = provider.currentResponseModel;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(getFormattedDateTime(response!.dt!, 'MM dd, yyyy'), style: textDateHeader18,),
        Text('${response.name}, ${response.sys!.country}', style:  textAddress24,),
        Padding(
            padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network('$iconPrefix${response.weather![0].icon}$iconSuffix',fit:  BoxFit.cover,),
              Text('${response.main!.temp!.round()}$degree$celsius', style: textTempBig80,),
            ],
          ),
        ),
        Wrap(
          children: [
            Text('Feels like ${response.main!.feelsLike!.round()}$degree$celsius', style: textNormal16,),
            const SizedBox(width: 10,),
            Text('${response.weather![0].main}, ${response.weather![0].description}', style: textNormal16,),
          ],
        ),
        const SizedBox(height: 20,),
        Wrap(
          children: [
            Text('Humidity ${response.main!.humidity}%', style: textNormal16White54,),
            const SizedBox(width: 10,),
            Text('Pressure ${response.main!.pressure}hPa', style: textNormal16White54,),
            const SizedBox(width: 10,),
            Text('Visibility ${response.visibility}meter', style: textNormal16White54,),
            const SizedBox(width: 10,),
            Text('Wind ${response.wind!.speed}m/s', style: textNormal16White54,),
            const SizedBox(width: 10,),
            Text('Degree ${response.wind!.deg}$degree', style: textNormal16White54,),
          ],
        ),
        const SizedBox(height: 20,),
        Wrap(
          children: [
            Text('Sunrise ${getFormattedDateTime(response.sys!.sunrise!, 'hh:mm a')}', style: textNormal16,),
            const SizedBox(width: 10,),
            Text('Sunset ${getFormattedDateTime(response.sys!.sunset!, 'hh:mm a')}', style: textNormal16,),
          ],
        ),

      ],
    );
  }

   Widget _forecastWeatherSection() {
    return Center();
   }
}

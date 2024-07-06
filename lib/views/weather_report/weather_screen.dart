import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:skycast/constants/graphic_constants.dart';
import 'package:skycast/extensions/datetime.dart';
import 'package:skycast/extensions/double.dart';
import 'package:skycast/extensions/int.dart';
import 'package:skycast/extensions/strings.dart';
import 'package:skycast/models/city_model.dart';
import 'package:skycast/models/weather_report_model.dart';
import 'package:skycast/services/weather_services.dart';
import 'package:skycast/views/global/glass_scaffold.dart';
import 'package:skycast/views/global/responsive_text_widget.dart';
import 'package:skycast/views/global/responsive_widget.dart';
import 'package:skycast/views/weather_report/weather_report_widgets.dart';

class WeatherScreen extends StatefulWidget {
  final CityModel city;
  const WeatherScreen({super.key, required this.city});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Future<WeatherReportModel>? _weatherReportModel;

  @override
  void initState() {
    // Fetch weather report for the specified city
    _weatherReportModel = WeatherServices.getWeatherReport(widget.city);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          // Refresh the weather report when the user pulls down the screen
          _weatherReportModel = WeatherServices.getWeatherReport(widget.city);
          setState(() {});
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - kToolbarHeight - 20,
              child: FutureBuilder<WeatherReportModel>(
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Show a loading animation while waiting for the weather report
                    return Center(
                      child: Lottie.asset(
                        GraphicConstants.loadingAnimation,
                        height: 200,
                        width: 200,
                      ),
                    );
                  }

                  if (snapshot.hasError) {
                    // Show an error message if there was an error fetching the data
                    return const Center(
                      child: ResponsiveText('Error fetching data',
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                    );
                  }

                  if (snapshot.data == null) {
                    // Show a message if no data was found
                    return const Center(
                      child: ResponsiveText('No data found',
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                    );
                  }
                  return ResponsiveWidget(
                    tablet: _tabletView(snapshot),
                    mobile: _mobileView(snapshot),
                  );
                },
                future: _weatherReportModel,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column _mobileView(AsyncSnapshot<WeatherReportModel> snapshot) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display the city name
              ResponsiveText(
                '📍 ${widget.city.name}',
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontSize: 15),
              ),
              const SizedBox(height: 8),
              // Display a greeting based on the current time
              ResponsiveText(
                DateTime.now().greetGood,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
        Flexible(
          child: Align(
            alignment: Alignment.center,
            child: _getAnimation(snapshot),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Display the current temperature
            ResponsiveText(
              '${snapshot.data!.main.temp.celsius}°C',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 45,
                  fontWeight: FontWeight.w600),
            ),
            // Display the weather description
            ResponsiveText(
              snapshot.data!.weather[0].description.capitalize,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 5),
            // Display the current date and time
            ResponsiveText(
              DateTime.now().dateTime,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w300),
            ),
          ],
        ),
        const SizedBox(
          height: 50,
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Display the humidity
                WeatherRow(
                  imagePath: GraphicConstants.sunRise,
                  label: 'Humidity',
                  value: '${snapshot.data!.main.humidity}%',
                ),
                // Display the wind speed
                WeatherRow(
                  imagePath: GraphicConstants.sunSet,
                  label: 'Wind Speed',
                  value: '${snapshot.data!.wind.speed} mph',
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0),
              child: Divider(
                color: Colors.grey,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Display the maximum temperature
                WeatherRow(
                  imagePath: GraphicConstants.tempMax,
                  label: 'Temp Max',
                  value: "${snapshot.data!.main.tempMax.celsius} °C",
                ),
                // Display the minimum temperature
                WeatherRow(
                  imagePath: GraphicConstants.tempMin,
                  label: 'Temp Min',
                  value: "${snapshot.data!.main.tempMin.celsius} °C",
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Row _tabletView(AsyncSnapshot<WeatherReportModel> snapshot) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Display the city name
                ResponsiveText(
                  '📍 ${widget.city.name}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 15),
                ),
                const SizedBox(height: 8),
                // Display a greeting based on the current time
                ResponsiveText(
                  DateTime.now().greetGood,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Display the current temperature
                ResponsiveText(
                  '${snapshot.data!.main.temp.celsius}°C',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.w600),
                ),
                // Display the weather description
                ResponsiveText(
                  snapshot.data!.weather[0].description.capitalize,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 5),
                // Display the current date and time
                ResponsiveText(
                  DateTime.now().dateTime,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ],
        ),
        Flexible(child: _getAnimation(snapshot)),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the humidity
            WeatherRow(
              imagePath: GraphicConstants.sunRise,
              label: 'Humidity',
              value: '${snapshot.data!.main.humidity}%',
            ),
            // Display the wind speed
            WeatherRow(
              imagePath: GraphicConstants.sunSet,
              label: 'Wind Speed',
              value: '${snapshot.data!.wind.speed} mph',
            ),
            // Display the maximum temperature
            WeatherRow(
              imagePath: GraphicConstants.tempMax,
              label: 'Temp Max',
              value: "${snapshot.data!.main.tempMax.celsius} °C",
            ),
            // Display the minimum temperature
            WeatherRow(
              imagePath: GraphicConstants.tempMin,
              label: 'Temp Min',
              value: "${snapshot.data!.main.tempMin.celsius} °C",
            ),
          ],
        ),
      ],
    );
  }

  Widget _getAnimation(AsyncSnapshot<WeatherReportModel> snapshot) {
    // Display the weather animation based on the weather condition
    return Lottie.asset(
      '${GraphicConstants.weatherLottieFolder}${snapshot.data!.weather[0].icon}.json',
      fit: BoxFit.cover,
    );
  }
}

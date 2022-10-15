import 'package:bloc_weather_api/pages/ui/widgets/forecast_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ForecastWeekend extends StatelessWidget {
  ForecastWeekend(
      {Key? key, required this.hourlyWeatherForecast, required this.title})
      : super(key: key);
  late List hourlyWeatherForecast;
  late String title;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 10,
      ),
      SizedBox(
        height: 150.0,
        child: ListView.builder(
          itemCount: 24,
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            String currentTime = DateFormat('HH:mm:ss').format(DateTime.now());
            String currentHour = currentTime.substring(0, 2);

            String forecastTime =
                hourlyWeatherForecast[index]["time"].substring(11, 16) ?? '0';
            String forecastHour =
                hourlyWeatherForecast[index]["time"].substring(11, 13) ?? '0:0';

            String forecastWeatherName =
                hourlyWeatherForecast[index]["condition"]["text"] ?? '';
            String forecastWeatherIcon =
                hourlyWeatherForecast[index]["condition"]["icon"] ?? '';
            if (forecastWeatherIcon != null) {
              List<String> splitIcon = forecastWeatherIcon.split('64x64/');
              forecastWeatherIcon = splitIcon[1];
            }
            String forecastTemperature =
                hourlyWeatherForecast[index]["temp_c"].round().toString();
            return ForecastWidget(
              forecastTime: forecastTime,
              forecastWeatherIcon: forecastWeatherIcon,
              forecastTemperature: forecastTemperature,
            );

            // return const ForecastWidget(
            //   forecastTime: '0:0',
            //   forecastWeatherIcon: 'day/113.png',
            //   forecastTemperature: '0',
            // );
          },
        ),
      )
    ]);
  }
}

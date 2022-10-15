import 'package:bloc_weather_api/pages/ui/widgets/weather_item.dart';
import 'package:flutter/material.dart';

class WeatherBox extends StatelessWidget {
  const WeatherBox({
    Key? key,
    required this.weatherIcon,
    required this.currentWeatherStatus,
    required this.temperature,
    required this.windSpeed,
    required this.humidity,
    required this.cloud,
  }) : super(key: key);

  final String weatherIcon;
  final String currentWeatherStatus;
  final int temperature;
  final int windSpeed;
  final int humidity;
  final int cloud;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 300.0,
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [
          Color.fromARGB(255, 148, 212, 255),
          Color.fromARGB(255, 7, 83, 159)
        ]),
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
              color: Colors.blue.withOpacity(0.7),
              offset: const Offset(0, 25),
              blurRadius: 10,
              spreadRadius: -12)
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          temperature.toString(),
                          style: const TextStyle(
                            fontSize: 60,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const Text(
                        '°C',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(children: [
                    // Text(
                    //   currentWeatherStatus,
                    //   style: const TextStyle(
                    //     color: Colors.white,
                    //     fontSize: 24,
                    //   ),
                    // ),
                    Container(
                      width: 230.0,
                      height: 70.0,
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        currentWeatherStatus,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                        maxLines: 2,
                      ),
                    )
                  ]),
                ],
              ),
              SizedBox(
                // padding: const EdgeInsets.only(right: 0.0),
                width: 125,
                height: 125,
                //constraints: const BoxConstraints.expand(height: 200.0),
                //child: Image.asset("assets/images/icons/day/113.png",
                child: Image.asset("assets/images/icons/" + weatherIcon,
                    fit: BoxFit.fill),
              ),
            ],
          ),
          const SizedBox(
            height: 30.0,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WeatherItem(
                value: windSpeed.toInt(),
                unit: "km/h",
                imageUrl: 'assets/images/windspeed.png',
              ),
              const SizedBox(
                width: 10,
              ),
              WeatherItem(
                value: humidity.toInt(),
                unit: "%",
                imageUrl: 'assets/images/humidity.png',
              ),
              const SizedBox(
                width: 10,
              ),
              WeatherItem(
                value: cloud.toInt(),
                unit: "%",
                imageUrl: 'assets/images/cloud.png',
              ),
            ],
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ForecastWidget extends StatelessWidget {
  const ForecastWidget({
    Key? key,
    required this.forecastTime,
    required this.forecastWeatherIcon,
    required this.forecastTemperature,
  }) : super(key: key);

  final String forecastTime;
  final String forecastWeatherIcon;
  final String forecastTemperature;
  //final List<String> icon = forecastWeatherIcon.split('64x64/');
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        margin: const EdgeInsets.only(right: 20),
        width: 65,
        height: 250,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(50)),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 1),
              blurRadius: 5,
              color: Colors.blue,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              forecastTime,
              style: const TextStyle(
                fontSize: 17,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
            Image.asset("assets/images/icons/" + forecastWeatherIcon,
                fit: BoxFit.fill),
            //Image.network("https:" + forecastWeatherIcon),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  forecastTemperature,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Text(
                  '°',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

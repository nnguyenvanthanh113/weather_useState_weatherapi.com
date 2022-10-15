import 'dart:convert';

import 'package:bloc_weather_api/constants/location_constant.dart';
import 'package:bloc_weather_api/pages/ui/widgets/drawer_widget.dart';
import 'package:bloc_weather_api/pages/ui/widgets/forecast_weekend.dart';
import 'package:bloc_weather_api/pages/ui/widgets/forecast_widget.dart';
import 'package:bloc_weather_api/pages/ui/widgets/weather_box_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _cityController = TextEditingController();
  int temperature = 0;
  int windSpeed = 0;
  int humidity = 0;
  int cloud = 0;
  bool loadData = false;

  String currentDate = '0';
  String weatherIcon = 'default.png';
  //List hourlyWeatherForecast = [];
  List dailyWeatherForecast = [];
  String currentWeatherStatus = '';

  //lay du lieu thoi tiet vi tri
  Future<void> fetchWeatherData(String searchText) async {
    try {
      var searchResult =
          await http.get(Uri.parse(LocationConstant.searchApi + searchText));
      final weatherData = Map<String, dynamic>.from(
          json.decode(searchResult.body) ?? "Not found");
      var locationData = weatherData['location'];
      var currentWeather = weatherData['current'];
      print('weather' + weatherData.toString());
      setState(() {
        LocationConstant.location = getShortLocationName(locationData["name"]);
        var parsedDate =
            DateTime.parse(locationData['localtime'].substring(0, 10));
        var newDate = DateFormat('MMMMEEEEd').format(parsedDate);
        currentDate = newDate;
        //lay thong tin thoi tiet
        currentWeatherStatus = currentWeather['condition']['text'];
        weatherIcon = currentWeather['condition']['icon'];
        List<String> splitIcon = weatherIcon.split("64x64/");
        weatherIcon = splitIcon[1];
        print('weatherIcon: ' + weatherIcon);
        temperature = currentWeather['temp_c'].toInt();
        windSpeed = currentWeather["wind_kph"].toInt();
        humidity = currentWeather['humidity'].toInt();
        cloud = currentWeather['cloud'].toInt();

        //du bao thoi tiet
        dailyWeatherForecast = weatherData['forecast']['forecastday'];
        loadData = true;
        print(
            'dailyWeatherForecast: ' + dailyWeatherForecast.length.toString());
        //hourlyWeatherForecast = dailyWeatherForecast[0]['hour'];
      });
    } catch (e) {
      print('error:' + e.toString());
    }
  }

  //
  static String getShortLocationName(String s) {
    List<String> wordList = s.split(" ");
    if (wordList.isNotEmpty) {
      if (wordList.length > 1) {
        return wordList[0] + " " + wordList[1];
      } else {
        return wordList[0];
      }
    }
    return " ";
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchWeatherData(LocationConstant.location);
    // print(fetchWeatherData(location));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: DrawerWidget(),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 116, 155, 227),
                            borderRadius: BorderRadius.circular(5.0),
                            border:
                                Border.all(color: Colors.white, width: 1.5)),
                        child: GestureDetector(
                          onTap: () {
                            _scaffoldKey.currentState?.openDrawer();
                          },
                          child: const Icon(
                            Icons.menu,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 220,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.deepPurple,
                          border: Border.all(
                            width: 1.5,
                            color: Colors.white,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.pin_drop,
                                size: 27, color: Colors.white),
                            const SizedBox(
                              width: 2,
                            ),
                            Text(
                              LocationConstant.location,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16),
                            ),
                            IconButton(
                              onPressed: () {
                                _cityController.clear();
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) => SingleChildScrollView(
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .2,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const SizedBox(
                                            width: 70,
                                            child: Divider(
                                              thickness: 3.5,
                                              color: Color(0xff6b9dfc),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          TextField(
                                            onChanged: (searchText) {
                                              fetchWeatherData(searchText);
                                            },
                                            controller: _cityController,
                                            autofocus: true,
                                            decoration: InputDecoration(
                                                prefixIcon: const Icon(
                                                  Icons.search,
                                                  color: Colors.black,
                                                ),
                                                suffixIcon: GestureDetector(
                                                  onTap: () =>
                                                      _cityController.clear(),
                                                  child: const Icon(Icons.close,
                                                      color: Colors.black),
                                                ),
                                                hintText: "thành phố...",
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.black),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          decoration: BoxDecoration(
                            color: Colors.deepPurple,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: const Icon(
                                Icons.person,
                                size: 30.0,
                                color: Colors.white,
                              ),
                            ),
                          ))
                    ],
                  ),
                  const SizedBox(height: 25.0),
                  Text(
                    LocationConstant.location,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    currentDate,
                    style: const TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    //height: 500.0,
                    padding: const EdgeInsets.only(
                        top: 30.0, left: 10.0, right: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        WeatherBox(
                            weatherIcon: weatherIcon,
                            currentWeatherStatus: currentWeatherStatus,
                            temperature: temperature,
                            windSpeed: windSpeed,
                            humidity: humidity,
                            cloud: cloud),
                        const SizedBox(
                          height: 20.0,
                        ),
                        SizedBox(
                          //height: 160,

                          child: loadData
                              ? Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ForecastWeekend(
                                      hourlyWeatherForecast:
                                          dailyWeatherForecast[0]['hour'],
                                      title: dailyWeatherForecast[0]['date'],
                                    ),
                                    const SizedBox(height: 12),
                                    ForecastWeekend(
                                      hourlyWeatherForecast:
                                          dailyWeatherForecast[1]['hour'],
                                      title: dailyWeatherForecast[1]['date'],
                                    ),
                                    const SizedBox(height: 12),
                                    ForecastWeekend(
                                      hourlyWeatherForecast:
                                          dailyWeatherForecast[2]['hour'],
                                      title: dailyWeatherForecast[2]['date'],
                                    ),
                                    const SizedBox(height: 12),
                                    ForecastWeekend(
                                      hourlyWeatherForecast:
                                          dailyWeatherForecast[3]['hour'],
                                      title: dailyWeatherForecast[3]['date'],
                                    ),
                                    const SizedBox(height: 12),
                                    ForecastWeekend(
                                      hourlyWeatherForecast:
                                          dailyWeatherForecast[4]['hour'],
                                      title: dailyWeatherForecast[4]['date'],
                                    ),
                                    const SizedBox(height: 12),
                                    ForecastWeekend(
                                      hourlyWeatherForecast:
                                          dailyWeatherForecast[5]['hour'],
                                      title: dailyWeatherForecast[5]['date'],
                                    ),
                                    const SizedBox(height: 12),
                                    ForecastWeekend(
                                      hourlyWeatherForecast:
                                          dailyWeatherForecast[6]['hour'],
                                      title: dailyWeatherForecast[6]['date'],
                                    ),
                                  ],
                                )
                              : Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: const [
                                        Text(
                                          '',
                                          style: TextStyle(
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
                                          return const ForecastWidget(
                                            forecastTime: '0:0',
                                            forecastWeatherIcon: 'day/113.png',
                                            forecastTemperature: '0',
                                          );
                                        },
                                      ),
                                    )
                                  ],
                                ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

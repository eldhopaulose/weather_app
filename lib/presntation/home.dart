import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/constants/constant.dart';
import 'package:weather_app/models/models.dart';

class MyHome extends StatelessWidget {
  MyHome({super.key});

  final TextEditingController controller =
      TextEditingController(text: "Koothattukulam");
  String getCurrentDateAndMonth() {
    var now = DateTime.now();
    var formatter = DateFormat('EEE, d MMM');
    return formatter.format(now);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state.isLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: HexColor(kBackGroundColor),
            ),
          );
        }
        final List<Weather>? weather = state.result?.weather;

        final Main? main = state.result?.main;

        final String? name = state.result?.name;

        final int? visibility = state.result?.visibility;

        final Wind? wind = state.result?.wind;

        final Coord? coord = state.result?.coord;

        final double? temperature = main?.temp;
        final String temperatureString = temperature != null
            ? ((temperature - 273.15)).toStringAsFixed(0)
            : '';

        final double? tempMax = main?.tempMax;
        final String tempMaxString =
            tempMax != null ? ((tempMax - 273.15)).toStringAsFixed(0) : '';
        final double? tempMin = main?.tempMin;
        final String tempMinString =
            tempMin != null ? ((tempMin - 273.15)).toStringAsFixed(0) : '';
        final double? feelsLike = main?.feelsLike;
        final String feelsLikeString =
            feelsLike != null ? ((feelsLike - 273.15)).toStringAsFixed(0) : '';
        final String visibilityString =
            visibility != null ? ((visibility / 1000)).toStringAsFixed(0) : '';
        final int? humidity = main?.humidity;
        final String? mainW = weather?[0].main;
        final String? description = weather?[0].description;
        final double? speed = wind?.speed;
        final double? lat = coord?.lat;
        final double? lon = coord?.lon;

        return Scaffold(
          body: SafeArea(
            child: ListView(
              children: [
                kHight10,
                CupertinoSearchTextField(
                  controller: controller,
                  style: const TextStyle(color: Colors.black),
                  autocorrect: true,
                  backgroundColor: Colors.black.withOpacity(0.5),
                  itemColor: Colors.black,
                  autofocus: true,
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      BlocProvider.of<WeatherBloc>(context)
                          .add(FeatchApiEvent(value));
                    }
                  },
                ),
                Column(children: [
                  kHight10,
                  Text(
                    '$name',
                    style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            letterSpacing: .5)),
                  ),
                  kHight10,
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    color: Colors.black,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        getCurrentDateAndMonth(),
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                color: HexColor(kBackGroundColor),
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                letterSpacing: .5)),
                      ),
                    ),
                  ),
                  kHight3,
                  Text(
                    "$mainW",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '$temperatureString\u00B0',
                    style: const TextStyle(
                        fontSize: 180, fontWeight: FontWeight.w400),
                  ),
                  kWidh10,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Daily Summary",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      kHight10,
                      Text(
                        "Now it seems that +$tempMinString\u00B0, in fact +$tempMaxString\u00B0",
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(
                          "It's $mainW now because of the $description. Today,",
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      Text(
                          "the temperature is felt like +$feelsLikeString\u00B0 to ",
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  kHight20,
                  Column(
                    children: [
                      Container(
                        height: 140,
                        width: 340,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                kHight20,
                                Icon(
                                  CupertinoIcons.wind,
                                  color: HexColor(kBackGroundColor),
                                  size: 50,
                                ),
                                kHight10,
                                Text(
                                  "${speed}km/h",
                                  style: TextStyle(
                                    color: HexColor(kBackGroundColor),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                kHight3,
                                Text(
                                  "Wind",
                                  style: TextStyle(
                                    color: HexColor(kBackGroundColor),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                kHight20,
                                Icon(
                                  CupertinoIcons.drop,
                                  color: HexColor(kBackGroundColor),
                                  size: 50,
                                ),
                                kHight10,
                                Text(
                                  "$humidity%",
                                  style: TextStyle(
                                    color: HexColor(kBackGroundColor),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                kHight3,
                                Text(
                                  "Humidity",
                                  style: TextStyle(
                                    color: HexColor(kBackGroundColor),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                kHight20,
                                Icon(
                                  Icons.remove_red_eye_outlined,
                                  color: HexColor(kBackGroundColor),
                                  size: 50,
                                ),
                                kHight10,
                                Text(
                                  "${visibilityString}km",
                                  style: TextStyle(
                                    color: HexColor(kBackGroundColor),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                kHight3,
                                Text(
                                  "Visibility",
                                  style: TextStyle(
                                    color: HexColor(kBackGroundColor),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  kHight10,
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      kWidh20,
                      Text(
                        " Coordinates",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  kHight10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: MediaQuery.sizeOf(context).width * 0.8,
                        height: 90,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(14)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              size: 30,
                            ),
                            Text(
                              "$lat - $lon",
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ]),
              ],
            ),
          ),
        );
      },
    );
  }
}

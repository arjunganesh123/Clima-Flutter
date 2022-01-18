import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {

  final locationdata;
  LocationScreen({this.locationdata});
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  WeatherModel weather=WeatherModel();
  String weatherIcon;
  String message;

  int temperature;
  int condition;
  String cityname;
  @override
  void initState() {
    super.initState();
    upiupdate(widget.locationdata);
  }

  void upiupdate(dynamic wheatherdata){
    setState(() {
      if(wheatherdata==null){
        temperature=0;
        weatherIcon='null';
        message='null';
        cityname='';
        return;
      }
      double temp=wheatherdata['main']['temp'];
      temperature=temp.toInt();
      condition=wheatherdata['weather'][0]['id'];
      cityname=wheatherdata['name'];
      weatherIcon=weather.getWeatherIcon(condition);
      message=weather.getMessage(temperature);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async{
                      var data= await weather.getposition();
                      upiupdate(data);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async{
                      var typedCityName=await Navigator.push(context, MaterialPageRoute(builder: (context){
                        return CityScreen();
                      }));
                      if(typedCityName!=null){
                        dynamic data=await weather.getcityweather(typedCityName);
                        upiupdate(data);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$weatherIcon',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$message in $cityname",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

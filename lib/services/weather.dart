import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
class WeatherModel {
  double longitude;
  double latitude;
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  Future<dynamic> getcityweather(dynamic typedname) async{
     Network net=Network('https://api.openweathermap.org/data/2.5/weather?q=$typedname&appid=8d2ab8285d11966578267a5fb7d497aa&units=metric');

     var data=await net.getdata();
     return data;
  }


  Future<dynamic> getposition() async{
    Location location=Location();
    await location.getposition();
    longitude=location.longitude;
    latitude=location.latitude;

    Network network=Network('https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=8d2ab8285d11966578267a5fb7d497aa&units=metric');

    var data= await network.getdata();
    return data;
  }
  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}

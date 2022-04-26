import 'package:flutter_my_own_first_app/data/api_constants.dart';
import 'package:flutter_my_own_first_app/models/weather_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<Weather?> getWeather() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.test);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        Weather _model = weatherFromJson(response.body);
        // print("api services _model: ${_model.region}");
        // print("_model: ${_model.currentConditions?.dayhour.toString()}");

        return _model;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  get weatherData {
    getWeather();
  }
}

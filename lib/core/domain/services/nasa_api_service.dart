import 'package:nasa_apod_viewer/core/data/remote/api.dart';
import 'package:nasa_apod_viewer/utils/date.dart';

class NasaApiService {

  String nasaHost = "api.nasa.gov";

  Future<Map<String, dynamic>> searchApod({
    DateTime? date,
    DateTime? endDate
  }){

    Map<String, dynamic> params = {
      /**This key should be inside a .env file, utilizing the package
       * flutter_dot_env. For the purpouses of this exercise, im gonna leave
       * it hard coded */ 
      "api_key": "ecPKzSeT179jEfIikBS5aiyeE7TYSuMOMhng5kJw"
    };

    if(date != null){
      params["date"] = formatDate(date);
    }
    if(endDate != null){
      params["start_date"] = params["date"];
      params.remove("date");
      params["end_date"] = formatDate(endDate);
    }

    return Api(url: nasaHost).get("planetary/apod", params: params);
  }

}
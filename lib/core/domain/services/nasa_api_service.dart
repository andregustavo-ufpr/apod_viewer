import 'package:nasa_apod_viewer/core/data/remote/api.dart';
import 'package:nasa_apod_viewer/utils/date.dart';

class NasaApiService {

  String nasaHost = "api.nasa.gov";

  Future<Map<String, dynamic>> searchApod({
    DateTime? date,
    DateTime? endDate
  }){

    Map<String, dynamic> params = {
      // TODO: Remove key and place in .env file
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
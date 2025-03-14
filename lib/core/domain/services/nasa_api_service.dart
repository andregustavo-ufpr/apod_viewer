import 'package:flutter_dotenv/flutter_dotenv.dart';
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
       * flutter_dot_env. Create your own .env file and provide your API key
       * */ 
      "api_key": dotenv.env["NASA_API_KEY"] ?? ""
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
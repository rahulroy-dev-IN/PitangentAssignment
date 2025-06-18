import 'package:dio/dio.dart';
import 'package:pitangent_assignment/global/network/api_client/dio_client.dart';
import 'package:pitangent_assignment/global/network/shared_pref/preference_connector.dart';

class AppRepository {
  DioClient? dioClient;
  PreferenceConnector? preferenceConnector;
  Options? option;

  AppRepository() {
    dioClient = DioClient();
    option = Options(headers: {"Content-Type": "application/json"});
    preferenceConnector = PreferenceConnector();
  }
}

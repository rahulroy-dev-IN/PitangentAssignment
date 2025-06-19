import 'package:dio/dio.dart';
import 'package:pitangent_assignment/global/constants/api_endpoints.dart';
import 'package:pitangent_assignment/global/network/api_client/dio_client.dart';
import 'package:pitangent_assignment/global/network/modal/remote/products_response.dart';
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

  Future<ProductsResponse> fetchProduct({
    int? limit,
    int? skip,
    String? category,
  }) async {
    var queryParameters = <String, dynamic>{};
    if (limit != null) {
      queryParameters['limit'] = limit;
    }
    if (skip != null) {
      queryParameters['skip'] = skip;
    }
    var endPoint = category == null
        ? ApiEndpoints.products
        : (ApiEndpoints.categories + category);
    final response = await dioClient?.get(
      endPoint,
      queryParameters: queryParameters,
    );
    return ProductsResponse.fromJson(response?.data);
  }
}

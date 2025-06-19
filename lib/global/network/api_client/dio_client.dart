import 'dart:async';
import 'package:dio/dio.dart';
import 'package:pitangent_assignment/global/constants/api_endpoints.dart';
import 'package:pitangent_assignment/global/network/shared_pref/pref_strings.dart';
import 'package:pitangent_assignment/global/network/shared_pref/preference_connector.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();

  factory DioClient() => _instance;

  DioClient._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.siteUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {'Accept': 'application/json'},
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await getAccessToken();
          if (token != null) {
            options.headers['Authorization'] = '${ApiEndpoints.bearer} $token';
          }
          return handler.next(options);
        },
        onError: (DioException error, handler) async {
          if (_isTokenExpired(error)) {
            try {
              final newToken = await _refreshToken();
              if (newToken != null) {
                error.requestOptions.headers['Authorization'] =
                    '${ApiEndpoints.bearer} $newToken';
                final clonedRequest = await _retry(error.requestOptions);
                return handler.resolve(clonedRequest);
              }
            } catch (e) {
              return handler.reject(error); // Handle logout here
            }
          }
          return handler.reject(error);
        },
      ),
    );
  }

  late final Dio _dio;

  Dio get dio => _dio;

  Future<String?> getAccessToken() async {
    return PreferenceConnector().getString(PrefStrings.accessToken);
  }

  Future<String?> _refreshToken() async {
    if (_isRefreshing) {
      return _refreshCompleter.future;
    }

    _isRefreshing = true;
    _refreshCompleter = Completer();

    try {
      final refreshToken = await PreferenceConnector().getString(
        PrefStrings.refreshToken,
      );
      final response = await _dio.post(
        '/auth/refresh',
        data: {'refreshToken': refreshToken},
      );

      final newAccessToken = response.data['accessToken'];
      final newRefreshToken = response.data['refreshToken'];

      await PreferenceConnector().setString(
        PrefStrings.accessToken,
        newAccessToken,
      );
      await PreferenceConnector().setString(
        PrefStrings.refreshToken,
        newRefreshToken,
      );
      _refreshCompleter.complete(newAccessToken);
      return newAccessToken;
    } catch (e) {
      _refreshCompleter.completeError(e);
      rethrow;
    } finally {
      _isRefreshing = false;
    }
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return _dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }

  bool _isTokenExpired(DioException error) {
    return error.response?.statusCode == 401;
  }

  bool _isRefreshing = false;
  late Completer<String> _refreshCompleter;

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) {
    return _dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return _dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }
}

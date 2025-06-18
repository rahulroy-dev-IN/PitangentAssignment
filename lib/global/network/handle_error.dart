import 'package:dio/dio.dart';
import 'package:pitangent_assignment/global/constants/app_strings.dart';

String handleDioError(dynamic error) {
  if (error is DioException) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return AppStrings.connectionTimeout;
      case DioExceptionType.sendTimeout:
        return AppStrings.sendTimeout;
      case DioExceptionType.receiveTimeout:
        return AppStrings.receiveTimeout;
      case DioExceptionType.badCertificate:
        return AppStrings.badCertificate;
      case DioExceptionType.badResponse:
        return getError(error.response) ?? AppStrings.unexpectedErrorOccured;
      case DioExceptionType.cancel:
        return AppStrings.requestCancelled;
      case DioExceptionType.connectionError:
        return AppStrings.connectionError;
      case DioExceptionType.unknown:
        return AppStrings.unexpectedErrorOccured;
    }
  } else {
    return "Unexpected error: ${error.toString()}";
  }
}

String? getError(Response? response) {
  String errorMessage = AppStrings.unexpectedErrorOccured;
  if (response?.data != null && response?.data is Map) {
    if ((response?.data as Map).containsKey('error')) {
      errorMessage = getErrorMsg((response?.data)["error"]);
    } else if ((response?.data as Map).containsKey('msg')) {
      errorMessage = getErrorMsg((response?.data)["msg"]);
    }
    return errorMessage;
  }
  return errorMessage;
}

String getErrorMsg(final errorMessageHeading) {
  if (errorMessageHeading is String) {
    return errorMessageHeading;
  } else if (errorMessageHeading is List) {
    return errorMessageHeading.join(' , ');
  } else if (errorMessageHeading is Map) {
    List<String> errorList = [];
    errorMessageHeading.forEach((key, value) {
      if (value is List) {
        errorList.add(value[0]);
      } else {
        errorList.add(value);
      }
    });
    return errorList.join(' , ');
  } else {
    return AppStrings.unexpectedErrorOccured;
  }
}

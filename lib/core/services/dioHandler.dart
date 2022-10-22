import 'package:dio/dio.dart';

class ApiProvider {
  final Dio dio = Dio(BaseOptions(
      connectTimeout: 60000,
      receiveTimeout: 60000,
      followRedirects: false,
      validateStatus: (status) {
        return status! < 500;
      }));
  ApiProvider() {
    dio.interceptors.add(
        InterceptorsWrapper(onRequest: (RequestOptions options, handler) async {
      var token = "";

      if (token.isNotEmpty) {
        options.headers.addAll({
          'Authorization': 'Bearer $token',
        });
      }
      return handler.next(options);
    }, onResponse: (response, handler) {
      // Do something with response data
      return handler.next(response); // continue
      // If you want to reject the request with a error message,
      // you can reject a `DioError` object eg: return `dio.reject(dioError)`
    }, onError: (DioError err, ErrorInterceptorHandler handler) {
      switch (err.type) {
        case DioErrorType.connectTimeout:
        case DioErrorType.sendTimeout:
        case DioErrorType.receiveTimeout:
          throw DeadlineExceededException(err.requestOptions);
        case DioErrorType.response:
          switch (err.response?.statusCode) {
            case 400:
              throw BadRequestException(err.requestOptions);
            case 401:
              throw UnauthorizedException(err.requestOptions);
            case 404:
              throw NotFoundException(err.requestOptions);
            case 409:
              throw ConflictException(err.requestOptions);
            case 500:
              throw InternalServerErrorException(err.requestOptions);
          }
          break;
        case DioErrorType.cancel:
          break;
        case DioErrorType.other:
          throw NoInternetConnectionException(err.requestOptions);
      }

      return handler.next(err);
    }));
  }
}

class BadRequestException extends DioError {
  BadRequestException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Invalid request';
  }
}

class InternalServerErrorException extends DioError {
  InternalServerErrorException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Unknown error occurred, please try again later.';
  }
}

class ConflictException extends DioError {
  ConflictException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Conflict occurred';
  }
}

class UnauthorizedException extends DioError {
  UnauthorizedException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Access denied';
  }
}

class NotFoundException extends DioError {
  NotFoundException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The requested information could not be found';
  }
}

class NoInternetConnectionException extends DioError {
  NoInternetConnectionException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'No internet connection detected, please try again.';
  }
}

class DeadlineExceededException extends DioError {
  DeadlineExceededException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The connection has timed out, please try again.';
  }
}

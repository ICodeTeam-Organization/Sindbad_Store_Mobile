import 'package:dio/dio.dart';

abstract class Failure {
  final String message;

  Failure(this.message);
}

class ServerFailure extends Failure {
  // ServerFailure(super.message);
  ServerFailure(super.message); // new

  @override
  String toString() {
    return message;
  }

  factory ServerFailure.fromDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection timeout with api server');
      case DioExceptionType.sendTimeout:
        return ServerFailure('Send timeout with api server');
      case DioExceptionType.receiveTimeout:
        return ServerFailure('Receive timeout with api server');
      case DioExceptionType.badCertificate:
        return ServerFailure('BadCertificate timeout with api server');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
            e.response!.statusCode, e.response!.data);
      case DioExceptionType.cancel:
        return ServerFailure('Request to with api server was canceld');
      case DioExceptionType.connectionError:
        return ServerFailure('No Internet Connection');
      case DioExceptionType.unknown:
        return ServerFailure('Opps There was an Error, Please try again');
      // default:
      //   // Handle connectionTimeout case
      //   break;
    }
  }

  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    if (statusCode == 404) {
      // the request is not found
      return ServerFailure("Your request was not found, please try later");
    } else if (statusCode == 500) {
      return ServerFailure(
          "There is a problem with the server, please try later");
    } else if (statusCode == 503) {
      return ServerFailure("There is updating in the server, please try later");
    } else if (statusCode == 400) {
      return ServerFailure(response['message']);
    } else {
      return ServerFailure("There was an Error, Please try again");
    }
  }
}

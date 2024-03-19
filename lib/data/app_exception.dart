class AppException implements Exception {
  final dynamic _message;
  final dynamic _prefix;

  AppException([this._message, this._prefix]);
  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message]) : super(message, "");
}

class BadRequestException extends AppException {
  BadRequestException([String? message]) : super(message, "");
}

class UnAuthorizedException extends AppException {
  UnAuthorizedException([String? message]) : super(message, "");
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, "");
}

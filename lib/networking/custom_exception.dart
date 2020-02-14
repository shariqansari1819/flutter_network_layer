class CustomException implements Exception {
  final _message;
  final _prefix;

  CustomException([this._message, this._prefix]);

  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends CustomException {
  FetchDataException([String message])
      : super(message, "Error during communication");
}

class BadRequestException extends CustomException {
  BadRequestException([String message]) : super(message, "Invalid request");
}

class UnauthorizedException extends CustomException {
  UnauthorizedException([String message]) : super(message, "Unauthorized!");
}

class InvalidInputException extends CustomException {
  InvalidInputException([String message]) : super(message, "Invalid input");
}

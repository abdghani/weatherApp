abstract class ApiException implements Exception {
  final _message;
  final _prefix;

  ApiException([this._message, this._prefix]);
  String get message => _message;
  String get prefix => _prefix;

  String toString() {
    return "$_prefix";
  }
}

class EmptyResultException extends ApiException {
  EmptyResultException(String message) : super(message, " Communication Error");
}

class ConnectionException extends ApiException {
  ConnectionException(String message) : super(message, "Connection Error ");
}

class ServerErrorException extends ApiException {
  ServerErrorException(String message) : super(message, "Server Error ");
}

class ClientErrorException extends ApiException {
  ClientErrorException(String message) : super(message, "Invalid Data ");
}

class UnknownException extends ApiException {
  UnknownException(String message) : super(message, "UnKnown Error ");
}

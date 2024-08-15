class NetworkExceptions implements Exception {
  final String messageExceptions;
  NetworkExceptions(this.messageExceptions);

  @override
  String toString() => 'Network Exception: $messageExceptions';
}

class ServerException implements Exception {
  final String message;
  const ServerException(this.message);
}

class PersistenceException implements Exception {
  final String message;
  const PersistenceException(this.message);
}

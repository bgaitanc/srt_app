abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class AlwaysConnected implements NetworkInfo {
  @override
  Future<bool> get isConnected async => true;
}

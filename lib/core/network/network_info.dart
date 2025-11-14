abstract class NetworkInfo {
  Future<bool> get isConnected;
}

// Simple implementation that always returns true for now.
class AlwaysConnected implements NetworkInfo {
  @override
  Future<bool> get isConnected async => true;
}

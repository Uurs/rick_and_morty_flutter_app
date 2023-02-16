import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final connectivityObserverProvider = Provider<ConnectivityObserver>((ref) {
  return ConnectivityObserver();
});

class ConnectivityObserver {
  final _connectivity = Connectivity();

  Stream<ConnectivityResult> get onConnectivityChanged => _connectivity.onConnectivityChanged;

  Future<bool> get isConnected async {
    final result = await _connectivity.checkConnectivity();
    return result == ConnectivityResult.mobile || result == ConnectivityResult.wifi;
  }
}
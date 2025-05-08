import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkInfo {
  static final NetworkInfo _instance = NetworkInfo._internal();
  factory NetworkInfo() => _instance;
  NetworkInfo._internal();

  final Connectivity _connectivity = Connectivity();
  final StreamController<bool> _networkStatusController =
      StreamController<bool>.broadcast();

  Stream<bool> get onNetworkStatusChange => _networkStatusController.stream;

  Future<bool> isConnected() async {
    var connectivityResults = await _connectivity.checkConnectivity();
    return connectivityResults.isNotEmpty && !connectivityResults.contains(ConnectivityResult.none);
  }

  void _updateNetworkStatus(List<ConnectivityResult> results) {
    bool hasConnection = results.isNotEmpty && !results.contains(ConnectivityResult.none);
    _networkStatusController.add(hasConnection);
  }

  void initialize() {
    _connectivity.onConnectivityChanged.listen(_updateNetworkStatus);
  }

  void dispose() {
    _networkStatusController.close();
  }
}

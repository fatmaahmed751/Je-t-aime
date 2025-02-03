import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();

  // Stream to listen for connectivity changes
  Stream<bool> get connectivityStream =>
      _connectivity.onConnectivityChanged.map(
        (result) => result.any((connectivityResult) =>
            connectivityResult != ConnectivityResult.none),
      );

  // Check current connectivity status
  Future<bool> checkInternetConnection() async {
    var result = await _connectivity.checkConnectivity();
    return result.any(
        (connectivityResult) => connectivityResult != ConnectivityResult.none);
  }
}

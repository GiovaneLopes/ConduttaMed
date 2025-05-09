import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:condutta_med/libs/src/exceptions/generic_errors.dart';

class NetworkChecker {
  static Future<void> checkConnection() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult.contains(ConnectivityResult.none)) {
      throw AppGenericErrors.noConnectionError;
    }
  }
}

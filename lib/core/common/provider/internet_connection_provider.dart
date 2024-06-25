import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class InternetConnectionProvider extends ChangeNotifier {
  bool _isConnectedToInternet = true;

  late StreamSubscription<ConnectivityResult> subscription;

  void initInternetConnection() {
    _listenConnectivity();
  }

  bool get isConnectedToInternet => _isConnectedToInternet;

  set isConnectedToInternet(bool isConnectedToInternet) {
    if (_isConnectedToInternet != isConnectedToInternet) {
      _isConnectedToInternet = isConnectedToInternet;
      /*we need to update the ui if there is a user  data update
      but if the page in building state
      it will throw an error that's why we need to delay */
      Future.delayed(Duration.zero, notifyListeners);
    }
  }

  void _listenConnectivity() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
          debugPrint('');
          if (result == ConnectivityResult.mobile ||
              result == ConnectivityResult.wifi) {
            isConnectedToInternet = true;
          } else {
            isConnectedToInternet = false;
          }
    });
    // Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
    //
    // });
  }
}

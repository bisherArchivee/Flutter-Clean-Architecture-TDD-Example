import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:education_app/core/common/enum/connection_enum.dart';
import 'package:education_app/core/common/feature/internetConnection/presentaion/cubit/internet_state.dart';

// part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  InternetCubit({required this.connectivity})
      : super(const InternetLoading(isConnected: true)) {
    monitorInternetConnection();
  }

  final Connectivity connectivity;
  late StreamSubscription<ConnectivityResult> connectivityStreamSubscription;

  StreamSubscription<ConnectivityResult> monitorInternetConnection() {
    return connectivityStreamSubscription =
        connectivity.onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult == ConnectivityResult.wifi) {
        emitInternetConnected(ConnectionStatusEnum.wifi);
      } else if (connectivityResult == ConnectivityResult.mobile) {
        emitInternetConnected(ConnectionStatusEnum.mobile);
      } else if (connectivityResult == ConnectivityResult.none) {
        emitInternetDisconnected();
      } else if (connectivityResult == ConnectivityResult.bluetooth) {
        emitInternetConnected(ConnectionStatusEnum.bluetooth);
      } else if (connectivityResult == ConnectivityResult.vpn) {
        emitInternetConnected(ConnectionStatusEnum.vpn);
      } else if (connectivityResult == ConnectivityResult.ethernet) {
        emitInternetConnected(ConnectionStatusEnum.ethernet);
      } else {
        emitInternetConnected(ConnectionStatusEnum.other);
      }
    });
  }

  void emitInternetConnected(ConnectionStatusEnum connectionType) =>
      emit(InternetConnected(
        connectionStatusEnum: connectionType,
        isConnected: true,
      ));

  void emitInternetDisconnected() =>
      emit(const InternetDisconnected(isConnected: false));

  @override
  Future<void> close() {
    connectivityStreamSubscription.cancel();
    return super.close();
  }
}

// part of 'internet_cubit.dart';

import 'package:education_app/core/common/enum/connection_enum.dart';
import 'package:equatable/equatable.dart';

abstract class InternetState extends Equatable {
  const InternetState({required this.isConnected});

  final bool isConnected;

  @override
  List<Object?> get props => [isConnected];
}

class InternetLoading extends InternetState {
  const InternetLoading({required super.isConnected});
}

class InternetConnected extends InternetState {
  const InternetConnected({
    required this.connectionStatusEnum,
    required super.isConnected,
  });

  final ConnectionStatusEnum connectionStatusEnum;
}

class InternetDisconnected extends InternetState {
  const InternetDisconnected({required super.isConnected});
}

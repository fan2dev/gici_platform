import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum SettingsStatus { initial, loaded }

class SettingsState extends Equatable {
  const SettingsState({
    this.status = SettingsStatus.initial,
  });

  final SettingsStatus status;

  SettingsState copyWith({
    SettingsStatus? status,
  }) {
    return SettingsState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status];
}

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsState());

  void init() {
    emit(state.copyWith(status: SettingsStatus.loaded));
  }
}

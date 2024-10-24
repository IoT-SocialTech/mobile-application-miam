// lib/metrics/application/bloc/vital_sign_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:miam_flutter/metrics/application/use_cases/get_vital_signs_use_case.dart';
import 'package:miam_flutter/metrics/domain/entities/vital_sign.dart';

class VitalSignCubit extends Cubit<VitalSignState> {
  final GetVitalSignsUseCase getVitalSignsUseCase;

  VitalSignCubit(this.getVitalSignsUseCase) : super(VitalSignInitial());

  void startMonitoring() {
    emit(VitalSignLoading());
    getVitalSignsUseCase.execute().listen((vitalSign) {
      emit(VitalSignLoaded(vitalSign));
    });
  }
}

abstract class VitalSignState {}

class VitalSignInitial extends VitalSignState {}

class VitalSignLoading extends VitalSignState {}

class VitalSignLoaded extends VitalSignState {
  final VitalSign vitalSign;

  VitalSignLoaded(this.vitalSign);
}

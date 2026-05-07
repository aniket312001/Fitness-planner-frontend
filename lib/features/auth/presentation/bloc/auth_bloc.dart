import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase loginUsecase;
  final RegisterUsecase registerUsecase;

  AuthBloc({required this.loginUsecase, required this.registerUsecase})
    : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<RegisterEvent>(_onRegister);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      final result = await loginUsecase(
        email: event.email,
        password: event.password,
      );

      emit(AuthSuccess(result));
    } on DioException catch (e) {
      emit(AuthFailure(e.response?.data['message'] ?? 'Login failed'));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      final result = await registerUsecase(
        name: event.name,
        email: event.email,
        password: event.password,
        role: event.role,
      );

      emit(AuthRegSuccess(result));
    } on DioException catch (e) {
      emit(AuthFailure(e.response?.data['message'] ?? 'Register failed'));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}

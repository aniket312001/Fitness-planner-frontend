import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_all_clients_usecase.dart';

import 'users_event.dart';
import 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final GetAllClientsUsecase getAllClientsUsecase;

  UsersBloc({required this.getAllClientsUsecase}) : super(UsersInitial()) {
    on<GetClientsEvent>(_getClients);
  }

  Future<void> _getClients(
    GetClientsEvent event,
    Emitter<UsersState> emit,
  ) async {
    emit(UsersLoading());

    try {
      final users = await getAllClientsUsecase(
        page: event.page,
        limit: event.limit,
        search: event.search,
      );

      emit(UsersLoaded(users));
    } catch (e) {
      emit(UsersFailure(e.toString()));
    }
  }
}

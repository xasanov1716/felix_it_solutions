
import 'package:bloc/bloc.dart';
import 'package:felix_it_solutions/data/models/user/user_request.dart';
import 'package:meta/meta.dart';

import '../../data/repositories/api_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final ApiRepository apiRepository;

  AuthBloc(this.apiRepository) : super(AuthInitial()) {
    on<RegisterEvent>((event, emit) async{
      emit(AuthLoadingState());
      try{
        final res = await apiRepository.register(event.userRequest);

        emit(AuthSuccessState());
      }
          catch(e){
            emit(AuthErrorState(errorText: e.toString()));
          }
    });
  }
}

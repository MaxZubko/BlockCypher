import 'package:block_cypher/firebase_auth/bloc/auth_event.dart';
import 'package:block_cypher/firebase_auth/bloc/auth_state.dart';
import 'package:block_cypher/firebase_auth/data/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc({required this.authRepository}) : super(UnAutthenticated()) {
    on<SignInRequested>((event, emit) async {
      emit(Loading());
      try {
        await authRepository.signIn(
            email: event.email, password: event.password);
        emit(Authenicated());
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(UnAutthenticated());
      }
    });

    on<SignUpRequested>((event, emit) async {
      emit(Loading());
      try {
        await authRepository.signUp(
            email: event.email, password: event.password);
        emit(Authenicated());
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(UnAutthenticated());
      }
    });

    on<SignOutRequested>((event, emit) async {
      emit(Loading());
      await authRepository.signOut();
      emit(UnAutthenticated());
    });
  }
}

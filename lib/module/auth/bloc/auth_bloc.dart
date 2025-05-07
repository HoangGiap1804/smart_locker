import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_locker/models/user.dart';
import 'package:smart_locker/module/auth/bloc/auth_event.dart';
import 'package:smart_locker/module/auth/bloc/auth_state.dart';
import 'package:smart_locker/repositories/user_repository.dart';
import 'package:smart_locker/services/api_service.dart';
import 'package:smart_locker/services/storage_service.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInital()) {
    on<UsernameChanged>((event, emit) {
      String username = event.username;
      if (username.isEmpty) {
        emit(UsernameError(error: "Username does not empty"));
      } else if (username.length < 3) {
        emit(UsernameError(error: "Username is too short"));
      } else {
        emit(UsernameValid());
      }
    });

    on<PasswordChanged>((event, emit) {
      String password = event.password;
      if (password.isEmpty) {
        emit(PasswordError(error: "Password does not empty"));
      } else if (password.length < 3) {
        emit(PasswordError(error: "Password is too short"));
      } else {
        emit(PasswordValid());
      }
    });

    on<LoginSubmitted>((event, emit) async {
      emit(AuthLoading());
      try {
        String username = event.username;
        String password = event.password;

        User user = await UserRepository(
          ApiService(),
        ).signInUser(username, password);

        StorageService().saveUser(user);

        if (user != null) {
          emit(LoginSucces());
        } else {
          emit(LoginError(error: user.toString()));
        }
      } catch (e) {
        emit(LoginError(error: e.toString()));
      }
    });

    on<SignUpSubmitted>((event, emit) async {
      emit(AuthLoading());
      try {
        User signup = User(
          userName: event.userName,
          fullName: event.fullName,
          email: event.email,
          phoneNumber: event.phoneNumber,
          gender: event.gender,
          password: event.password,
          picture: event.picture,
        );

        bool success = await UserRepository(ApiService()).signUpUser(signup);
        if (success) {
          emit(SignUpSucces());
        }
      } catch (e) {
        emit(SignUpError(error: e.toString()));
      }
    });

    on<ForgotPasswordSubmitted>((event, emit) async {
      emit(AuthLoading());
      // try {
      //   String username = event.username;

      //   String res = await AuthenticationRepository().forgotPassword(
      //     username: username,
      //   );

      //   if (res == "success") {
      //     emit(SendEmailSuccess());
      //   } else {
      //     emit(SendEmailFaild(error: res));
      //   }
      // } catch (e) {
      //   emit(SendEmailFaild(error: e.toString()));
      // }
    });
  }
}

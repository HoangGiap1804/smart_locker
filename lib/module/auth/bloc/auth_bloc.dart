import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_locker/module/auth/bloc/auth_event.dart';
import 'package:smart_locker/module/auth/bloc/auth_state.dart';
import 'package:smart_locker/module/auth/repository/authentication_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final _auth = AuthenticationRepository();

  AuthBloc() : super(AuthInital()){

    on<UsernameChanged>((event, emit) {
      String username = event.username;
      if(username.isEmpty){
        emit(UsernameError(error: "Username does not empty"));
      }
      else if(username.length < 3){
        emit(UsernameError(error: "Username is too short"));
      }
      else {
        emit(UsernameValid());
      }
    });

    on<PasswordChanged>((event, emit) {
      String password = event.password;
      if(password.isEmpty){
        emit(PasswordError(error: "Password does not empty"));
      }
      else if(password.length < 3){
        emit(PasswordError(error: "Password is too short"));
      }
      else {
        emit(PasswordValid());
      }
    });

    on<LoginSubmitted>((event, emit) async{
      emit(AuthLoading());
      try {
        String username = event.username;
        String password = event.password;

        String res = await _auth.loginUser(
          userName: username,
          password: password,
        );

        if(res == "success"){
          emit(LoginSucces());
        }
        else{
          emit(LoginError(error: res));
        }
      } catch (e) {
        emit(LoginError(error: e.toString()));
      }
    });

    on<SignUpSubmitted>((event, emit) async{
      emit(AuthLoading());
      try {
        String res = await AuthenticationRepository().signUpUser(
          userName: event.userName,
          fullName: event.fullName,
          email: event.email,
          phoneNumber: event.phoneNumber,
          gender: event.gender,
          password: event.password,
          confirmPassword: event.confirmPassword,
        );

        if(res == "success"){
          emit(SignUpSucces());
        }
        else{
          emit(SignUpError(error: res));
        }
      } catch (e) {
        emit(SignUpError(error: e.toString()));
      }
    });

    on<ForgotPasswordSubmitted>((event, emit) async{
      emit(AuthLoading());
      try {
        String username = event.username;

        String res = await AuthenticationRepository().forgotPassword(
          username: username,
        );

        if(res == "success"){
          emit(SendEmailSuccess());
        }
        else{
          emit(SendEmailFaild(error: res));
        }
      } catch (e) {
        emit(SendEmailFaild(error: e.toString()));
      }
    });
  }
} 

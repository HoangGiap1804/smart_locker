import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_locker/core/app/app_router.dart';
import 'package:smart_locker/models/shared/app_theme.dart';
import 'package:smart_locker/module/auth/bloc/auth_bloc.dart';
import 'package:smart_locker/module/auth/bloc/auth_event.dart';
import 'package:smart_locker/module/auth/bloc/auth_state.dart';
import 'package:smart_locker/module/auth/sign_in/screens/create_account_screen.dart';
import 'package:smart_locker/module/auth/sign_in/screens/forgot_password_screen.dart';
import 'package:smart_locker/module/auth/sign_in/widgets/button.dart';
import 'package:smart_locker/module/auth/sign_in/widgets/button_circle_image.dart';
import 'package:smart_locker/module/auth/sign_in/widgets/forgot_password.dart';
import 'package:smart_locker/module/auth/sign_in/widgets/text_field_input.dart';
import 'package:smart_locker/module/auth/sign_in/widgets/text_field_input_password.dart';
import 'package:smart_locker/module/camera/camera/screens/camera_screen.dart';
import 'package:smart_locker/module/home_page/screens/home_screen.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailEditingController = TextEditingController();

  final TextEditingController passwordEditingController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkIfUserIsLoggedIn();
  }

  // Async method to check if the user is logged in
  void _checkIfUserIsLoggedIn() async {
    // User? user = FirebaseAuth.instance.currentUser;
    // if (user != null) {
    //   // If user is logged in, navigate to HomePage
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     context.router.replace(HomeRoute());
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    AuthBloc authBloc = AuthBloc();
    return BlocProvider(
      create: (context) => authBloc,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: _header(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: _formLogin(context),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: _signUp(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text("Welcome\nBack!", style: AppTheme.textTheme.headlineLarge),
    );
  }

  Widget _formLogin(BuildContext context) {
    return Column(
      children: [
        _input(context),
        ForgotPassword(
          onTap: () {
            // context.router.push(ForgotPasswordRoute());

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error),
                    backgroundColor: Colors.red,
                  ),
                );
              }
              if (state is LoginSucces) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Login success"),
                    backgroundColor: Colors.green,
                  ),
                );
                // context.router.replace(HomeRoute());
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              }
            },
            builder: (context, state) {
              return _button(context, state);
            },
          ),
        ),
      ],
    );
  }

  Widget _input(BuildContext context) {
    return Column(
      children: [
        TextFieldInput(
          textEditingController: emailEditingController,
          hintText: "Username or Email",
          icon: Icons.person,
          onChanged: (value) {
            // context.read<AuthBloc>().add(UsernameChanged(username: value));
          },
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: TextFieldInputPassword(
            textEditingController: passwordEditingController,
            hintText: "Password",
            icon: Icons.lock,
            onChanged: (value) {
              // context.read<AuthBloc>().add(PasswordChanged(password: value));
            },
          ),
        ),
      ],
    );
  }

  Widget _button(BuildContext context, state) {
    return state is AuthLoading
        ? CircularProgressIndicator()
        : Button(
          text: "Login",
          onTab: () {
            FocusScope.of(context).unfocus();
            context.read<AuthBloc>().add(
              LoginSubmitted(
                username: emailEditingController.text.toString(),
                password: passwordEditingController.text.toString(),
              ),
            );
          },
        );
  }

  Widget _loginOther() {
    return Column(
      children: [
        Center(
          child: Text(
            "- OR Continue with -",
            style: AppTheme.textfield.bodyLarge,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonCircleImage(
              onTab: () {},
              pathIcon: "assets/images/google_icon.png",
            ),
            ButtonCircleImage(
              onTab: () {},
              pathIcon: "assets/images/apple_icon.png",
            ),
            ButtonCircleImage(
              onTab: () {},
              pathIcon: "assets/images/facebook_icon.png",
            ),
          ],
        ),
      ],
    );
  }

  Widget _signUp(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Create An Account ", style: AppTheme.textfield.bodyLarge),
        GestureDetector(
          onTap: () {
            // context.router.push(CreateAccountRoute());

            Navigator.push(
              context,
              // MaterialPageRoute(builder: (context) => CreateAccountScreen()),
              MaterialPageRoute(builder: (context) => CameraScreen()),
            );
          },
          child: Text("Sign Up", style: AppTheme.textInk.bodyLarge),
        ),
      ],
    );
  }
}

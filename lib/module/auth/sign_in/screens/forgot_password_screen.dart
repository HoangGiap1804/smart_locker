import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_locker/models/shared/app_theme.dart';
import 'package:smart_locker/module/auth/bloc/auth_bloc.dart';
import 'package:smart_locker/module/auth/bloc/auth_event.dart';
import 'package:smart_locker/module/auth/bloc/auth_state.dart';
import 'package:smart_locker/module/auth/sign_in/widgets/button.dart';
import 'package:smart_locker/module/auth/sign_in/widgets/text_field_input.dart';

@RoutePage()
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailEditingController = TextEditingController();

  AuthBloc authBloc = AuthBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => authBloc,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 30),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: _header(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: _form(),
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
      child: Text("Forgot\npassword!", style: AppTheme.textTheme.headlineLarge),
    );
  }

  Widget _form() {
    return Column(
      children: [
        TextFieldInput(
          textEditingController: emailEditingController,
          hintText: "Enter your email address",
          icon: Icons.email,
          onChanged: (value) {},
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "We will send you a message to set or reset your new password",
              style: AppTheme.textfield.bodyLarge,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              (state is AuthError)
                  ? ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.error),
                      backgroundColor: Colors.red,
                    ),
                  )
                  : null;
              (state is SendEmailSuccess)
                  ? ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("We sent to your email"),
                      backgroundColor: Colors.green,
                    ),
                  )
                  : null;
            },
            builder: (context, state) {
              return state is AuthLoading
                  ? CircularProgressIndicator()
                  : Button(
                    text: "Send",
                    onTab: () {
                      FocusScope.of(context).unfocus();
                      context.read<AuthBloc>().add(
                        ForgotPasswordSubmitted(
                          username: emailEditingController.text.toString(),
                        ),
                      );
                    },
                  );
            },
          ),
        ),
      ],
    );
  }
}

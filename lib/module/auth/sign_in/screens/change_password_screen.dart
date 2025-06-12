import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_locker/models/shared/app_theme.dart';
import 'package:smart_locker/module/auth/bloc/auth_bloc.dart';
import 'package:smart_locker/module/auth/bloc/auth_event.dart';
import 'package:smart_locker/module/auth/bloc/auth_state.dart';
import 'package:smart_locker/module/auth/sign_in/widgets/button.dart';
import 'package:smart_locker/module/auth/sign_in/widgets/text_field_input.dart';
import 'package:smart_locker/module/auth/sign_in/widgets/text_field_input_password.dart';
import 'package:smart_locker/module/home_page/widgets/notification_message.dart';
import 'package:smart_locker/repositories/user_repository.dart';
import 'package:smart_locker/services/api_service.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController oldPassword = TextEditingController();
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController newConfirmedPassword = TextEditingController();

  bool isLoading = false;

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
      child: Text("Change\nPassword!", style: AppTheme.textTheme.headlineLarge),
    );
  }

  Widget _form() {
    return Column(
      children: [
        TextFieldInputPassword(
          textEditingController: oldPassword,
          hintText: "Old password",
          icon: Icons.lock,
          onChanged: (value) {
            // context.read<AuthBloc>().add(PasswordChanged(password: value));
          },
        ),
        SizedBox(height: 20),
        TextFieldInputPassword(
          textEditingController: newPassword,
          hintText: "New password",
          icon: Icons.lock,
          onChanged: (value) {
            // context.read<AuthBloc>().add(PasswordChanged(password: value));
          },
        ),
        SizedBox(height: 20),
        TextFieldInputPassword(
          textEditingController: newConfirmedPassword,
          hintText: "Confirm new password",
          icon: Icons.lock,
          onChanged: (value) {
            // context.read<AuthBloc>().add(PasswordChanged(password: value));
          },
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child:
              isLoading
                  ? CircularProgressIndicator()
                  : Button(
                    text: "Change",
                    onTab: () async {
                      if (newConfirmedPassword.text != newPassword.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Confirm new password does not match.",
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      setState(() {
                        isLoading = true;
                      });

                      bool set = await UserRepository(
                        ApiService(),
                      ).changePassword(oldPassword.text, newPassword.text);

                      if (set) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Change password successful"),
                            backgroundColor: Colors.green,
                          ),
                        );
                        Future.delayed(Duration(milliseconds: 2000), () {
                          Navigator.pop(context);
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Change password fail"),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }

                      setState(() {
                        isLoading = false;
                      });
                    },
                  ),
        ),
      ],
    );
  }
}

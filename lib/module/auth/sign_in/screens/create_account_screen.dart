import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_locker/models/shared/app_theme.dart';
import 'package:smart_locker/module/auth/bloc/auth_bloc.dart';
import 'package:smart_locker/module/auth/bloc/auth_event.dart';
import 'package:smart_locker/module/auth/bloc/auth_state.dart';
import 'package:smart_locker/module/auth/sign_in/screens/login_screen.dart';
import 'package:smart_locker/module/auth/sign_in/widgets/button.dart';
import 'package:smart_locker/module/auth/sign_in/widgets/gender_dropdown.dart';
import 'package:smart_locker/module/auth/sign_in/widgets/text_field_input.dart';
import 'package:smart_locker/module/auth/sign_in/widgets/text_field_input_password.dart';

// @RoutePage()
class CreateAccountScreen extends StatefulWidget {
  final XFile picture;
  const CreateAccountScreen({super.key, required this.picture});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  // final TextEditingController _email = TextEditingController(
  //   text: "hgiap89@gmail.com",
  // );
  // final TextEditingController _userName = TextEditingController(text: "user");
  // final TextEditingController _fullName = TextEditingController(
  //   text: "nguyen giap",
  // );
  // final TextEditingController _phoneNumber = TextEditingController(
  //   text: "0129876543",
  // );
  // final TextEditingController _password = TextEditingController(text: "123456");
  // final TextEditingController _confirmPassword = TextEditingController(
  //   text: "123456",
  // );
  // String? _selectGender = "male";

  final TextEditingController _email = TextEditingController();
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  String? _selectGender = "male";

  @override
  Widget build(BuildContext context) {
    AuthBloc authBloc = AuthBloc();
    return BlocProvider(
      create: (context) => authBloc,
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: _header(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: _formSignUp(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: _login(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        "Create an\npassword?",
        style: AppTheme.textTheme.headlineLarge,
      ),
    );
  }

  Widget _formSignUp() {
    return Column(
      children: [
        _inputForm(),
        Padding(
          padding: const EdgeInsets.only(top: 25),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "By clicking the Register button, you agree to the public offer",
              style: AppTheme.textfield.bodyLarge,
            ),
          ),
        ),
        Padding(padding: const EdgeInsets.only(top: 25), child: _buttonForm()),
      ],
    );
  }

  Widget _inputForm() {
    return Column(
      children: [
        TextFieldInput(
          textEditingController: _userName,
          hintText: "Username",
          icon: Icons.person,
          onChanged: (value) {
            // context.read<AuthBloc>().add(UsernameChanged(username: value));
          },
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: TextFieldInput(
            textEditingController: _email,
            hintText: "Email",
            icon: Icons.email,
            onChanged: (value) {
              // context.read<AuthBloc>().add(UsernameChanged(username: value));
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: TextFieldInput(
            textEditingController: _fullName,
            hintText: "Full name ",
            icon: Icons.person,
            onChanged: (value) {
              // context.read<AuthBloc>().add(UsernameChanged(username: value));
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: TextFieldInput(
            textEditingController: _phoneNumber,
            hintText: "Phone number",
            icon: Icons.phone,
            onChanged: (value) {
              // context.read<AuthBloc>().add(UsernameChanged(username: value));
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: GenderDropdown(
            selectedValue: _selectGender,
            items: ["male", "female"],
            hintText: "Gender",
            icon: Icons.person,
            onChanged: (value) {
              setState(() {
                _selectGender = value;
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: TextFieldInputPassword(
            textEditingController: _password,
            hintText: "Password",
            icon: Icons.lock,
            onChanged: (value) {
              // context.read<AuthBloc>().add(PasswordChanged(password: value));
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: TextFieldInputPassword(
            textEditingController: _confirmPassword,
            hintText: "ConfirmPassword",
            icon: Icons.lock,
            onChanged: (value) {
              // context.read<AuthBloc>().add(PasswordChanged(password: value));
            },
          ),
        ),
      ],
    );
  }

  Widget _buttonForm() {
    return Column(
      children: [
        BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
        (state is AuthError)
          ? ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.red,
            ),
          )
          : null;
        (state is SignUpSucces)
          ? {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          ),
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Sign up successful"),
              backgroundColor: Colors.green,
            ),
          ),
        }
          : null;
        },
        builder: (context, state) {
          return state is AuthLoading
            ? CircularProgressIndicator()
            : Button(
              text: "Create Account",
              onTab: () {
                FocusScope.of(context).unfocus();
                context.read<AuthBloc>().add(
                  SignUpSubmitted(
                    userName: _userName.text,
                    fullName: _fullName.text,
                    email: _email.text,
                    phoneNumber: _phoneNumber.text,
                    gender: _selectGender ?? "Female",
                    password: _password.text,
                    confirmPassword: _confirmPassword.text,
                    picture: widget.picture,
                  ),
                );
              },
            );
        },
      ),
      ],
    );
  }

  Widget _login(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "I Already Have an Account",
              style: AppTheme.textfield.bodyLarge,
            ),
            GestureDetector(
              onTap: () {
                // context.router.back();
                Navigator.pop(context);
              },
              child: Text(" Login", style: AppTheme.textInk.bodyLarge),
            ),
          ],
        ),
      ],
    );
  }
}

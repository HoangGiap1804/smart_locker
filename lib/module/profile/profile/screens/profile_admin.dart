import 'package:smart_locker/models/shared/app_theme.dart';
import 'package:smart_locker/models/user.dart';
import 'package:smart_locker/module/auth/sign_in/screens/change_password_screen.dart';
import 'package:smart_locker/module/auth/sign_in/screens/login_screen.dart';
import 'package:smart_locker/module/profile/bloc/profile_bloc.dart';
import 'package:smart_locker/module/profile/bloc/profile_event.dart';
import 'package:smart_locker/module/profile/bloc/profile_state.dart';
import 'package:smart_locker/module/profile/models/profile_model.dart';
import 'package:smart_locker/module/profile/profile/widgets/change_password.dart';
import 'package:smart_locker/module/profile/profile/widgets/profile_button.dart';
import 'package:smart_locker/module/profile/profile/widgets/profile_image_button.dart';
import 'package:smart_locker/module/profile/profile/widgets/profile_textfield_input.dart';
import 'package:smart_locker/module/profile/profile/widgets/profile_textfield_password_input.dart';
import 'package:smart_locker/module/profile/profile/widgets/proflie_avata.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_locker/services/storage_service.dart';

class ProfileAdmin extends StatefulWidget {
  const ProfileAdmin({super.key});

  @override
  State<ProfileAdmin> createState() => _ProfileAdminState();
}

class _ProfileAdminState extends State<ProfileAdmin> {
  final TextEditingController email = TextEditingController();
  final TextEditingController userName = TextEditingController();
  final TextEditingController fullName = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController gender = TextEditingController();

  bool _isLoading = true;
  ProfileBloc profileBloc = ProfileBloc();

  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() async {
    User user = await StorageService().getUser();
    setState(() {
      email.text = user.email;
      userName.text = user.userName;
      fullName.text = user.fullName;
      phoneNumber.text = user.phoneNumber;
      gender.text = user.gender;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Profile Admin", style: AppTheme.textTheme.headlineMedium),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            (_isLoading)
                ? Center(child: CircularProgressIndicator())
                : _bodySection(context),
          ],
        ),
      ),
    );
  }

  Widget _bodySection(BuildContext context) {
    return BlocProvider(
      create: (context) => profileBloc,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              child: Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  ProflieAvata(pathIcon: "assets/images/avata.png"),
                  ProfileImageButton(
                    pathIcon: "assets/images/avata_icon.jpg",
                    onTab: () {},
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            Text("Personal Detail", style: AppTheme.textTheme.headlineSmall),
            SizedBox(height: 25),
            ProfileTextfieldInput(
              header: "Email address",
              hintText: "Email address",
              textEditingController: email,
            ),
            SizedBox(height: 15),
            ProfileTextfieldInput(
              header: "User name",
              hintText: "User name",
              textEditingController: userName,
            ),
            // SizedBox(height: 25),
            // ProfileTextfieldPasswordInput(textEditingController: password),
            SizedBox(height: 15),
            ChangePassword(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangePasswordScreen(),
                  ),
                );
              },
            ),
            SizedBox(height: 15),
            ProfileButton(
              onTab: () {
                // AuthenticationRepository().signOut();
                // context.router.replace(LoginRoute());

                StorageService().clearStorage();
                StorageService().saveTokens("", "");
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (Route<dynamic> route) => false,
                );
              },
              text: "Logout",
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

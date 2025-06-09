import 'package:smart_locker/models/shared/app_theme.dart';
import 'package:smart_locker/models/user.dart';
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

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: EdgeInsets.all(10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color(0xFFf2f2f2),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Icon(Icons.backspace_sharp),
          ),
        ),
        title: Text("Profile", style: AppTheme.textTheme.headlineMedium),
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
            // SizedBox(height: 25),
            // ProfileTextfieldPasswordInput(textEditingController: password),
            SizedBox(height: 15),
            ChangePassword(onTap: () {}),
            SizedBox(height: 25),
            Divider(color: Colors.grey, thickness: 1),
            SizedBox(height: 28),
            Text("Address detail", style: AppTheme.textTheme.headlineSmall),
            SizedBox(height: 25),
            ProfileTextfieldInput(
              header: "User name",
              hintText: "User name",
              textEditingController: userName,
            ),
            SizedBox(height: 25),
            ProfileTextfieldInput(
              header: "Full name",
              hintText: "Full name",
              textEditingController: fullName,
            ),
            SizedBox(height: 25),
            ProfileTextfieldInput(
              header: "Phone number",
              hintText: "Phone number",
              textEditingController: phoneNumber,
            ),
            SizedBox(height: 25),
            ProfileTextfieldInput(
              header: "Gender",
              hintText: "Gender",
              textEditingController: gender,
            ),
            SizedBox(height: 50),

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

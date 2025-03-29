import 'package:auto_route/auto_route.dart';
import 'package:smart_locker/core/app/app_router.dart';
import 'package:smart_locker/models/shared/app_theme.dart';
import 'package:smart_locker/module/auth/repository/authentication_repository.dart';
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
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  final TextEditingController pincode = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController state = TextEditingController();
  final TextEditingController country = TextEditingController();

  final TextEditingController bankAccountNumber = TextEditingController();
  final TextEditingController accountHolderName = TextEditingController();
  final TextEditingController ifscCode = TextEditingController();

  ProfileModel _profileModel = ProfileModel.empty();
  bool _isLoading = true;
  ProfileBloc profileBloc = ProfileBloc();

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    try {
      String? uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) {
        // ProfileModel profile = await ProfileRepository().getUserInfo(uid);
        setState(() {
          //_profileModel = profile;
          // if(profile.username != "") _isLoading = false;
          _isLoading = false;
          return;

          // email.text = profile.username;
          // password.text = profile.password;
          // pincode.text = profile.pincode;
          // address.text = profile.address;
          // city.text = profile.city;
          // state.text = profile.state;
          // country.text = profile.country;
          // bankAccountNumber.text = profile.bankAccountNumber;
          // accountHolderName.text = profile.accountHolderName;
          // ifscCode.text = profile.ifscCode;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = true;
      });
    }
  }

  void get() {
    setState(() {
      _profileModel.username = email.text;
      _profileModel.pincode = pincode.text;
      _profileModel.address = address.text;
      _profileModel.city = city.text;
      _profileModel.state = state.text;
      _profileModel.country = country.text;
      _profileModel.bankAccountNumber = bankAccountNumber.text;
      _profileModel.accountHolderName = accountHolderName.text;
      _profileModel.ifscCode = ifscCode.text;
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
            context.router.back();
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
      body:
          (_isLoading)
              ? Center(child: CircularProgressIndicator())
              : _bodySection(context),
    );
  }

  Widget _bodySection(BuildContext context) {
    return BlocProvider(
      create: (context) => profileBloc,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35),
        child: ListView(
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
            SizedBox(height: 25),
            ProfileTextfieldPasswordInput(textEditingController: password),
            SizedBox(height: 15),
            ChangePassword(onTap: () {}),
            SizedBox(height: 25),
            Divider(color: Colors.grey, thickness: 1),
            SizedBox(height: 28),
            Text("Address detail", style: AppTheme.textTheme.headlineSmall),
            SizedBox(height: 25),
            ProfileTextfieldInput(
              header: "Address",
              hintText: "Address",
              textEditingController: address,
            ),
            SizedBox(height: 25),
            ProfileTextfieldInput(
              header: "City",
              hintText: "City",
              textEditingController: city,
            ),
            SizedBox(height: 25),
            ProfileTextfieldInput(
              header: "Country",
              hintText: "Country",
              textEditingController: country,
            ),
            SizedBox(height: 40),
            BlocConsumer<ProfileBloc, ProfileState>(
              listener: (context, state) {
                (state is SubmissionFaild)
                    ? ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.error),
                        backgroundColor: Colors.red,
                      ),
                    )
                    : null;
                (state is SubmissionSuccess)
                    ? ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Update success"),
                        backgroundColor: Colors.green,
                      ),
                    )
                    : null;
              },
              builder: (context, state) {
                return (state is ProfileLoading)
                    ? Center(child: CircularProgressIndicator())
                    : ProfileButton(
                      onTab: () {
                        get();
                        context.read<ProfileBloc>().add(
                          UpdateInfo(profileModel: _profileModel),
                        );
                      },
                      text: "Save",
                    );
              },
            ),
            SizedBox(height: 60),
            ProfileButton(
              onTab: () {
                AuthenticationRepository().signOut();
                context.router.replace(LoginRoute());
              },
              text: "Logout",
            ),
            SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}

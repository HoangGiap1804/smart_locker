import 'package:auto_route/auto_route.dart';
import 'package:smart_locker/module/auth/sign_in/screens/create_account_screen.dart';
import 'package:smart_locker/module/auth/sign_in/screens/forgot_password_screen.dart';
import 'package:smart_locker/module/auth/sign_in/screens/login_screen.dart';
import 'package:smart_locker/module/home_page/screens/home_screen.dart';
import 'package:smart_locker/module/profile/profile/screens/profile_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: HomeRoute.page),

    AutoRoute(page: LoginRoute.page, initial: true),
    AutoRoute(page: ProfileRoute.page),
    AutoRoute(page: CreateAccountRoute.page),
    AutoRoute(page: ForgotPasswordRoute.page),
  ];
}

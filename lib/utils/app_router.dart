import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gutterapp/business_logic/dashboard/customers_cubit.dart';
import 'package:gutterapp/business_logic/login/companies_cubit.dart';
import 'package:gutterapp/business_logic/login/login_cubit.dart';
import 'package:gutterapp/business_logic/login/profile_cubit.dart';
import 'package:gutterapp/presentation/screen/screen_dashboard.dart';
import 'package:gutterapp/presentation/screen/screen_launcher.dart';
import 'package:gutterapp/presentation/screen/screen_login.dart';

class AppRouter {
  static const String HOME = "/";
  static const String LOGIN = "/login";
  static const String DASHBOARD = "/dashboard";

  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HOME:
        return MaterialPageRoute(builder: (_) => LauncherScreen());
      case LOGIN:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => LoginCubit()),
              BlocProvider(create: (context) => ProfileCubit()),
              BlocProvider(create: (context) => CompaniesCubit()),
            ],
            child: LoginScreen(),
          ),
        );
      case DASHBOARD:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => CustomersCubit()),
            ],
            child: DashboardScreen(),
          ),
        );
      default:
        return MaterialPageRoute(builder: (_) => LauncherScreen());
    }
  }
}

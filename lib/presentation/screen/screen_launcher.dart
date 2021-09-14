import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gutterapp/business_logic/theme/theme_cubit.dart';
import 'package:gutterapp/business_logic/user/user_cubit.dart';
import 'package:gutterapp/utils/app_router.dart';
import 'package:gutterapp/utils/theme_helper.dart';

class LauncherScreen extends StatefulWidget {
  const LauncherScreen({Key? key}) : super(key: key);

  @override
  _LauncherScreenState createState() => _LauncherScreenState();
}

class _LauncherScreenState extends State<LauncherScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 1), () {
      final UserState state = BlocProvider.of<UserCubit>(context, listen: false).state;
      if (state.token != null &&
          state.expiresIn != null &&
          state.user != null &&
          (state.user?.isAuthenticated ?? false) &&
          (state.expiresIn! > DateTime.now().millisecondsSinceEpoch)) {
        Navigator.of(context).pushReplacementNamed(AppRouter.DASHBOARD);
      } else {
        Navigator.of(context).pushReplacementNamed(AppRouter.LOGIN);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        final theme = ThemeHelper(state.value);
        return Scaffold(
          backgroundColor: theme.backgroundColor,
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

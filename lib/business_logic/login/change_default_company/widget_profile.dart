import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gutterapp/business_logic/login/profile_cubit.dart';
import 'package:gutterapp/business_logic/theme/theme_cubit.dart';
import 'package:gutterapp/business_logic/user/user_cubit.dart';
import 'package:gutterapp/data/model/user.dart';
import 'package:gutterapp/presentation/widget/button_networking_indicator.dart';
import 'package:gutterapp/utils/app_router.dart';
import 'package:gutterapp/utils/text_styles.dart';
import 'package:gutterapp/utils/theme_helper.dart';

class ChangeDefaultCompanyProfileButton extends StatelessWidget {
  final String companyGuid;

  ChangeDefaultCompanyProfileButton(this.companyGuid);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        final theme = ThemeHelper(state.value);
        return BlocConsumer<ProfileCubit, ProfileState>(
          listener: (_, state) {
            if (state is ProfileSuccess) {
              final User user = state.data;
              BlocProvider.of<UserCubit>(context).saveProfileInformation(user);
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed(AppRouter.DASHBOARD);
            }
          },
          builder: (_, state) {
            if (state is ProfileError) {
              return ElevatedButton(
                onPressed: () {
                  final UserState userState = BlocProvider.of<UserCubit>(context).state;
                  final User user = userState.user!;
                  BlocProvider.of<ProfileCubit>(context).profile(userState.token!, user.username);
                },
                child: Text("Try again".toUpperCase(), style: TextStyles.title(context: context, color: theme.backgroundColor)),
              );
            } else if (state is ProfileNetworking) {
              return ElevatedButton(
                onPressed: () {},
                child: Container(
                  width: 144,
                  child: Center(child: ButtonNetworkingIndicator(color: theme.accentColor.shade200, dimension: 20)),
                ),
              );
            } else if (state is ProfileSuccess) {
              return ElevatedButton(
                onPressed: () {},
                child: Container(
                  width: 144,
                  child: Center(child: Icon(Icons.done_outline_rounded, color: theme.backgroundColor)),
                ),
              );
            } else {
              return ElevatedButton(
                onPressed: () {
                  final UserState userState = BlocProvider.of<UserCubit>(context).state;
                  final User user = userState.user!;
                  BlocProvider.of<ProfileCubit>(context).profile(userState.token!, user.username);
                },
                child: Text("Fetch profile".toUpperCase(), style: TextStyles.title(context: context, color: theme.backgroundColor)),
              );
            }
          },
        );
      },
    );
  }
}

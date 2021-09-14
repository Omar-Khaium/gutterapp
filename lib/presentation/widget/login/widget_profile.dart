import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gutterapp/business_logic/login/companies_cubit.dart';
import 'package:gutterapp/business_logic/login/profile_cubit.dart';
import 'package:gutterapp/business_logic/theme/theme_cubit.dart';
import 'package:gutterapp/business_logic/user/user_cubit.dart';
import 'package:gutterapp/data/model/user.dart';
import 'package:gutterapp/presentation/widget/button_networking_indicator.dart';
import 'package:gutterapp/presentation/widget/login/widget_companies.dart';
import 'package:gutterapp/utils/text_styles.dart';
import 'package:gutterapp/utils/theme_helper.dart';

class LoginProfileWidget extends StatelessWidget {
  final String token;
  final String username;
  final String password;
  final bool isRemembered;

  LoginProfileWidget(this.token, this.username, this.password, this.isRemembered);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        final theme = ThemeHelper(state.value);
        return BlocConsumer<ProfileCubit, ProfileState>(
          listener: (_, state) {
            if (state is ProfileSuccess) {
              final User user = state.data;
              user.password = password;
              user.isRemembered = isRemembered;
              BlocProvider.of<UserCubit>(context).saveProfileInformation(user);
              BlocProvider.of<CompaniesCubit>(context).find(token);
            }
          },
          builder: (_, state) {
            if (state is ProfileError) {
              return ElevatedButton(
                onPressed: () {
                  BlocProvider.of<ProfileCubit>(context).profile(token, username);
                },
                child: Text("Try again".toUpperCase(), style: TextStyles.title(context: context, color: theme.backgroundColor)),
              );
            } else if (state is ProfileNetworking) {
              return ElevatedButton(
                onPressed: () {},
                child: Center(child: ButtonNetworkingIndicator(color: theme.accentColor.shade200, dimension: 20)),
              );
            } else if (state is ProfileSuccess) {
              return LoginCompaniesWidget(token, username);
            } else {
              return ElevatedButton(
                onPressed: () {
                  BlocProvider.of<ProfileCubit>(context).profile(token, username);
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

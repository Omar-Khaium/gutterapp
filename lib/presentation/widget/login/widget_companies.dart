import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gutterapp/business_logic/login/change_default_company_cubit.dart';
import 'package:gutterapp/business_logic/login/companies_cubit.dart';
import 'package:gutterapp/business_logic/login/profile_cubit.dart';
import 'package:gutterapp/business_logic/theme/theme_cubit.dart';
import 'package:gutterapp/presentation/widget/button_networking_indicator.dart';
import 'package:gutterapp/presentation/widget/login/dialog_change_default_company.dart';
import 'package:gutterapp/utils/app_router.dart';
import 'package:gutterapp/utils/text_styles.dart';
import 'package:gutterapp/utils/theme_helper.dart';

class LoginCompaniesWidget extends StatelessWidget {
  final String token;
  final String username;

  LoginCompaniesWidget(this.token, this.username);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        final theme = ThemeHelper(state.value);
        return BlocConsumer<CompaniesCubit, CompaniesState>(
          listener: (_, state) {
            if (state is CompaniesSuccess) {
              if (state.data.isEmpty || state.data.length == 1) {
                Navigator.of(context).pushReplacementNamed(AppRouter.DASHBOARD);
              } else {
                showDialog(
                  context: context,
                  builder: (_) => MultiBlocProvider(
                    providers: [
                      BlocProvider(create: (context) => ChangeDefaultCompanyCubit()),
                      BlocProvider(create: (context) => ProfileCubit()),
                    ],
                    child: ChangeDefaultCompanyDialog(token: token, username: username, companies: state.data),
                  ),
                  barrierDismissible: false,
                );
              }
            }
          },
          builder: (_, state) {
            if (state is CompaniesError) {
              return ElevatedButton(
                onPressed: () {
                  BlocProvider.of<CompaniesCubit>(context).find(token);
                },
                child: Text("Try again".toUpperCase(), style: TextStyles.title(context: context, color: theme.backgroundColor)),
              );
            } else if (state is CompaniesNetworking) {
              return ElevatedButton(
                onPressed: () {},
                child: Center(child: ButtonNetworkingIndicator(color: theme.accentColor.shade400, dimension: 20)),
              );
            } else if (state is CompaniesSuccess) {
              return ElevatedButton(
                onPressed: () {},
                child: Center(child: Icon(Icons.done_outline_rounded, color: theme.backgroundColor)),
              );
            } else {
              return ElevatedButton(
                onPressed: () {
                  BlocProvider.of<CompaniesCubit>(context).find(token);
                },
                child: Text("Fetch companies".toUpperCase(), style: TextStyles.title(context: context, color: theme.backgroundColor)),
              );
            }
          },
        );
      },
    );
  }
}

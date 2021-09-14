import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gutterapp/business_logic/login/change_default_company/widget_profile.dart';
import 'package:gutterapp/business_logic/login/change_default_company_cubit.dart';
import 'package:gutterapp/business_logic/login/profile_cubit.dart';
import 'package:gutterapp/business_logic/theme/theme_cubit.dart';
import 'package:gutterapp/business_logic/user/user_cubit.dart';
import 'package:gutterapp/data/model/company.dart';
import 'package:gutterapp/presentation/widget/button_networking_indicator.dart';
import 'package:gutterapp/utils/app_router.dart';
import 'package:gutterapp/utils/text_styles.dart';
import 'package:gutterapp/utils/theme_helper.dart';

class ChangeDefaultCompanyDialog extends StatefulWidget {
  final String token;
  final String username;
  final List<Company> companies;

  const ChangeDefaultCompanyDialog({
    required this.token,
    required this.username,
    required this.companies,
  });

  @override
  _ChangeDefaultCompanyDialogState createState() => _ChangeDefaultCompanyDialogState();
}

class _ChangeDefaultCompanyDialogState extends State<ChangeDefaultCompanyDialog> {
  String selection = "";

  @override
  void initState() {
    widget.companies.forEach((element) {
      if (element.selected) {
        selection = element.value;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          final theme = ThemeHelper(state.value);
          return AlertDialog(
            backgroundColor: theme.backgroundColor,
            title: Text("Change default company", style: TextStyles.title(context: context, color: theme.accentColor)),
            content: Container(
              constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width * .5,
                maxWidth: MediaQuery.of(context).size.width * .5,
                minHeight: 0,
                maxHeight: MediaQuery.of(context).size.height * .5,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: widget.companies
                      .map(
                        (company) => ListTile(
                          selected: selection == company.value,
                          tileColor: Colors.transparent,
                          selectedTileColor: theme.secondaryColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          title: Text(
                            company.text,
                            style:
                                TextStyles.subTitle(context: context, color: selection == company.value ? theme.accentColor : theme.textColor),
                          ),
                          trailing: selection == company.value ? Icon(Icons.verified_rounded, color: theme.accentColor, size: 32) : null,
                          onTap: () {
                            setState(() {
                              selection = company.value;
                            });
                          },
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            actionsPadding: EdgeInsets.all(16),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacementNamed(AppRouter.DASHBOARD);
                },
                child: Text("Skip", style: TextStyles.title(context: context, color: theme.accentColor)),
              ),
              Visibility(visible: selection.isNotEmpty, child: SizedBox(width: 8)),
              Visibility(
                visible: selection.isNotEmpty,
                child: BlocConsumer<ChangeDefaultCompanyCubit, ChangeDefaultCompanyState>(
                  listener: (_, state) {
                    final UserState userState = BlocProvider.of<UserCubit>(context).state;
                    BlocProvider.of<ProfileCubit>(context).profile(userState.token!, userState.user!.username);
                  },
                  builder: (_, state) {
                    if (state is ChangeDefaultCompanyError) {
                      return ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<ChangeDefaultCompanyCubit>(context).change(widget.token, selection);
                        },
                        child: Text("Try again".toUpperCase(), style: TextStyles.title(context: context, color: theme.backgroundColor)),
                      );
                    } else if (state is ChangeDefaultCompanyNetworking) {
                      return ElevatedButton(
                        onPressed: () {},
                        child: Container(
                          width: 144,
                          child: Center(child: ButtonNetworkingIndicator(color: theme.backgroundColor, dimension: 20)),
                        ),
                      );
                    } else if (state is ChangeDefaultCompanySuccess) {
                      return ChangeDefaultCompanyProfileButton(selection);
                    } else {
                      return ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<ChangeDefaultCompanyCubit>(context).change(widget.token, selection);
                        },
                        child: Text("Set as default", style: TextStyles.title(context: context, color: theme.backgroundColor)),
                      );
                    }
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

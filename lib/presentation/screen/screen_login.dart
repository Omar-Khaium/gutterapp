import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gutterapp/business_logic/login/login_cubit.dart';
import 'package:gutterapp/business_logic/login/profile_cubit.dart';
import 'package:gutterapp/business_logic/theme/theme_cubit.dart';
import 'package:gutterapp/business_logic/user/user_cubit.dart';
import 'package:gutterapp/data/model/user.dart';
import 'package:gutterapp/presentation/widget/button_networking_indicator.dart';
import 'package:gutterapp/presentation/widget/login/widget_profile.dart';
import 'package:gutterapp/utils/app_snack_bar.dart';
import 'package:gutterapp/utils/text_styles.dart';
import 'package:gutterapp/utils/theme_helper.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController(text: "administrator");
  final TextEditingController passwordController = TextEditingController(text: "RMRCloudTheNO1CM\$");
  bool isRemembered = false;
  bool isObscureText = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 1), () {
      final UserState state = BlocProvider.of<UserCubit>(context, listen: false).state;
      if (state.user != null && (state.user?.isRemembered ?? false)) {
        final User user = state.user!;
        usernameController.text = user.email;
        passwordController.text = user.password;
        isRemembered = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        final theme = ThemeHelper(state.value);
        return Scaffold(
          backgroundColor: theme.accentColor.shade50,
          body: Center(
            child: Container(
              constraints: BoxConstraints(
                minWidth: 0,
                maxWidth: MediaQuery.of(context).size.width * .5,
                minHeight: 0,
                maxHeight: MediaQuery.of(context).size.height * .5,
              ),
              child: PhysicalModel(
                color: theme.backgroundColor,
                shadowColor: theme.backgroundColor,
                elevation: 4,
                borderRadius: BorderRadius.circular(16),
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: usernameController,
                          obscureText: false,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          autocorrect: false,
                          autofocus: false,
                          keyboardType: TextInputType.emailAddress,
                          maxLines: 1,
                          validator: (val) {
                            return (val ?? "").isNotEmpty ? null : "* required";
                          },
                          style: TextStyles.body(context: context, color: theme.textColor),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.mail_outline),
                            hintText: "e.g. example@mail.com",
                          ),
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: passwordController,
                          obscureText: isObscureText,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          autocorrect: false,
                          autofocus: false,
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                          validator: (val) {
                            return (val ?? "").isNotEmpty ? null : "* Required";
                          },
                          style: TextStyles.body(context: context, color: theme.textColor),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock_outline),
                            hintText: "e.g. ******",
                            suffixIcon: IconButton(
                              icon: isObscureText ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  isObscureText = !isObscureText;
                                });
                              },
                              iconSize: 24,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        CheckboxListTile(
                          value: isRemembered,
                          title: Text("Remember me", style: TextStyles.body(context: context, color: theme.accentColor)),
                          controlAffinity: ListTileControlAffinity.trailing,
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                          onChanged: (value) {
                            setState(() {
                              isRemembered = value ?? false;
                            });
                          },
                        ),
                        SizedBox(height: 16),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: BlocConsumer<LoginCubit, LoginState>(
                            listener: (_, state) {
                              if (state is LoginError) {
                                ScaffoldMessenger.of(context).showSnackBar(AppSnackBar.getErrorSnackBar(context, state.error));
                              } else if (state is LoginSuccess) {
                                BlocProvider.of<UserCubit>(context, listen: false).saveLoginInformation(state.token, state.expiresIn);
                                BlocProvider.of<ProfileCubit>(context).profile(state.token, usernameController.text);
                              }
                            },
                            builder: (_, state) {
                              if (state is LoginError) {
                                return ElevatedButton(
                                  onPressed: () {
                                    FocusScope.of(context).requestFocus(FocusNode());
                                    if (_formKey.currentState?.validate() ?? false) {
                                      BlocProvider.of<LoginCubit>(context).login(usernameController.text, passwordController.text);
                                    }
                                  },
                                  child:
                                      Text("Try again".toUpperCase(), style: TextStyles.title(context: context, color: theme.backgroundColor)),
                                );
                              } else if (state is LoginNetworking) {
                                return ElevatedButton(
                                  onPressed: () {},
                                  child: Center(child: ButtonNetworkingIndicator(color: theme.backgroundColor, dimension: 20)),
                                );
                              } else if (state is LoginSuccess) {
                                return LoginProfileWidget(state.token, usernameController.text, passwordController.text, isRemembered);
                              } else {
                                return ElevatedButton(
                                  onPressed: () {
                                    FocusScope.of(context).requestFocus(FocusNode());
                                    if (_formKey.currentState?.validate() ?? false) {
                                      BlocProvider.of<LoginCubit>(context).login(usernameController.text, passwordController.text);
                                    }
                                  },
                                  child: Text("Login".toUpperCase(), style: TextStyles.title(context: context, color: theme.backgroundColor)),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

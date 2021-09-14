import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gutterapp/business_logic/user/user_cubit.dart';
import 'package:gutterapp/presentation/screen/screen_launcher.dart';
import 'package:gutterapp/utils/text_styles.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'business_logic/theme/theme_cubit.dart';
import 'utils/app_router.dart';
import 'utils/theme_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(storageDirectory: await getApplicationDocumentsDirectory());
  final AppRouter router = AppRouter();
  runApp(MultiProvider(
    child: MyApp(router),
    providers: [
      BlocProvider(create: (_) => ThemeCubit()),
      BlocProvider(create: (_) => UserCubit()),
    ],
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter router;

  MyApp(this.router);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        final theme = ThemeHelper(state.value);
        return MaterialApp(
          title: 'Gutter app',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: theme.isDark ? Brightness.dark : Brightness.light,
            primarySwatch: theme.accentColor,
            accentColor: theme.accentColor,
            backgroundColor: theme.backgroundColor,
            canvasColor: theme.backgroundColor,
            shadowColor: theme.shadowColor,
            indicatorColor: theme.accentColor,
            splashFactory: InkRipple.splashFactory,
            inputDecorationTheme: InputDecorationTheme(
              isDense: true,
              filled: false,
              contentPadding: EdgeInsets.all(16),
              hintStyle: TextStyles.caption(context: context, color: theme.hintColor),
              errorStyle: TextStyles.caption(context: context, color: theme.errorColor).copyWith(height: 0, fontSize: 0),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: theme.accentColor, width: 1)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: theme.accentColor, width: 3),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: theme.accentColor, width: 1),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: theme.hintColor, width: 1),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: theme.errorColor, width: 1),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: theme.errorColor, width: 3),
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                primary: theme.accentColor,
                elevation: 1,
                shadowColor: theme.hintColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                padding: EdgeInsets.all(16),
              ),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: theme.accentColor,
                elevation: 1,
                shadowColor: theme.hintColor,
                backgroundColor: theme.backgroundColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: BorderSide(color: theme.accentColor, width: 1)),
                padding: EdgeInsets.all(16),
              ),
            ),
            textSelectionTheme: TextSelectionThemeData(
              cursorColor: theme.accentColor,
            ),
            iconTheme: IconThemeData(color: theme.iconColor, size: 20),
            visualDensity: VisualDensity.adaptivePlatformDensity,
            appBarTheme: AppBarTheme(
              iconTheme: IconThemeData(color: theme.iconColor),
              actionsIconTheme: IconThemeData(color: theme.iconColor),
              backgroundColor: theme.backgroundColor,
              elevation: 0,
            ),
          ),
          home: LauncherScreen(),
          onGenerateRoute: (settings) => router.generateRoute(settings),
        );
      },
    );
  }
}

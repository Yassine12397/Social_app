import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/layout/social_layout/cubit/cubit.dart';
import 'package:flutter_app/layout/social_layout/social_layout_screen.dart';
import 'package:flutter_app/layout/theme_cubit/themeCubit.dart';
import 'package:flutter_app/layout/theme_cubit/themeState.dart';
import 'package:flutter_app/modules/on_boarding.dart';
import 'package:flutter_app/modules/social_login/login_screen.dart';
import 'package:flutter_app/shared/components/blocObserver.dart';
import 'package:flutter_app/shared/constant/constant.dart';
import 'package:flutter_app/shared/network/local/cache_helper.dart';
import 'package:flutter_app/shared/network/remote/dio_helper.dart';
import 'package:flutter_app/shared/styles/themes/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      DioHelper.init();
      await CacheHelper.init();
      Widget widget;
      bool? isDark = CacheHelper.getData(key: 'isDark');
      //   bool? onBoard = CacheHelper.getSavedData(key: 'onBoarding');
      uId = CacheHelper.getSavedData(key: 'uId');
      if (uId != null) {
        widget = SocialLayout();
      } else {
        widget = SocialLoginScreen();
      }

      runApp(MyApp(isDark, widget));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget startWidget;

  MyApp(this.isDark, this.startWidget);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeCubit()
            ..changeAppMode(
              fromShared: isDark,
            ),
        ),
        BlocProvider(
          create: (context) => SocialCubit()..getUserData(),
        )
      ],
      child: BlocConsumer<ThemeCubit, ThemeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeCubit.get(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light,
            home: SocialLoginScreen(),
          );
        },
      ),
    );
  }
}

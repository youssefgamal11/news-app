import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/cubit/cubit.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/layout/news_layout.dart';
import 'cubit/bloc_observer.dart';
import 'shared/network/local/cache_helper.dart';
import 'shared/network/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool isDarkk = CacheHelper.getBoolen(key: 'isDark');
  runApp(MyApp(isDarkk));
}

class MyApp extends StatelessWidget {
  final bool isDarkk;
  MyApp(this.isDarkk);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit()
        ..changeMode(
          fromShared: isDarkk
        ),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              primarySwatch: Colors.blue,
              appBarTheme: AppBarTheme(
                color: Colors.white,
                elevation: 0,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
                backwardsCompatibility: false,
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  elevation: 50,
                  selectedItemColor: Colors.blue.shade900,
                  type: BottomNavigationBarType.fixed),
            ),
            darkTheme: ThemeData(
              scaffoldBackgroundColor: HexColor('333739'),
              appBarTheme: AppBarTheme(
                color: HexColor('333739'),
                elevation: 0,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: HexColor('333739'),
                  statusBarIconBrightness: Brightness.light,
                ),
                backwardsCompatibility: false,
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  elevation: 50,
                  selectedItemColor: Colors.deepOrange,
                  backgroundColor: HexColor('333739'),
                  type: BottomNavigationBarType.fixed),
              textTheme: TextTheme(
                  // bodyText2: TextStyle(
                  //   color: Colors.white,
                  //   fontSize: 18,
                  //   fontWeight: FontWeight.bold,
                  // ),
                  ),
            ),
            themeMode: NewsCubit.get(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light,
            home: NewsScreen(),
          );
        },
      ),
    );
  }
}

import 'package:esportsanalytix_probe_oracle_221_t/models/match_model.dart';
import 'package:esportsanalytix_probe_oracle_221_t/models/player_model.dart';
import 'package:esportsanalytix_probe_oracle_221_t/q/color_q.dart';
import 'package:esportsanalytix_probe_oracle_221_t/q/onb_q.dart';
import 'package:esportsanalytix_probe_oracle_221_t/q/qq_tols.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(MatchModelAdapter());
  Hive.registerAdapter(PlayerModelAdapter());
  await Hive.openBox<MatchModel>('matchBox');
  await Hive.openBox<PlayerModel>('players');

  runApp(ChangeNotifierProvider(
    create: (context) => GuesssModlProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'EsportsAnalytix',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: ColorQ.background,
          ),
          scaffoldBackgroundColor: ColorQ.background,
          // fontFamily: '-_- ??',
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
        ),
        home: const QOnBoDi(),
      ),
    );
  }
}

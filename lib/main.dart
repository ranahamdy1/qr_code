import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'bloc_observer.dart';
import 'core/cache_helper.dart';
import 'core/dio_helper.dart';
import 'features/auth/login/presentaion/login_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const SimpleBlocObserver();
  await CacheHelper.init();
  await DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superstore/firebase_options.dart';
import 'package:superstore/pages/auth/bloc/auth_bloc.dart';
import 'package:superstore/pages/stock_map/components/east/bloc/east_bloc.dart';
import 'package:superstore/pages/stock_map/components/north/one/bloc/north_one_bloc.dart';
import 'package:superstore/pages/stock_map/components/north/zero/bloc/north_bloc.dart';
import 'package:superstore/pages/stock_map/components/south/one/bloc/south_one_bloc.dart';
import 'package:superstore/pages/stock_map/components/south/zero/bloc/south_zero_bloc.dart';
import 'package:superstore/pages/stock_map/components/west/bloc/west_bloc.dart';
import 'package:superstore/services/router/router.dart';
import 'package:superstore/services/singleton/singleton.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initSingleton();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => singleton<AuthBloc>(),
      ),
      BlocProvider(
        create: (context) => singleton<WestBloc>(),
      ),
      BlocProvider(
        create: (context) => singleton<EastBloc>(),
      ),
      BlocProvider(
        create: (context) => singleton<NorthZeroBloc>(),
      ),
      BlocProvider(
        create: (context) => singleton<NorthOneBloc>(),
      ),
      BlocProvider(
        create: (context) => singleton<SouthZeroBloc>(),
      ),
      BlocProvider(
        create: (context) => singleton<SouthOneBloc>(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Superstore Bakery',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: AppAouter.router(),
    );
  }
}

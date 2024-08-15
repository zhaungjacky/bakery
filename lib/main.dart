import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superstore/firebase_options.dart';
import 'package:superstore/pages/auth/bloc/auth_bloc.dart';
import 'package:superstore/pages/settings/bloc/settings_bloc.dart';
import 'package:superstore/pages/stock_map/components/components.dart';
import 'package:superstore/pages/tags/bloc/tags_bloc.dart';
import 'package:superstore/services/router/app_router.dart';
import 'package:superstore/services/singleton/singleton.dart';
import 'package:superstore/services/theme/light_mode.dart';

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
      BlocProvider(
        create: (context) => singleton<SettingsBloc>(),
      ),
      BlocProvider(
        create: (context) => singleton<TagsBloc>(),
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
      title: 'Bakery Stock',
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      routerConfig: AppAouter.router(),
    );
  }
}

import 'package:get_it/get_it.dart';
import 'package:superstore/pages/auth/bloc/auth_bloc.dart';
import 'package:superstore/pages/stock_map/components/east/bloc/east_bloc.dart';
import 'package:superstore/pages/stock_map/components/north/one/bloc/north_one_bloc.dart';
import 'package:superstore/pages/stock_map/components/north/zero/bloc/north_bloc.dart';
import 'package:superstore/pages/stock_map/components/south/one/bloc/south_one_bloc.dart';
import 'package:superstore/pages/stock_map/components/south/zero/bloc/south_zero_bloc.dart';
import 'package:superstore/pages/stock_map/components/west/bloc/west_bloc.dart';
import 'package:superstore/services/auth/data_source/auth_data_source.dart';
import 'package:superstore/services/auth/repo/auth_repo.dart';
import 'package:superstore/services/map/data-repo/map_data_repo.dart';
import 'package:superstore/services/map/data-source/map_data_source.dart';

GetIt singleton = GetIt.instance;

Future<void> initSingleton() async {
  _initAuth();
  _initMapData();
}

_initAuth() {
  singleton.registerFactory<AuthDataSourceRepository>(
    () => AuthDatasourceRepositoryImpl(),
  );
  singleton.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(
      singleton<AuthDataSourceRepository>(),
    ),
  );
  singleton.registerLazySingleton<AuthBloc>(
    () => AuthBloc(),
  );
}

_initMapData() {
  singleton.registerFactory<MapDataSource>(
    () => MapDataSourceImpl(),
  );
  singleton.registerFactory<MapDataRepo>(
    () => MapDataRepoImpl(
      mapDataSource: singleton<MapDataSource>(),
    ),
  );
  singleton.registerLazySingleton<WestBloc>(
    () => WestBloc(
      mapDataRepo: singleton<MapDataRepo>(),
    ),
  );
  singleton.registerLazySingleton<EastBloc>(
    () => EastBloc(
      mapDataRepo: singleton<MapDataRepo>(),
    ),
  );
  singleton.registerLazySingleton<NorthZeroBloc>(
    () => NorthZeroBloc(
      mapDataRepo: singleton<MapDataRepo>(),
    ),
  );
  singleton.registerLazySingleton<NorthOneBloc>(
    () => NorthOneBloc(
      mapDataRepo: singleton<MapDataRepo>(),
    ),
  );
  singleton.registerLazySingleton<SouthZeroBloc>(
    () => SouthZeroBloc(
      mapDataRepo: singleton<MapDataRepo>(),
    ),
  );
  singleton.registerLazySingleton<SouthOneBloc>(
    () => SouthOneBloc(
      mapDataRepo: singleton<MapDataRepo>(),
    ),
  );
}

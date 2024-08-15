import 'package:get_it/get_it.dart';
import 'package:superstore/pages/auth/bloc/auth_bloc.dart';
import 'package:superstore/pages/settings/bloc/settings_bloc.dart';
import 'package:superstore/pages/stock_map/components/east/bloc/east_bloc.dart';
import 'package:superstore/pages/stock_map/components/north/one/bloc/north_one_bloc.dart';
import 'package:superstore/pages/stock_map/components/north/zero/bloc/north_zero_bloc.dart';
import 'package:superstore/pages/stock_map/components/south/one/bloc/south_one_bloc.dart';
import 'package:superstore/pages/stock_map/components/south/zero/bloc/south_zero_bloc.dart';
import 'package:superstore/pages/stock_map/components/west/bloc/west_bloc.dart';
import 'package:superstore/pages/tags/bloc/tags_bloc.dart';
import 'package:superstore/services/auth/data_source/auth_data_source.dart';
import 'package:superstore/services/auth/repo/auth_repo.dart';
import 'package:superstore/services/map/data-repo/map_data_repo.dart';
import 'package:superstore/services/map/data-source/map_data_source.dart';
import 'package:superstore/services/serverice-model/service_data_source.dart';
import 'package:superstore/services/serverice-model/service_repo.dart';
import 'package:superstore/services/setting/data-source/setting_data_source.dart';
import 'package:superstore/services/setting/repo/setting_data_repo.dart';
import 'package:superstore/services/tags/data-source/tag_data_source_impl.dart';
import 'package:superstore/services/tags/model/tag_model.dart';
import 'package:superstore/services/tags/repo/tag_repo_impl.dart';

GetIt singleton = GetIt.instance;

Future<void> initSingleton() async {
  _initAuth();
  _initMapData();
  _initSetting();
  _initTags();
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

_initSetting() {
  singleton.registerFactory<SettingDataSource>(
    () => SettingDataSourceImpl(),
  );
  singleton.registerFactory<SettingDataRepo>(
    () => SettingDataRepoImpl(
      settingDataSorce: singleton<SettingDataSource>(),
    ),
  );
  singleton.registerLazySingleton<SettingsBloc>(
    () => SettingsBloc(
      settingDataRepo: singleton<SettingDataRepo>(),
    ),
  );
}

_initTags() {
  singleton.registerFactory<ServiceDateSource<TagModel>>(
    () => TagDataSourceImpl(),
  );

  singleton.registerFactory<ServiceRepo<TagModel>>(
    () => TagRepoImpl(
      servicedateSource: singleton<ServiceDateSource<TagModel>>(),
    ),
  );

  singleton.registerLazySingleton<TagsBloc>(
    () => TagsBloc(serviceRepo: singleton<ServiceRepo<TagModel>>()),
  );
}

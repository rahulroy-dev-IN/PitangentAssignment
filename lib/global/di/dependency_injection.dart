import 'package:get_it/get_it.dart';
import 'package:pitangent_assignment/global/network/app_repo/app_repository.dart';
import 'package:pitangent_assignment/global/util/navigation_service.dart';
import 'package:pitangent_assignment/screens/home/home_logic/favorite_bloc.dart';
import 'package:pitangent_assignment/screens/home/home_logic/products_bloc.dart';

final getIt = GetIt.instance;

Future<void> initGetServiceLocator() async {
  //Repository
  getIt.registerLazySingleton<AppRepository>(() => AppRepository());

  //Navigation service
  getIt.registerLazySingleton(() => NavigationService());

  getIt.registerFactory(() => ProductsBloc());
  getIt.registerFactory(() => FavoriteBloc());
}

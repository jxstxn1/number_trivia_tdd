import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:number_trivia_tdd/core/network/network_info.dart';
import 'package:number_trivia_tdd/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'core/util/input_converter.dart';
import 'features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Number Trivia
  initFeatures();
  //! Core
  initCore();
  //! External
  await initExternal();
}

void initFeatures() {
  //* Bloc
  sl.registerFactory(
    () => NumberTriviaBloc(
      getConcreteNumberTrivia: sl(),
      inputConverter: sl(),
      getRandomNumberTrivia: sl(),
    ),
  );

  //* Use cases
  sl.registerLazySingleton(() => GetConcreteNumberTrivia(sl()));
  sl.registerLazySingleton(() => GetRandomNumberTrivia(sl()));

  //* Repository
  sl.registerLazySingleton<NumberTriviaRepository>(
    () => NumberTriviaRepositoryImpl(
      localDataSource: sl(),
      networkInfo: sl(),
      remoteDataSource: sl(),
    ),
  );

  //* Data sources
  sl.registerLazySingleton<NumberTriviaRemoteDataSource>(
    () => NumberTriviaRemoteDataSourceImpl(
      client: sl(),
    ),
  );
  sl.registerLazySingleton<NumberTriviaLocalDataSource>(
    () => NumberTriviaLocalDataSourceImpl(
      sharedPreferences: sl(),
    ),
  );
}

void initCore() {
  sl.registerLazySingleton(() => InputConverterImplementation());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
}

Future<void> initExternal() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}

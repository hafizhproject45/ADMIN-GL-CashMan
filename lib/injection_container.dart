import 'package:get_it/get_it.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final sl = GetIt.instance;

Future<void> initLocator() async {
  sl.allowReassignment = true;

  ///////////////
  ///! EXTERNAL
  ///////////////

  final SupabaseClient sb = Supabase.instance.client;
  final FirebaseStorage fs = FirebaseStorage.instance;

  sl.registerSingleton<SupabaseClient>(sb);
  sl.registerSingleton<FirebaseStorage>(fs);

  ///////////////
  ///! Bloc / Cubit
  ///////////////

  //? Authentication
  // sl.registerFactory(
  //   () => UpdateUserCubit(updateUserUsecase: sl()),
  // );

  ///////////////
  //! Usecase
  ///////////////

  //? Authentication
  // sl.registerLazySingleton(() => LoginUsecase(authRepository: sl()));

  ///////////////
  //! Repository
  ///////////////

  //? FAQ
  // sl.registerLazySingleton<FaqRepository>(
  //   () => FaqRepositoryImpl(faqDatasource: sl()),
  // );

  ///////////////
  //! DataSource
  ///////////////

  //? FAQ
  // sl.registerLazySingleton<FaqDatasource>(
  //   () => FaqDatasourceImpl(supabase: sl()),
  // );
}

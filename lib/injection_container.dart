import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'domain/usecases/contact/get_contact_usecase.dart';
import 'domain/usecases/payment/get_images_usecase.dart';
import 'presentation/cubit/contact/get_contact_cubit.dart';
import 'presentation/cubit/payment/get_images/get_images_cubit.dart';
import 'data/datasources/contact/contact_datasource.dart';
import 'data/datasources/payment/payment_datasource.dart';
import 'data/repositories/contact/contact_repository_impl.dart';
import 'data/repositories/payment/payment_repository_impl.dart';
import 'domain/repositories/contact/contact_repository.dart';
import 'domain/repositories/payment/payment_repository.dart';
import 'domain/usecases/payment/delete_payment_usecase.dart';
import 'domain/usecases/payment/get_all_payment_usecase.dart';
import 'domain/usecases/payment/get_payment_today_usecase.dart';
import 'domain/usecases/payment/get_single_payment_usecase.dart';
import 'domain/usecases/payment/payment_usecase.dart';
import 'presentation/cubit/payment/get_payment_today/get_payment_today_cubit.dart';
import 'presentation/cubit/payment/delete_payment/delete_payment_cubit.dart';
import 'presentation/cubit/payment/get_all_payment/get_all_payment_cubit.dart';
import 'presentation/cubit/payment/get_single_payment/get_single_payment_cubit.dart';
import 'presentation/cubit/payment/payment/payment_cubit.dart';
import 'data/datasources/user/auth_datasource.dart';
import 'data/repositories/auth/auth_repository_impl.dart';
import 'domain/repositories/auth/auth_repository.dart';
import 'presentation/cubit/auth/delete_user/delete_user_cubit.dart';
import 'data/datasources/faq/faq_datasource.dart';
import 'data/repositories/faq/faq_repository_impl.dart';
import 'domain/repositories/faq/faq_repository.dart';
import 'domain/usecases/auth/check_login_usecase.dart';
import 'domain/usecases/auth/delete_user_usecase.dart';
import 'domain/usecases/auth/get_all_user_usecase.dart';
import 'domain/usecases/auth/get_single_user_usecase.dart';
import 'domain/usecases/auth/login_usecase.dart';
import 'domain/usecases/auth/logout_usecase.dart';
import 'domain/usecases/auth/update_user_usecase.dart';
import 'domain/usecases/faq/get_faq_usecase.dart';
import 'presentation/cubit/auth/get_all_user/get_all_user_cubit.dart';
import 'presentation/cubit/auth/get_single_user/get_single_user_cubit.dart';
import 'presentation/cubit/auth/login/login_cubit.dart';
import 'presentation/cubit/auth/update_user/update_user_cubit.dart';
import 'presentation/cubit/faq/get_faq_cubit.dart';

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
  sl.registerFactory(
    () => LoginCubit(
        checkLoginUsecase: sl(), loginUsecase: sl(), logoutUsecase: sl()),
  );
  sl.registerFactory(
    () => GetAllUserCubit(getAllUserUsecase: sl()),
  );
  sl.registerFactory(
    () => GetSingleUserCubit(getSingleUserUsecase: sl()),
  );
  sl.registerFactory(
    () => UpdateUserCubit(updateUserUsecase: sl()),
  );
  sl.registerFactory(
    () => DeleteUserCubit(deleteUserUsecase: sl()),
  );

  //? Payment
  sl.registerFactory(() => DeletePaymentCubit(deletePaymentUsecase: sl()));
  sl.registerFactory(() => GetAllPaymentCubit(getAllPaymentUsecase: sl()));
  sl.registerFactory(
    () => GetSinglePaymentCubit(getSinglePaymentUsecase: sl()),
  );
  sl.registerFactory(() => GetPaymentTodayCubit(getPaymentTodayUsecase: sl()));
  sl.registerFactory(() => PaymentCubit(paymentUsecase: sl()));
  sl.registerFactory(() => GetImagesCubit(getImagesUsecase: sl()));

  //? FAQ
  sl.registerFactory(() => GetFaqCubit(getFaqUsecase: sl()));

  //? Contact
  sl.registerFactory(() => GetContactCubit(getContactUsecase: sl()));

  ///////////////
  //! Usecase
  ///////////////

//? Authentication
  sl.registerLazySingleton(() => LoginUsecase(authRepository: sl()));
  sl.registerLazySingleton(() => LogoutUsecase(authRepository: sl()));
  sl.registerLazySingleton(() => CheckLoginUsecase(authRepository: sl()));

  sl.registerLazySingleton(() => GetAllUserUsecase(authRepository: sl()));
  sl.registerLazySingleton(() => GetSingleUserUsecase(authRepository: sl()));
  sl.registerLazySingleton(() => UpdateUserUsecase(authRepository: sl()));
  sl.registerLazySingleton(() => DeleteUserUsecase(authRepository: sl()));

  //? Payment
  sl.registerLazySingleton(
    () => DeletePaymentUsecase(paymentRepository: sl()),
  );
  sl.registerLazySingleton(
    () => GetAllPaymentUsecase(paymentRepository: sl()),
  );
  sl.registerLazySingleton(
    () => GetSinglePaymentUsecase(paymentRepository: sl()),
  );
  sl.registerLazySingleton(
    () => GetPaymentTodayUsecase(paymentRepository: sl()),
  );
  sl.registerLazySingleton(
    () => GetImagesUsecase(paymentRepository: sl()),
  );
  sl.registerLazySingleton(
    () => PaymentUsecase(
      paymentRepository: sl(),
      authRepository: sl(),
    ),
  );

  //? FAQ
  sl.registerLazySingleton(() => GetFaqUsecase(faqRepository: sl()));

  //? Contact
  sl.registerLazySingleton(() => GetContactUsecase(contactRepository: sl()));

  ///////////////
  //! Repository
  ///////////////

  //? Authentication
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(authDataSource: sl()),
  );

  //? FAQ
  sl.registerLazySingleton<PaymentRepository>(
    () => PaymentRepositoryImpl(paymentDatasource: sl()),
  );

  //? FAQ
  sl.registerLazySingleton<FaqRepository>(
    () => FaqRepositoryImpl(faqDatasource: sl()),
  );

  //? Contact
  sl.registerLazySingleton<ContactRepository>(
    () => ContactRepositoryImpl(contactDatasource: sl()),
  );

  ///////////////
  //! DataSource
  ///////////////

  //? Authentication
  sl.registerLazySingleton<AuthDataSource>(
    () => AuthDataSourceImpl(supabase: sl()),
  );

  //? Payment
  sl.registerLazySingleton<PaymentDatasource>(
    () => PaymentDatasourceImpl(supabase: sl(), storage: sl()),
  );

  //? FAQ
  sl.registerLazySingleton<FaqDatasource>(
    () => FaqDatasourceImpl(supabase: sl()),
  );

  //? Contact
  sl.registerLazySingleton<ContactDatasource>(
    () => ContactDatasourceImpl(supabase: sl()),
  );
}

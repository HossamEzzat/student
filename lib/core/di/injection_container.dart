import 'package:student/core/network/api_service.dart';
import 'package:student/features/auth/cubit/auth_cubit.dart';
import 'package:student/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:student/features/auth/data/datasources/level_remote_datasource.dart';
import 'package:student/features/auth/data/datasources/university_remote_datasource.dart';
import 'package:student/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:student/features/auth/domain/repositories/auth_repository.dart';
import 'package:student/features/reset_password/cubit/reset_password_cubit.dart';
import 'package:student/features/reset_password/data/datasources/reset_password_remote_datasource.dart';
import 'package:student/features/reset_password/data/repositories/reset_password_repository_impl.dart';
import 'package:student/features/reset_password/domain/repositories/reset_password_repository.dart';

class InjectionContainer {
  static final InjectionContainer _instance = InjectionContainer._internal();
  factory InjectionContainer() => _instance;
  InjectionContainer._internal();

  late final ApiService _apiService;
  late final AuthRepository _authRepository;
  late final AuthCubit _authCubit;
  late final ResetPasswordRepository _resetPasswordRepository;
  late final ResetPasswordCubit _resetPasswordCubit;

  void init(ApiService apiService) {
    _apiService = apiService;

    final authRemoteDataSource = AuthRemoteDataSource(_apiService);
    final universityRemoteDataSource = UniversityRemoteDataSource(_apiService);
    final levelRemoteDataSource = LevelRemoteDataSource(_apiService);

    _authRepository = AuthRepositoryImpl(
      authRemoteDataSource: authRemoteDataSource,
      universityRemoteDataSource: universityRemoteDataSource,
      levelRemoteDataSource: levelRemoteDataSource,
    );

    _authCubit = AuthCubit(_authRepository);

    final resetPasswordRemoteDataSource = ResetPasswordRemoteDataSource(_apiService);

    _resetPasswordRepository = ResetPasswordRepositoryImpl(
      remoteDataSource: resetPasswordRemoteDataSource,
    );

    _resetPasswordCubit = ResetPasswordCubit(_resetPasswordRepository);
  }

  AuthCubit get authCubit => _authCubit;
  AuthRepository get authRepository => _authRepository;
  ResetPasswordCubit get resetPasswordCubit => _resetPasswordCubit;
  ResetPasswordRepository get resetPasswordRepository => _resetPasswordRepository;
}

final injectionContainer = InjectionContainer();

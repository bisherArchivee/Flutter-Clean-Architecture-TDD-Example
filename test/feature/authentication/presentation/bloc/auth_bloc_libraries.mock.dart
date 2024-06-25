import 'package:education_app/feature/authentication/domain/usecase/cache_login_type_usecase.dart';
import 'package:education_app/feature/authentication/domain/usecase/forgot_password_usecase.dart';
import 'package:education_app/feature/authentication/domain/usecase/sigin_in_usecase.dart';
import 'package:education_app/feature/authentication/domain/usecase/sigin_up_usecase.dart';
import 'package:education_app/feature/authentication/domain/usecase/update_user_data_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockSignInUseCase extends Mock implements SignInUseCase {}

class MockSignUpUseCase extends Mock implements SignUpUseCase {}

class MockForgotPasswordUseCase extends Mock implements ForgotPasswordUseCase {}

class MockUpdateUserDataUseCase extends Mock implements UpdateUserDataUseCase {}

class MockCacheLogInTypeUseCase extends Mock implements CacheLogInTypeUseCase {}

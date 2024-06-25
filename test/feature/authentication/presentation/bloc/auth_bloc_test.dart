import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:education_app/feature/authentication/domain/entity/auth_user_entity.dart';
import 'package:education_app/feature/authentication/domain/usecase/cache_login_type_usecase.dart';
import 'package:education_app/feature/authentication/domain/usecase/forgot_password_usecase.dart';
import 'package:education_app/feature/authentication/domain/usecase/sigin_in_usecase.dart';
import 'package:education_app/feature/authentication/domain/usecase/sigin_up_usecase.dart';
import 'package:education_app/feature/authentication/domain/usecase/update_user_data_usecase.dart';
import 'package:education_app/feature/authentication/presentation/bloc/auth_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_bloc_libraries.mock.dart';

void main() {
  late SignInUseCase signInUseCase;
  late SignUpUseCase signUpUseCase;
  late ForgotPasswordUseCase forgotPasswordUseCase;
  late UpdateUserDataUseCase updateUserDataUseCase;
  late CacheLogInTypeUseCase cacheLogInTypeUseCase;

  late AuthBloc authBloc;

  const signUpParams = SignUpParams.test();
  const signInParams = SignInParams.test();
  const updateUserParams = UpdateUserParams.test();
  const forgetPasswordParams = ForgotPasswordParams.test();

  /*got called every time test started or group of tests*/
  setUp(() {
    signInUseCase = MockSignInUseCase();
    signUpUseCase = MockSignUpUseCase();
    forgotPasswordUseCase = MockForgotPasswordUseCase();
    updateUserDataUseCase = MockUpdateUserDataUseCase();
    cacheLogInTypeUseCase = MockCacheLogInTypeUseCase();
    authBloc = AuthBloc(
      signInUseCase: signInUseCase,
      signUpUseCase: signUpUseCase,
      forgotPasswordUseCase: forgotPasswordUseCase,
      updateUserDataUseCase: updateUserDataUseCase,
      cacheLogInTypeUseCase: cacheLogInTypeUseCase,
    );
  });

  /*only called once*/
  setUpAll(() {
    registerFallbackValue(signUpParams);
    registerFallbackValue(signInParams);
    registerFallbackValue(updateUserParams);
    registerFallbackValue(forgetPasswordParams);
  });
  /* make sure after each individual test tearDown the bloc so the
   state of the bloc doesn't leak into the next test*/
  tearDown(() => authBloc.close());

  test('initial test should be [AuthInitial]', () {
    expect(authBloc.state, AuthInitialState());
  });

  group('SignIn', () {
    // blocTest(description, build: build)
    const userEntity = UserEntity.test();
    blocTest<AuthBloc, AuthState>(
      'should emit [AuthLoadingState,SignedInState] '
      'when [SignedIEvent] is added',
      build: () {
        //Arrange
        when(
          () => signInUseCase(params: signInParams),
        ).thenAnswer((invocation) async => const Right(userEntity));

        /*always in BlocTest return BLoC after the STUP*/
        return authBloc;
      },

      //Act
      act: (bloc) => bloc.add(
        SignInEvent(
          email: signInParams.email,
          password: signInParams.password,
        ),
      ),

      expect: () => [
        AuthLoadingState(),
        const SignInSuccessState(userEntity: userEntity),
      ],

      verify: (bloc) => verify(() => signInUseCase(params: signInParams)),
    );
  });
}

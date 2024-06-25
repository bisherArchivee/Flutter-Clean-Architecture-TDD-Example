import 'package:education_app/core/common/feature/sharedPreferences/domain/usecase/get_bool_usecase.dart';
import 'package:education_app/core/common/feature/sharedPreferences/domain/usecase/get_string_list_usecase.dart';
import 'package:education_app/core/common/feature/sharedPreferences/domain/usecase/get_string_usecase.dart';
import 'package:education_app/core/common/feature/sharedPreferences/domain/usecase/set_bool_usecase.dart';
import 'package:education_app/core/common/feature/sharedPreferences/domain/usecase/set_string_list_usecase.dart';
import 'package:education_app/core/common/feature/sharedPreferences/domain/usecase/set_string_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockGetStringUseCase extends Mock implements GetStringUseCase {}

class MockGetBoolUseCase extends Mock implements GetBoolUseCase {}

class MockGetStringListUseCase extends Mock implements GetStringListUseCase {}

class MockSetStringUseCase extends Mock implements SetStringUseCase {}

class MockSetStringListUseCase extends Mock implements SetStringListUseCase {}

class MockSetBoolUseCase extends Mock implements SetBoolUseCase {}

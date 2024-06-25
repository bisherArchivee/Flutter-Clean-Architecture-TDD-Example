import 'package:education_app/feature/authentication/data/datasource/local/auth_local_data_source.dart';
import 'package:education_app/feature/authentication/data/datasource/remote/auth_remote_data_source.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

class MockAuthLocalDataSource extends Mock implements AuthLocalDataSource {}

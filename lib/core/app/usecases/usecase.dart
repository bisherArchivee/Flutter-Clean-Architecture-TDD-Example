abstract class _UseCase<Type, Params> {
  const _UseCase({this.type, this.params});

  final Type? type;
  final Params? params;
}

abstract class UseCaseHasParams<Type, Params>
    extends _UseCase<dynamic, dynamic> {
  Future<Type> call({required Params params});
}

abstract class UseCaseHasNoParams<Type> extends _UseCase<dynamic, void> {
  Future<Type> call();
}

// abstract class UseCaseHasParams<Type,Params> {
//   Future<Type> call({Params params});
// }

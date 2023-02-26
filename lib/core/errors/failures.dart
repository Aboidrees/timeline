abstract class Failure {
  final String? errorMessage;
  Failure({this.errorMessage});
}

class ServerFailure extends Failure {}

class CacheFailure extends Failure {}

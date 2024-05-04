abstract class Failure  {
  final String massage;
  const Failure(this.massage,);

  
}

class ServerFailure extends Failure {
  const ServerFailure(super.massage);
}

class ConnectionFailure extends Failure {
  const ConnectionFailure(super.massage);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(super.massage);
}

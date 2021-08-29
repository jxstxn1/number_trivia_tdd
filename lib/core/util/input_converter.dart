import 'package:dartz/dartz.dart';

import '../error/failure.dart';

abstract class InputConverter {
  Either<Failure, int> stringToUnsignedInteger(String str);
}

class InputConverterImplementation implements InputConverter {
  @override
  Either<Failure, int> stringToUnsignedInteger(String str) {
    try {
      final integer = int.parse(str);
      if (integer < 0) throw const FormatException();
      return Right(integer);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure {}

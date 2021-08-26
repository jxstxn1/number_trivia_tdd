import 'package:dartz/dartz.dart';
import 'package:number_trivia_tdd/core/error/failure.dart';
import 'package:number_trivia_tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia_tdd/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class GetConcreteNumberTrivia {
  GetConcreteNumberTrivia(this.repository);

  final NumberTriviaRepository repository;

  Future<Either<Failure, NumberTrivia>> execute({
    required int number,
  }) {
    print(repository.getConcreteNumberTrivia(number));
    return repository.getConcreteNumberTrivia(number);
  }
}

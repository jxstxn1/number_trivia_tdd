import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_trivia_tdd/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

import '../../../../injection_container.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Number Trivia',
        ),
      ),
      body: SingleChildScrollView(
        child: buildBody(context),
      ),
    );
  }
}

BlocProvider<NumberTriviaBloc> buildBody(BuildContext context) {
  return BlocProvider(
    create: (_) => sl<NumberTriviaBloc>(),
    child: Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 10),
            // Top half
            BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
              builder: (context, state) {
                if (state is Empty) {
                  return const MessageDisplay(
                    message: 'Start searching!',
                  );
                } else {
                  return const MessageDisplay(
                    message: 'Something wrong after Null-Safety upgrade!',
                  );
                }
              },
            ),
            const SizedBox(height: 20),
            // Bottom half
            // TriviaControls()
          ],
        ),
      ),
    ),
  );
}

class MessageDisplay extends StatelessWidget {
  const MessageDisplay({
    required this.message,
    Key? key,
  }) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      child: Center(
        child: SingleChildScrollView(
          child: Text(
            message,
            style: const TextStyle(fontSize: 25),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

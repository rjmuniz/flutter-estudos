import 'package:bytebank_app/components/BlocContainer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void plus() => emit(state + 1);

  void minus() => emit(state - 1);
}

class CounterContainer extends BlocContainer {
  static const String route = '/counter';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterCubit(),
      child: CounterView(),
    );
  }
}

class CounterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Counter'),
      ),
      body: Center(child: BlocBuilder<CounterCubit, int>(
        builder: (context, state) {
          return Text(
            "$state",
            style: textTheme.headline2,
          );
        },
      )),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () => context.bloc<CounterCubit>().plus(),
          ),
          FloatingActionButton(
            child: const Icon(Icons.remove),
            onPressed: () => context.bloc<CounterCubit>().minus(),
          )
        ],
      ),
    );
  }
}

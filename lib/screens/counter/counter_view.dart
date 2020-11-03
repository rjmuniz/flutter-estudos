import 'package:bytebank_app/screens/counter/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CounterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: AppBar(title: const Text("Counter")),
        body: Center(
          child: BlocBuilder<CounterCubit, int>(
            builder: (context, state) =>
                Text("$state", style: textTheme.headline1),
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            FloatingActionButton(
              tooltip: "increment",
              child: Icon(Icons.add),
              onPressed: () => context.bloc<CounterCubit>().increment(),
            ),
            const SizedBox(height: 8),
            FloatingActionButton(
              tooltip: "decrement",
              child: Icon(Icons.remove),
              onPressed: () =>
                  BlocProvider.of<CounterCubit>(context).decrement(),
            )
          ],
        ));
  }
}

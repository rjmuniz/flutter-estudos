
import 'package:bytebank_app/components/BlocContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocalicationContainer extends BlocContainer {
  final Widget child;

  LocalicationContainer({@required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CurrentLocaleCubit>(
      create: (_) {
        return CurrentLocaleCubit();
      },
      child: this.child,
    );
  }
}

class CurrentLocaleCubit extends Cubit<String> {
  CurrentLocaleCubit() : super("pt-br");

  void load(Widget child) {}
}

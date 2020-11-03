
import 'package:bytebank_app/components/BlocContainer.dart';
import 'package:bytebank_app/screens/contacts_list/contacts_list_view.dart';
import 'package:bytebank_app/screens/contacts_list/contacts_list_cubit.dart';
import 'package:bytebank_app/widgets/app_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactsListContainer extends BlocContainer {
  static const route = '/contact_list';

  @override
  Widget build(BuildContext context) {
    final dependencies = AppDependencies.of(context);

    return BlocProvider(
      create: (BuildContext context) {
        final cubit = ContactsListCubit();

        cubit.reload(dependencies.contactDao);

        return cubit;
      },
      child: ContactsListView(dependencies.contactDao),
    );
  }
}
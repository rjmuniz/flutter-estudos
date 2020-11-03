import 'package:bytebank_app/components/localization/locale.dart';
import 'package:bytebank_app/components/theme.dart';
import 'package:bytebank_app/database/dao/contact_dao.dart';
import 'package:bytebank_app/http/webclients/transactions_webclient.dart';
import 'package:bytebank_app/screens/contact_form.dart';
import 'package:bytebank_app/screens/contacts_list/contacts_list_container.dart';
import 'package:bytebank_app/screens/counter.dart';
import 'package:bytebank_app/screens/dashboard/dashboard_container.dart';
import 'package:bytebank_app/screens/transactions_list.dart';
import 'package:bytebank_app/widgets/app_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(BytebankApp(
    contactDao: ContactDao(),
    transactionsWebClient: TransactionsWebClient(),
  ));
}

class LogObserver extends BlocObserver {
  @override
  void onChange(Cubit cubit, Change change) {
    print(
        "${cubit.runtimeType} > ${change.currentState.runtimeType} to ${change.nextState.runtimeType}");
    super.onChange(cubit, change);
  }
}

class BytebankApp extends StatelessWidget {
  final ContactDao contactDao;
  final TransactionsWebClient transactionsWebClient;

  const BytebankApp({
    @required this.contactDao,
    @required this.transactionsWebClient,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Bloc.observer = LogObserver();

    return AppDependencies(
      contactDao: this.contactDao,
      transactionsWebClient: this.transactionsWebClient,
      child: MaterialApp(
        //initialRoute: DashboardContainer.route,
        //initialRoute: CounterContainer.route,

        routes: {
          DashboardContainer.route: (context) => DashboardContainer(),
          ContactsListContainer.route: (context) => ContactsListContainer(),
          ContactForm.route: (context) => ContactForm(),
          TransactionList.route: (context) => TransactionList(),
          CounterContainer.route: (context) => CounterContainer(),
          //   TransactionFormContainer.route: (context) => TransactionFormContainer(Contact()),
        },
        home: LocalicationContainer(
          child: DashboardContainer(),
        ),
        theme: bytebankTheme,
      ),
    );
  }
}

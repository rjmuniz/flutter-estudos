import 'package:bytebank_app/models/name.dart';
import 'package:bytebank_app/screens/contacts_list/contacts_list_container.dart';
import 'package:bytebank_app/screens/dashboard/components/feature_item.dart';
import 'package:bytebank_app/screens/dashboard/dashboard_i18n.dart';
import 'package:bytebank_app/screens/name.dart';
import 'package:bytebank_app/screens/transactions_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardView extends StatelessWidget {
  final DashboardViewLazyI18N _i18n;

  const DashboardView(this._i18n);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: BlocBuilder<NameCubit, String>(
        builder: (context, state) => Text('Welcome $state'),
      )),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Image.network('https://cdn.pixabay.com/photo/2020/05/04/09/09/giraffe-5128394_960_720.jpg')
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('images/bytebank_logo.png'),
          ),
          Container(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                FeatureItem(
                  _i18n.transfer,
                  Icons.monetization_on,
                  onClick: () {
                    _navigateContactList(context);
                  },
                ),
                FeatureItem(
                  _i18n.transactionFeed,
                  Icons.description,
                  onClick: () {
                    _navigateTransactionFeedList(context);
                  },
                ),
                FeatureItem(
                  _i18n.changeName,
                  Icons.person_outline,
                  onClick: () => _showChangeName(context),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _navigateContactList(BuildContext context) {
    Navigator.of(context).pushNamed(ContactsListContainer.route);
  }

  void _navigateTransactionFeedList(BuildContext context) {
    Navigator.of(context).pushNamed(TransactionList.route);
  }

  void _showChangeName(BuildContext blocContext) {
    Navigator.of(blocContext).push(MaterialPageRoute(
      builder: (context) => BlocProvider.value(
        value: BlocProvider.of<NameCubit>(blocContext),
        child: NameContainer(),
      ),
    ));
  }
}

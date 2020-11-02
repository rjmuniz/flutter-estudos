import 'package:bytebank_app/components/BlocContainer.dart';
import 'package:bytebank_app/components/localization.dart';
import 'package:bytebank_app/models/name.dart';
import 'package:bytebank_app/screens/contacts_list.dart';
import 'package:bytebank_app/screens/name.dart';
import 'package:bytebank_app/screens/transactions_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardContainer extends BlocContainer {
  static const String route = '/dashboard';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NameCubit("Ricardo"),
      child: I18NLoadingContainer(
        creator: ( messages) => DashboardView(messages)
      ),
    );
  }
}

class DashboardView extends StatelessWidget {
  final I18NMessages messages;

  const DashboardView(this.messages);

  @override
  Widget build(BuildContext context) {
    final i18n = DashboardViewI18N(context);

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
                  i18n.transfer,
                  Icons.monetization_on,
                  onClick: () {
                    _navigateContactList(context);
                  },
                ),
                FeatureItem(
                  i18n.transaction_feed,
                  Icons.description,
                  onClick: () {
                    _navigateTransactionFeedList(context);
                  },
                ),
                FeatureItem(
                  i18n.change_name,
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

class DashboardViewI18N extends ViewI18N{
  DashboardViewI18N(BuildContext context):super(context);

  String get transfer => localize({'pt-br':'Transferir', 'en': 'Transfer'});

  String get transaction_feed =>localize({'pt-br':'Transações', 'en': 'Transacion feed'});

  String get change_name => localize({'pt-br':'Mudar o nome', 'en': 'Change name'});



}


class FeatureItem extends StatelessWidget {
  final String titleFeature;
  final IconData iconData;
  final Function onClick;

  FeatureItem(this.titleFeature, this.iconData, {@required this.onClick})
      : assert(iconData != null),
        assert(onClick != null);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: () => onClick(),
          child: Container(
            padding: EdgeInsets.all(8.0),
            width: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  iconData,
                  color: Colors.white,
                  size: 32.0,
                ),
                Text(
                  titleFeature,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

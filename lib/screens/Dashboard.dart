import 'package:bytebank_app/screens/contacts_list.dart';
import 'package:bytebank_app/screens/transactions_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

const String transferText = 'Transfer';
const String transactionFeedText = 'Transaction Feed';

class Dashboard extends StatelessWidget {
  static const String route = '/dashboard';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard')),
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
                _FeatureItem(
                  transferText,
                  Icons.monetization_on,
                  onClick: () {
                    _navigateContactList(context);
                  },
                ),
                _FeatureItem(
                  transactionFeedText,
                  Icons.description,
                  onClick: () {
                    _navigateTransactionFeedList(context);
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _navigateContactList(BuildContext context) {
    Navigator.of(context).pushNamed(ContactsList.route);
  }

  void _navigateTransactionFeedList(BuildContext context) {
    Navigator.of(context).pushNamed(TransactionList.route);
  }
}

class _FeatureItem extends StatelessWidget {
  final String titleFeature;
  final IconData iconData;
  final Function onClick;

  _FeatureItem(this.titleFeature, this.iconData, {@required this.onClick})
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

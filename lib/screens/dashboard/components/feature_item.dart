import 'package:flutter/material.dart';

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

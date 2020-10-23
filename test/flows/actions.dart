import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../matchers/matchers.dart';

Future<void> clickOnTheTransferFeatureItem(WidgetTester tester) async {
  final featureTransfer = find.byWidgetPredicate((widget) => featureItemMatcher(widget, 'Transfer', Icons.monetization_on));
  expect(featureTransfer, findsOneWidget);

  return tester.tap(featureTransfer);
}
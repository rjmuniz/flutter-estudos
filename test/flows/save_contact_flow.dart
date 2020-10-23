
import 'package:bytebank_app/main.dart';
import 'package:bytebank_app/models/contact.dart';
import 'package:bytebank_app/screens/Dashboard.dart';
import 'package:bytebank_app/screens/contact_form.dart';
import 'package:bytebank_app/screens/contacts_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../matchers/matchers.dart';
import '../mocks/mock_contact_dao.dart';
import 'actions.dart';

void main() {
  testWidgets('Should save contact', (tester) async {
    final mockContactDao = MockContactDao();

    await tester.pumpWidget(BytebankApp(contactDao: mockContactDao, transactionsWebClient: null,));
    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);

    await clickOnTheTransferFeatureItem(tester);
    await tester.pumpAndSettle();

    final contactsList = find.byType(ContactsList);
    expect(contactsList, findsOneWidget);

    verify(mockContactDao.findAll()).called(1);

    final fabNewContact = find.widgetWithIcon(FloatingActionButton, Icons.add);
    expect(fabNewContact, findsOneWidget);
    await tester.tap(fabNewContact);
    await tester.pumpAndSettle();

    final contactForm = find.byType(ContactForm);
    expect(contactForm, findsOneWidget);

    final nameTextField = find
        .byWidgetPredicate((widget) => textFieldByLabelTextMatcher(widget, 'Full name'));
    expect(nameTextField, findsOneWidget);
    await tester.enterText(nameTextField, 'Fulano Silva');

    final accountNumberTextField = find.byWidgetPredicate(
        (widget) => textFieldByLabelTextMatcher(widget, 'Account number'));
    expect(accountNumberTextField, findsOneWidget);
    await tester.enterText(accountNumberTextField, '4321');
    final createButon = find.widgetWithText(RaisedButton, 'Create');
    expect(createButon, findsOneWidget);

    await tester.tap(createButon);
    verify(mockContactDao.save(Contact(0, 'Fulano Silva', 4321))).called(1);
    await tester.pumpAndSettle();

    final contactsListBack = find.byType(ContactsList);
    expect(contactsListBack, findsOneWidget);

    verify(mockContactDao.findAll()).called(1);
  });
}

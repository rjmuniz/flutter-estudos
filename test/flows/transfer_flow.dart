import 'package:bytebank_app/components/success_dialog.dart';
import 'package:bytebank_app/components/transaction_auth_dialog.dart';
import 'package:bytebank_app/main.dart';
import 'package:bytebank_app/models/contact.dart';
import 'package:bytebank_app/models/transaction.dart';
import 'package:bytebank_app/screens/contacts_list/components/contact_item.dart';
import 'package:bytebank_app/screens/contacts_list/contacts_list_view.dart';
import 'package:bytebank_app/screens/dashboard/Dashboard_view.dart';
import 'package:bytebank_app/screens/transaction_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../matchers/matchers.dart';
import '../mocks/mock_contact_dao.dart';
import '../mocks/mock_transactions_webclient.dart';
import 'actions.dart';

void main() {
  testWidgets('Should transfer a contact', (tester) async {
    final mockContactDao = MockContactDao();
    final mockTransactionsWebclient = MockTransactionsWebClient();

    final sampleTransferValue = 12345.67;
    final samplePassword = '1000';

    await tester.pumpWidget(BytebankApp(
        transactionsWebClient: mockTransactionsWebclient,
        contactDao: mockContactDao));

    final dashboard = find.byType(DashboardView);
    expect(dashboard, findsOneWidget);

    final sampleContact = Contact(0, 'Fulano da Silva', 4321);
    when(mockContactDao.findAll()).thenAnswer((_) async => [sampleContact]);

    await clickOnTheTransferFeatureItem(tester);
    await tester.pumpAndSettle();

    final contactsList = find.byType(ContactsListView);
    expect(contactsList, findsOneWidget);

    verify(mockContactDao.findAll()).called(1);

    final contactItem = find.byWidgetPredicate((widget) {
      if (widget is ContactItem)
        return widget.contact.fullName == sampleContact.fullName &&
            widget.contact.accountNumber == sampleContact.accountNumber;
      return false;
    });
    expect(contactItem, findsOneWidget);

    await tester.tap(contactItem);
    await tester.pumpAndSettle();

    final transactionForm = find.byType(TransactionForm);
    expect(transactionForm, findsOneWidget);
    final contactName = find.text(sampleContact.fullName);
    expect(contactName, findsOneWidget);
    final contactAccountNumber =
        find.text(sampleContact.accountNumber.toString());
    expect(contactAccountNumber, findsOneWidget);

    final valueTextField = find.byWidgetPredicate(
        (widget) => textFieldByLabelTextMatcher(widget, 'Value'));
    await tester.enterText(valueTextField, sampleTransferValue.toString());

    final transferButton = find.widgetWithText(RaisedButton, 'Transfer');
    expect(transferButton, findsOneWidget);

    await tester.tap(transferButton);
    await tester.pumpAndSettle();

    final transactionAuthDialog = find.byType(TransactionAuthDialog);
    expect(transactionAuthDialog, findsOneWidget);

    final passwordField =
        find.byKey(TransactionAuthDialog.textFieldPasswordKey);
    expect(passwordField, findsOneWidget);
    await tester.enterText(passwordField, samplePassword);

    final cancelButton = find.widgetWithText(FlatButton, 'Cancel');
    expect(cancelButton, findsOneWidget);
    final confirmButton = find.widgetWithText(FlatButton, 'Confirm');
    expect(confirmButton, findsOneWidget);

    final transaction = Transaction(null, sampleTransferValue, sampleContact);
    when(mockTransactionsWebclient.save(transaction, samplePassword))
        .thenAnswer((_) async => transaction);

    await tester.tap(confirmButton);
    verify(mockTransactionsWebclient.save(transaction, samplePassword))
        .called(1);
    await tester.pumpAndSettle();

    final successDialog = find.byType(SuccessDialog);
    expect(successDialog, findsOneWidget);

    final okButton = find.widgetWithText(FlatButton, 'Ok');
    expect(okButton, findsOneWidget);

    await tester.tap(okButton);
    await tester.pumpAndSettle();

    final contactsListBack = find.byType(ContactsListView);
    expect(contactsListBack, findsOneWidget);
  });
}

class Contact {
  static const String _nameField = 'name';
  static const String _accountNumberField = 'accountNumber';
  static const String _idField = 'id';

  final int id;
  final String fullName;
  final int accountNumber;

  Contact(this.id, this.fullName, this.accountNumber);

  @override
  String toString() {
    return 'Contact{id: $id, fullName: $fullName, accountNumber: $accountNumber}';
  }

  String showName() {
    return "$fullName [$accountNumber]";
  }

  Contact.fromJson(Map<String, dynamic> json)
      : id = json[_idField],
        fullName = json[_nameField],
        accountNumber = json[_accountNumberField];

  toJson() => {
        _nameField: this.fullName,
        _accountNumberField: this.accountNumber,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Contact &&
          runtimeType == other.runtimeType &&
          fullName == other.fullName &&
          accountNumber == other.accountNumber;

  @override
  int get hashCode => fullName.hashCode ^ accountNumber.hashCode;
}

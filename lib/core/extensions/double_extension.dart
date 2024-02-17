extension DoubeX on double {
  String toMoney() {
    // money format pattern
    // final _moneyFormat = NumberFormat('#,###,###,###.00', 'en_US');
    // if (this == 0.0) return "0.00";
    // String _moneyFormatted = _moneyFormat.format(this);

    // // /to avoid it from showing $ .90
    // if (this > 0 && this < 1) return _moneyFormatted.replaceRange(0, 2, "0");
    // return _moneyFormatted;

    double amount = this;
    String formattedAmount =
        amount.toStringAsFixed(2); // Add a dollar sign and two decimal places
    formattedAmount = formattedAmount.replaceAllMapped(
        // Add commas to separate the thousands
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match match) => '${match[1]},');

    return formattedAmount;
  }

  String toMoneyShowFree() {
    // money format pattern
    if (this == 0.0) return "Free";
    return '\$${toMoney()}';
  }

  String toMoneyWithSymbol() {
    return "\$${toMoney()}";
  }
}

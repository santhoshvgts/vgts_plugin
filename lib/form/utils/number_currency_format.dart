

class NumberCurrencyFormat {

  String name;
  String locale;
  String symbol;
  int decimalDigits;

  NumberCurrencyFormat(this.name, this.locale, this.symbol, this.decimalDigits);

  factory NumberCurrencyFormat.inr(){
    return NumberCurrencyFormat("INR", "en_IN", "₹", 0);
  }

  factory NumberCurrencyFormat.usd(){
    return NumberCurrencyFormat("USD", "en-US", r"$", 0);
  }

}
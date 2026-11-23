/// Supported currencies in HOMELY.
/// All monetary values continue to be stored as 64-bit integer minor units (paise/cents/pence)
/// to ensure 100% precision with zero IEEE 754 floating point distortion.
class AppCurrency {
  final String code;
  final String symbol;
  final String name;
  final String locale;
  final int decimalDigits;
  final String minorUnitName;
  final String flagEmoji;

  const AppCurrency({
    required this.code,
    required this.symbol,
    required this.name,
    required this.locale,
    this.decimalDigits = 2,
    required this.minorUnitName,
    required this.flagEmoji,
  });

  static const inr = AppCurrency(
    code: 'INR',
    symbol: '₹',
    name: 'Indian Rupee',
    locale: 'en_IN',
    decimalDigits: 2,
    minorUnitName: 'Paise',
    flagEmoji: '🇮🇳',
  );

  static const usd = AppCurrency(
    code: 'USD',
    symbol: '\$',
    name: 'US Dollar',
    locale: 'en_US',
    decimalDigits: 2,
    minorUnitName: 'Cents',
    flagEmoji: '🇺🇸',
  );

  static const eur = AppCurrency(
    code: 'EUR',
    symbol: '€',
    name: 'Euro',
    locale: 'de_DE',
    decimalDigits: 2,
    minorUnitName: 'Cents',
    flagEmoji: '🇪🇺',
  );

  static const gbp = AppCurrency(
    code: 'GBP',
    symbol: '£',
    name: 'British Pound',
    locale: 'en_GB',
    decimalDigits: 2,
    minorUnitName: 'Pence',
    flagEmoji: '🇬🇧',
  );

  static const aed = AppCurrency(
    code: 'AED',
    symbol: 'د.إ',
    name: 'UAE Dirham',
    locale: 'ar_AE',
    decimalDigits: 2,
    minorUnitName: 'Fils',
    flagEmoji: '🇦🇪',
  );

  static const cad = AppCurrency(
    code: 'CAD',
    symbol: 'C\$',
    name: 'Canadian Dollar',
    locale: 'en_CA',
    decimalDigits: 2,
    minorUnitName: 'Cents',
    flagEmoji: '🇨🇦',
  );

  static const aud = AppCurrency(
    code: 'AUD',
    symbol: 'A\$',
    name: 'Australian Dollar',
    locale: 'en_AU',
    decimalDigits: 2,
    minorUnitName: 'Cents',
    flagEmoji: '🇦🇺',
  );

  static const jpy = AppCurrency(
    code: 'JPY',
    symbol: '¥',
    name: 'Japanese Yen',
    locale: 'ja_JP',
    decimalDigits: 0,
    minorUnitName: 'Yen',
    flagEmoji: '🇯🇵',
  );

  static const sgd = AppCurrency(
    code: 'SGD',
    symbol: 'S\$',
    name: 'Singapore Dollar',
    locale: 'en_SG',
    decimalDigits: 2,
    minorUnitName: 'Cents',
    flagEmoji: '🇸🇬',
  );

  static const List<AppCurrency> supportedCurrencies = [
    inr,
    usd,
    eur,
    gbp,
    aed,
    cad,
    aud,
    jpy,
    sgd,
  ];

  static AppCurrency fromCode(String? code) {
    if (code == null) return inr;
    return supportedCurrencies.firstWhere(
      (c) => c.code.toUpperCase() == code.toUpperCase(),
      orElse: () => inr,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppCurrency && runtimeType == other.runtimeType && code == other.code;

  @override
  int get hashCode => code.hashCode;

  @override
  String toString() => '$name ($symbol $code)';
}

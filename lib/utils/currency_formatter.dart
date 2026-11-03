import 'package:intl/intl.dart';

/// Utilitário para formatação monetária em Real Brasileiro (R$).
/// (ARQUIVO PRONTO — Não é necessário alterar na prova).
class CurrencyFormatter {
  static final NumberFormat _formatter = NumberFormat.currency(
    locale: 'pt_BR',
    symbol: r'R$',
    decimalDigits: 2,
  );

  static String format(double value) {
    try {
      return _formatter.format(value);
    } catch (_) {
      return 'R\$ ${value.toStringAsFixed(2)}';
    }
  }
}

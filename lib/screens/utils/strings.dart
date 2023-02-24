import 'package:intl/intl.dart';

var numberFormat = NumberFormat("###.0#", "en_US");
var currencyFormat = NumberFormat.currency(locale: "en_US", symbol: "\$");

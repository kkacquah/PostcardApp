import 'dart:math';

double roundDecimal(int decimals, double d) {
  int fac = pow(10, decimals);
  d = (d * fac).round() / fac;
  return d;
}

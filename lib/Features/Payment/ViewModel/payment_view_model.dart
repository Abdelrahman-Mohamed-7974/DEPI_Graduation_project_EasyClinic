import 'package:flutter/material.dart';

class PaymentViewModel extends ChangeNotifier {
  String selectedMethod = 'Card';

  String cardHolderName = '';
  String cardNumber = '';
  String expiryDate = '';
  String cvv = '';

  void selectMethod(String method) {
    selectedMethod = method;
    notifyListeners();
  }

  void updateCardDetails({
    String? name,
    String? number,
    String? expiry,
    String? cvvCode,
  }) {
    if (name != null) cardHolderName = name;
    if (number != null) cardNumber = number;
    if (expiry != null) expiryDate = expiry;
    if (cvvCode != null) cvv = cvvCode;
    notifyListeners();
  }

  bool validateCardDetails() {
    return cardHolderName.isNotEmpty &&
        cardNumber.length >= 16 &&
        expiryDate.isNotEmpty &&
        cvv.length >= 3;
  }
}

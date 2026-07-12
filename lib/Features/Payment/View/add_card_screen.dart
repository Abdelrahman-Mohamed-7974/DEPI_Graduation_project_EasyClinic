import 'package:flutter/material.dart';
import '../ViewModel/payment_view_model.dart';
import '../Widgets/payment_button.dart';
import '../Widgets/payment_card.dart';
import '../Widgets/custom_card_field.dart';
import 'payment_summary_screen.dart';

class AddCardScreen extends StatefulWidget {
  final PaymentViewModel viewModel;

  const AddCardScreen({super.key, required this.viewModel});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Add Card Details',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            PaymentCard(
              cardNumber: widget.viewModel.cardNumber,
              cardHolder: widget.viewModel.cardHolderName,
              expiry: widget.viewModel.expiryDate,
            ),
            const SizedBox(height: 32),
            CustomCardField(
              label: 'Card Holder Name',
              hint: 'John Doe',
              keyboardType: TextInputType.name,
              onChanged: (val) => widget.viewModel.updateCardDetails(name: val),
            ),
            CustomCardField(
              label: 'Card Number',
              hint: '**** **** **** 1234',
              keyboardType: TextInputType.number,
              maxLength: 16,
              onChanged: (val) => widget.viewModel.updateCardDetails(number: val),
            ),
            Row(
              children: [
                Expanded(
                  child: CustomCardField(
                    label: 'Expiry Date',
                    hint: 'MM/YY',
                    keyboardType: TextInputType.datetime,
                    maxLength: 5,
                    onChanged: (val) => widget.viewModel.updateCardDetails(expiry: val),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomCardField(
                    label: 'CVV',
                    hint: '***',
                    keyboardType: TextInputType.number,
                    maxLength: 3,
                    onChanged: (val) => widget.viewModel.updateCardDetails(cvvCode: val),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            PaymentButton(
              text: 'Save & Continue',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PaymentSummaryScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

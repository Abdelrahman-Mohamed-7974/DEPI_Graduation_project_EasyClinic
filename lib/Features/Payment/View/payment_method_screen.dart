import 'package:flutter/material.dart';
import '../ViewModel/payment_view_model.dart';
import '../Widgets/payment_button.dart';
import '../Widgets/payment_method_card.dart';
import 'add_card_screen.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  final PaymentViewModel _viewModel = PaymentViewModel();

  @override
  void initState() {
    super.initState();
    _viewModel.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
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
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text(
          'Payment Method',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select a payment method',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 24),
            PaymentMethodCard(
              title: 'Credit / Debit Card',
              icon: Icons.credit_card,
              isSelected: _viewModel.selectedMethod == 'Card',
              onTap: () => _viewModel.selectMethod('Card'),
            ),
            PaymentMethodCard(
              title: 'PayPal',
              icon: Icons.paypal,
              isSelected: _viewModel.selectedMethod == 'PayPal',
              onTap: () => _viewModel.selectMethod('PayPal'),
            ),
            PaymentMethodCard(
              title: 'Apple Pay',
              icon: Icons.apple,
              isSelected: _viewModel.selectedMethod == 'Apple Pay',
              onTap: () => _viewModel.selectMethod('Apple Pay'),
            ),
            const Spacer(),
            PaymentButton(
              text: 'Continue',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddCardScreen(viewModel: _viewModel),
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

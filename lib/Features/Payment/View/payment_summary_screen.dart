import 'package:flutter/material.dart';
import '../Widgets/payment_button.dart';
import '../Widgets/summary_item.dart';
import 'payment_success_screen.dart';

class PaymentSummaryScreen extends StatelessWidget {
  const PaymentSummaryScreen({super.key});

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
          'Payment Summary',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Appointment Details',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  SummaryItem(title: 'Doctor', value: 'Dr. Olivia Turner'),
                  SummaryItem(title: 'Duration', value: '30 Minutes'),
                  SummaryItem(title: 'Date', value: 'Oct 25, 2023 - 10:00 AM'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Payment Details',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  SummaryItem(title: 'Consultation Fee', value: '100 USD'),
                  SummaryItem(title: 'Tax', value: '0 USD'),
                  Divider(height: 32),
                  SummaryItem(
                    title: 'Total Amount',
                    value: '100 USD',
                    isTotal: true,
                  ),
                ],
              ),
            ),
            const Spacer(),
            PaymentButton(
              text: 'Confirm Payment',
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PaymentSuccessScreen(),
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

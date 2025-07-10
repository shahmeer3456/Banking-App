import 'package:flutter/material.dart';
import '../models/bill_model.dart';
import '../screens/bill_payment_successful.dart';
import '../services/transaction_service.dart';
import '../widgets/custom_elevatedbutton.dart';
import '../utilities/colors.dart';

class BillPaymentsScreen extends StatefulWidget {
  const BillPaymentsScreen({Key? key}) : super(key: key);

  @override
  _BillPaymentsScreenState createState() => _BillPaymentsScreenState();
}

class _BillPaymentsScreenState extends State<BillPaymentsScreen> {
  final _transactionService = TransactionService();
  bool _isLoading = false;
  List<Bill> _bills = [];

  @override
  void initState() {
    super.initState();
    _loadBills();
  }

  Future<void> _loadBills() async {
    setState(() => _isLoading = true);
    try {
      final bills = await _transactionService.getBills();
      if (mounted) {
        setState(() => _bills = bills);
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _handlePayBill(Bill bill) async {
    try {
      setState(() => _isLoading = true);
      final result = await _transactionService.payBill(
        billType: bill.provider.toLowerCase(),
        provider: bill.provider,
        customerNumber: bill.customerNumber,
        amount: bill.amount,
      );

      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BillPaymentSuccessfulScreen(
            amount: bill.amount.toStringAsFixed(2),
            provider: bill.provider,
            reference: result['transaction']['reference'],
          ),
        ),
      ).then((_) => _loadBills()); // Refresh bills list after returning
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bill Payments'),
        backgroundColor: AppColors.primaryColor,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _bills.isEmpty
              ? const Center(
                  child: Text('No bills to pay'),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: _bills.length,
                  itemBuilder: (context, index) {
                    final bill = _bills[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 16.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  bill.provider,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                Text(
                                  '\$${bill.amount.toStringAsFixed(2)}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        color: AppColors.primaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Bill Number: ${bill.billNumber}',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              'Due Date: ${bill.dueDate.toString().split(' ')[0]}',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 16),
                            CustomElevatedButton(
                              onPressed: () => _handlePayBill(bill),
                              child: const Text('Pay Now'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}

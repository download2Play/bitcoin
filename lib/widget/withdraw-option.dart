import 'package:flutter/material.dart';

class WithdrawOptionsDialog extends StatelessWidget {
  final Function(String) onOptionSelected;

  WithdrawOptionsDialog({required this.onOptionSelected});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      backgroundColor: Color(0xFFF2F2F7),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Select Withdrawal Method',
              style: TextStyle(
                color: Color(0xFF1C1C1E),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildOptionTile(context, 'PayPal', 'assets/images/paypal.png'),
            _buildOptionTile(context, 'Bank', 'assets/images/bank.png'),
            _buildOptionTile(context, 'Cash App', 'assets/images/cashapp.png'),
            _buildOptionTile(
                context, 'MasterCard', 'assets/images/mastercard.png'),
            _buildOptionTile(context, 'Visa', 'assets/images/visa.png'),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionTile(
      BuildContext context, String method, String assetPath) {
    return GestureDetector(
      onTap: () => onOptionSelected(method),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10.0,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Image.asset(assetPath, width: 40, height: 40),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  method,
                  style: TextStyle(
                    color: Color(0xFF1C1C1E),
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Account linked and verified',
                  style: TextStyle(
                    color: Color(0xFF8E8E93),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

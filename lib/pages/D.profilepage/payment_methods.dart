import 'package:flutter/material.dart';

class PaymentMethodsScreen extends StatefulWidget {
  final String selectedPayment;

  const PaymentMethodsScreen({
    super.key,
    required this.selectedPayment,
  });

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  late String selected;

  final List<String> methods = [
    "GoPay",
    "OVO",
    "BNI",
    "BRI",
    "Cash",
  ];

  @override
  void initState() {
    super.initState();
    selected = widget.selectedPayment;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1115),
      appBar: AppBar(
        title: const Text("Payment Methods"),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),

          Expanded(
            child: ListView.builder(
              itemCount: methods.length,
              itemBuilder: (context, index) {
                final method = methods[index];
                final isSelected = selected == method;

                return ListTile(
                  onTap: () {
                    setState(() {
                      selected = method;
                    });
                  },
                  title: Text(
                    method,
                    style: const TextStyle(color: Colors.white),
                  ),
                  trailing: isSelected
                      ? const Icon(Icons.check, color: Colors.blue)
                      : null,
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context, selected); // 🔥 RETURN KE PROFILE
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1D88F5),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text("Save"),
            ),
          )
        ],
      ),
    );
  }
}
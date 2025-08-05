import 'package:flutter/material.dart';
import 'package:e_commerce/src/model/product.dart';
import 'order_done_screen.dart';

class OrderScreen extends StatefulWidget {
  final List<Product> products;
  final int total;

  const OrderScreen({
    super.key,
    required this.products,
    required this.total,
  });

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Container(
              color: Colors.black12,
              child: Column(
                children: [
                  const Text(
                    "Products",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  ...widget.products.map((product) {
                    final int unitPrice =
                    product.off != null ? product.off! : product.price;
                    final int totalPrice = unitPrice * product.quantity;

                    return ListTile(
                      title: Text(
                        product.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      subtitle: Text(
                        'Quantity: ${product.quantity}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      trailing: Text(
                        '\$$totalPrice',
                        style: const TextStyle(fontSize: 20),
                      ),
                    );
                  }),
                  const Divider(height: 30, color: Colors.black, thickness: 2),
                  Text(
                    'Total: \$${widget.total}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            const Text(
              "Enter Your Information",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: UnderlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      }
                      if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: phoneController,
                    decoration: const InputDecoration(
                      labelText: 'Phone',
                      border: UnderlineInputBorder(),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Phone is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: addressController,
                    decoration: const InputDecoration(
                      labelText: 'Address',
                      border: UnderlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Address is required';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const OrderDoneScreen()),
                        (route) => false,
                  );
                }
              },
              child: const Text("Submit"),
            )
          ],
        ),
      ),
    );
  }
}

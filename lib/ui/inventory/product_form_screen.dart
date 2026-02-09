import 'package:flutter/material.dart';

class ProductFormScreen extends StatelessWidget {
  const ProductFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Product')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Text('Product form will be here.'),
      ),
    );
  }
}

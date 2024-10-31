import 'package:flutter/material.dart';
import 'package:pharma/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class ShoppingCartScreen extends StatelessWidget {
  const ShoppingCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'سلة التسوق',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF0D526A),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: cartProvider.itemCount == 0
          ? const Center(child: Text('سلتك فارغة'))
          : ListView.builder(
              itemCount: cartProvider.itemCount,
              itemBuilder: (context, index) {
                final item = cartProvider.cartItems[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: Image.asset(item['image']),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            item['name'],
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () {
                                cartProvider.removeItem(item);
                              },
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: const Text(
                                '1',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                cartProvider.addItem(item);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    subtitle: Text(item['price']),
                  ),
                );
              },
            ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Color(0xFF0D526A),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                foregroundColor: const Color(0xFF0D526A),
                backgroundColor: Colors.white,
              ),
              child: const Text('إتمام الشراء'),
            ),
            Text(
              'المجموع: ${cartProvider.totalPrice} LYD',
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

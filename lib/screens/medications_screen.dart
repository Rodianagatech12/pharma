import 'package:flutter/material.dart';
import 'package:pharma/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class MedicationsScreen extends StatelessWidget {
  final String categoryName;

  final Map<String, List<Map<String, dynamic>>> medicationsByCategory = {
    'العناية بالبشرة': [
      {
        'name': 'Effaclar Serum',
        'price': '75 LYD',
        'image': 'assets/pill/sero.png'
      },
      {
        'name': 'La Roche-Posay',
        'price': '110 LYD',
        'image': 'assets/pill/sun.png'
      },
      {
        'name': 'La Roche-Posay Cream',
        'price': '73 LYD',
        'image': 'assets/pill/sese.png'
      },
    ],
    'أدوية الجهاز الهضمي': [
      {
        'name': 'Omeprazole',
        'price': '50 LYD',
        'image': 'assets/pill/omeprazole.png'
      },
      {
        'name': 'Loperamide',
        'price': '30 LYD',
        'image': 'assets/pill/loperamide.png'
      },
    ],
  };

  MedicationsScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    final medications = medicationsByCategory[categoryName] ?? [];
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          categoryName,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF0D526A),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: medications.isEmpty
          ? const Center(child: Text('لا توجد أدوية في هذه الفئة'))
          : Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 2 / 3,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: medications.length,
                    itemBuilder: (context, index) {
                      final medication = medications[index];
                      final itemInCart = cartProvider.cartItems.firstWhere(
                        (item) => item['name'] == medication['name'],
                        orElse: () => {},
                      );

                      int itemCount = itemInCart.isNotEmpty
                          ? cartProvider.cartItems
                              .where(
                                  (item) => item['name'] == medication['name'])
                              .length
                          : 0;

                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => MedicationDetailScreen(
                                  medication: medication),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(12)),
                                  child: Image.asset(
                                    medication['image'],
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Icon(
                                      Icons.broken_image,
                                      size: 100,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      medication['name'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      medication['price'],
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.remove),
                                      onPressed: itemCount > 0
                                          ? () {
                                              cartProvider.cartItems
                                                  .remove(itemInCart);
                                              cartProvider.notifyListeners();
                                            }
                                          : null,
                                    ),
                                    Text(itemCount > 0 ? '$itemCount' : '0'),
                                    IconButton(
                                      icon: const Icon(Icons.add),
                                      onPressed: () {
                                        cartProvider.addItem(medication);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  color: const Color(0xFF0D526A),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'عدد القطع: ${cartProvider.itemCount}',
                            style: const TextStyle(color: Colors.white),
                          ),
                          Text(
                            'مجموع السعر: ${cartProvider.totalPrice} LYD',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: const Color(0xFF0D526A),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed('/cart');
                        },
                        child: const Row(
                          children: [
                            Icon(Icons.shopping_cart, color: Colors.white),
                            SizedBox(width: 8),
                            Text('عرض السلة',
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

class MedicationDetailScreen extends StatelessWidget {
  final Map<String, dynamic> medication;

  const MedicationDetailScreen({super.key, required this.medication});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(medication['name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              medication['image'],
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 16),
            Text(
              'اسم المنتج: ${medication['name']}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'السعر: ${medication['price']}',
              style: const TextStyle(fontSize: 18),
            ),
            // يمكنك إضافة مزيد من المعلومات عن المنتج هنا
          ],
        ),
      ),
    );
  }
}

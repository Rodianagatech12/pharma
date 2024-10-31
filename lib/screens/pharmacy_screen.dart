import 'package:flutter/material.dart';
import 'pharmacy_detail_screen.dart';

class PharmacyScreen extends StatelessWidget {
  const PharmacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          _buildPharmacyCard(
            context,
            'صيدلية الجود',
            'بنغازي, شارع الجود',
            'assets/pharmacy/aljoud.jpg',
            '0912365478',
            [
              {'name': 'Aspirin', 'price': '10 LYB'},
              {'name': 'Ibuprofen', 'price': '15 LYB'},
            ],
          ),
          _buildPharmacyCard(
            context,
            'صيدلية السعد',
            'بنغازي, شارع المركبات',
            'assets/pharmacy/saad.jpg',
            '0912365478',
            [
              {'name': 'Paracetamol', 'price': '8 LYB'},
              {'name': 'Naproxen', 'price': '12 LYB'},
            ],
          ),
          _buildPharmacyCard(
            context,
            'صيدلية بدر',
            'بنغازي, شارع دبي',
            'assets/pharmacy/badr.jpg',
            '0912365478',
            [
              {'name': 'Amoxicillin', 'price': '20 LYB'},
              {'name': 'Ciprofloxacin', 'price': '22 LYB'},
            ],
          ),
          _buildPharmacyCard(
            context,
            'صيدلية القلعة',
            'بنغازي, شارع 204 ',
            'assets/pharmacy/alqalaa.jpg',
            '0912365478',
            [
              {'name': 'Omeprazole', 'price': '18 LYB'},
              {'name': 'Simvastatin', 'price': '25 LYB'},
            ],
          ),
          _buildPharmacyCard(
            context,
            'صيدلية الرحيق ',
            'بنغازي',
            'assets/pharmacy/new.jpg',
            '0912365478',
            [
              {'name': 'Omeprazole', 'price': '18 LYB'},
              {'name': 'Simvastatin', 'price': '25 LYB'},
            ],
          ),
          _buildPharmacyCard(
            context,
            'صيدلية الماء الشافي',
            'بنغازي',
            'assets/pharmacy/water.jpg',
            '0912365478',
            [
              {'name': 'Omeprazole', 'price': '18 LYB'},
              {'name': 'Simvastatin', 'price': '25 LYB'},
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPharmacyCard(
    BuildContext context,
    String name,
    String address,
    String logoPath,
    String phoneNumber,
    List<Map<String, dynamic>> medications,
  ) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PharmacyDetailScreen(
                name: name,
                address: address,
                logoPath: logoPath,
                phoneNumber: phoneNumber,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.grey,
                          size: 20,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          address,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(
                          Icons.phone,
                          color: Colors.blue,
                          size: 20,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          phoneNumber,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.blue,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              ClipOval(
                child: Image.asset(
                  logoPath,
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

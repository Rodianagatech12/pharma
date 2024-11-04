import 'package:flutter/material.dart';
import 'package:pharma/screens/medications_screen.dart';

class PharmacyDetailScreen extends StatelessWidget {
  final String name;
  final String address;
  final String logoPath;
  final String phoneNumber;

  // قائمة فئات الأدوية مع الأسماء المترجمة إلى العربية
  final List<Map<String, dynamic>> categories = [
    {'name': 'العناية بالبشرة', 'icon': Icons.face},
    {'name': 'أدوية الجهاز الهضمي', 'icon': Icons.medical_services},
    {'name': 'أدوية الجهاز التنفسي', 'icon': Icons.air},
    {'name': 'أدوية السكري', 'icon': Icons.healing},
    {
      'name': 'أدوية الجهاز العصبي المركزي',
      'icon': Icons.medical_services_outlined
    },
    {'name': 'المضادات الحيوية', 'icon': Icons.local_hospital},
  ];

  PharmacyDetailScreen({
    super.key,
    required this.name,
    required this.address,
    required this.logoPath,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D526A),
        title: Text(
          name,
          style: const TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPharmacyInfo(),
          const Divider(thickness: 2, height: 40),
          _buildCategoryList(),
        ],
      ),
    );
  }

  Widget _buildPharmacyInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipOval(
            child: Image.asset(
              logoPath,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.broken_image,
                size: 100,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.blue),
                    const SizedBox(width: 8),
                    Text(
                      address,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.phone, color: Colors.blue),
                    const SizedBox(width: 8),
                    Text(
                      phoneNumber,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryList() {
    return Expanded(
      child: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return _buildCategoryCard(context, category);
        },
      ),
    );
  }

  Widget _buildCategoryCard(
      BuildContext context, Map<String, dynamic> category) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          category['name'],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: Icon(
          category['icon'],
          size: 40,
          color: Colors.blue,
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  MedicationsScreen(categoryName: category['name']),
            ),
          );
        },
      ),
    );
  }
}

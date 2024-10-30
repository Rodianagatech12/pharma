// import 'package:flutter/material.dart';

// import 'package:pharma/screens/medical_document_screen.dart';

// class MedicalHistoryScreen extends StatefulWidget {
//   const MedicalHistoryScreen({super.key});

//   @override
//   _MedicalHistoryScreenState createState() => _MedicalHistoryScreenState();
// }

// class _MedicalHistoryScreenState extends State<MedicalHistoryScreen> {
//   bool isEditing = false;
//   TextEditingController chronicDiseasesController = TextEditingController();
//   TextEditingController currentMedicationsController = TextEditingController();
//   TextEditingController allergiesController = TextEditingController();
//   TextEditingController appointmentRecordController = TextEditingController();
//   TextEditingController vaccinationsController = TextEditingController();
//   TextEditingController medicalDocumentController = TextEditingController();
//   TextEditingController notesController = TextEditingController();

//   void saveChanges() {
//     setState(() {
//       isEditing = false;
//       // Save the updated data here
//     });
//   }

//   void enableEditing() {
//     setState(() {
//       isEditing = true;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('التاريخ الطبي'),
//         backgroundColor: const Color(0xFF9CC2C3),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.edit),
//             onPressed: enableEditing,
//             tooltip: 'تعديل',
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 CircleAvatar(
//                   radius: 50,
//                   backgroundColor: Color(0xFF9CC2C3),
//                   child: Icon(Icons.person, size: 100, color: Colors.white),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             _buildMedicalSection('الأمراض المزمنة', chronicDiseasesController),
//             _buildMedicalSection(
//                 'الأدوية الحالية والسابقة', currentMedicationsController),
//             _buildMedicalSection('الحساسيات', allergiesController),
//             _buildMedicalSection(
//                 'سجل المواعيد الطبية', appointmentRecordController),
//             _buildMedicalSection('التطعيمات واللقاحات', vaccinationsController),
//             _buildMedicalSection('رفع مستند طبي', medicalDocumentController,
//                 isUploadField: true),
//             _buildMedicalSection('ملاحظات', notesController),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: isEditing ? saveChanges : null,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xB39CC2C3),
//                 minimumSize: const Size(
//                     double.infinity, 50), // Make the save button larger
//               ),
//               child: const Text('حفظ'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildMedicalSection(String title, TextEditingController controller,
//       {bool isUploadField = false}) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: const TextStyle(fontWeight: FontWeight.bold),
//             textDirection: TextDirection.rtl,
//           ),
//           if (isUploadField)
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => const MedicalDocumentsScreen()),
//                 );
//               },
//               child: const Text('رفع مستند طبي'),
//             )
//           else
//             TextField(
//               controller: controller,
//               enabled: isEditing,
//               textDirection: TextDirection.rtl,
//               decoration: InputDecoration(
//                 hintText: 'أدخل $title',
//                 filled: true,
//                 fillColor: const Color(0xFFE6E6E6),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

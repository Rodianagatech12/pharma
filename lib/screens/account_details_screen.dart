// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'medical_history_screen.dart';

// class AccountDetailsScreen extends StatefulWidget {
//   const AccountDetailsScreen({super.key});

//   @override
//   _AccountDetailsScreenState createState() => _AccountDetailsScreenState();
// }

// class _AccountDetailsScreenState extends State<AccountDetailsScreen> {
//   bool isEditing = false;
//   bool isPhoneValid = true;
//   bool isNameValid = true;
//   bool isBirthDateValid = true;

//   TextEditingController nameController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController birthDateController = TextEditingController();
//   TextEditingController phoneController = TextEditingController();
//   TextEditingController medicalHistoryController = TextEditingController();
//   TextEditingController locationController = TextEditingController();
//   TextEditingController notesController = TextEditingController();

//   String? gender;

//   @override
//   void initState() {
//     super.initState();
//     loadUserData();
//   }

//   void enableEditing() {
//     setState(() {
//       isEditing = true;
//     });
//   }

//   Future<void> saveChanges() async {
//     bool phoneValid = validatePhone(phoneController.text);
//     bool nameValid = validateName(nameController.text);
//     bool birthDateValid = validateBirthDate(birthDateController.text);

//     setState(() {
//       isPhoneValid = phoneValid;
//       isNameValid = nameValid;
//       isBirthDateValid = birthDateValid;
//     });

//     if (phoneValid && nameValid && birthDateValid) {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       await prefs.setString('name', nameController.text);
//       await prefs.setString('password', passwordController.text);
//       await prefs.setString('birthDate', birthDateController.text);
//       await prefs.setString('phone', phoneController.text);
//       await prefs.setString('medicalHistory', medicalHistoryController.text);
//       await prefs.setString('location', locationController.text);
//       await prefs.setString('notes', notesController.text);
//       await prefs.setString('gender', gender ?? '');

//       setState(() {
//         isEditing = false;
//       });
//     }
//   }

//   Future<void> loadUserData() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       nameController.text = prefs.getString('name') ?? '';
//       passwordController.text = prefs.getString('password') ?? '';
//       birthDateController.text = prefs.getString('birthDate') ?? '';
//       phoneController.text = prefs.getString('phone') ?? '';
//       medicalHistoryController.text = prefs.getString('medicalHistory') ?? '';
//       locationController.text = prefs.getString('location') ?? '';
//       notesController.text = prefs.getString('notes') ?? '';

//       String? savedGender = prefs.getString('gender');
//       gender =
//           (savedGender == 'ذكر' || savedGender == 'أنثى') ? savedGender : null;
//     });
//   }

//   bool validateName(String name) {
//     final nameRegExp = RegExp(r'^[a-zA-Z\u0621-\u064A\s]+$');
//     return nameRegExp.hasMatch(name);
//   }

//   bool validatePhone(String phone) {
//     final phoneRegExp = RegExp(r'^09\d-\d{7}$');
//     return phoneRegExp.hasMatch(phone);
//   }

//   bool validateBirthDate(String birthDate) {
//     final birthDateRegExp = RegExp(r'^\d{4}/\d{2}/\d{2}$');
//     return birthDateRegExp.hasMatch(birthDate);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Center(child: Text('تفاصيل الحساب')),
//         backgroundColor: const Color(0xFF0D526A),
//         foregroundColor: Colors.white, // تغيير لون النص إلى الأبيض
//         iconTheme: const IconThemeData(
//             color: Colors.white), // تغيير لون الأيقونات إلى الأبيض
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
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 CircleAvatar(
//                   radius: 50,
//                   backgroundColor: const Color(0xFF0D526A),
//                   child:
//                       const Icon(Icons.person, size: 100, color: Colors.white),
//                 ),
//                 const SizedBox(width: 16),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       nameController.text.isEmpty
//                           ? 'الاسم '
//                           : nameController.text,
//                       style: const TextStyle(
//                           fontSize: 24, fontWeight: FontWeight.bold),
//                       textDirection: TextDirection.rtl,
//                     ),
//                     Text(
//                       phoneController.text.isEmpty
//                           ? 'الهاتف'
//                           : phoneController.text,
//                       textDirection: TextDirection.rtl,
//                     ),
//                     Text(
//                       locationController.text.isEmpty
//                           ? 'العنوان'
//                           : locationController.text,
//                       textDirection: TextDirection.rtl,
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             const SizedBox(height: 24),
//             _buildTextField('الاسم ', 'الاسم بالكامل', nameController,
//                 isNameField: true),
//             _buildTextField(
//                 'كلمة المرور', 'أدخل كلمة المرور', passwordController),
//             _buildTextField('تاريخ الميلاد', 'أدخل تاريخ الميلاد (xxxx/xx/xx)',
//                 birthDateController,
//                 isBirthDateField: true),
//             _buildGenderDropdown(),
//             _buildTextField('الهاتف', '09x-xxxxxxx', phoneController,
//                 isPhoneField: true),
//             ListTile(
//               tileColor: const Color(0xFFE6E6E6),
//               leading: const Icon(Icons.arrow_back, color: Colors.blue),
//               title:
//                   const Text('التاريخ الطبي', textDirection: TextDirection.rtl),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => const MedicalHistoryScreen()),
//                 );
//               },
//             ),
//             _buildTextField('العنوان', 'تحديد العنوان', locationController),
//             _buildTextField(
//                 'ملاحظات', 'أدخل أي ملاحظات إضافية', notesController),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: isEditing ? saveChanges : null,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xB39CC2C3),
//                 minimumSize: const Size(double.infinity, 50),
//               ),
//               child: const Text('حفظ'),
//             ),
//             if (!isPhoneValid)
//               const Text(
//                 'يجب أن يكون رقم الهاتف بصيغة 09x-xxxxxxx',
//                 style: TextStyle(color: Colors.red),
//               ),
//             if (!isNameValid)
//               const Text(
//                 'يجب أن يحتوي الاسم على حروف فقط',
//                 style: TextStyle(color: Colors.red),
//               ),
//             if (!isBirthDateValid)
//               const Text(
//                 'صيغة تاريخ الميلاد غير صحيحة (يجب أن تكون xxxx/xx/xx)',
//                 style: TextStyle(color: Colors.red),
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField(
//       String label, String hint, TextEditingController controller,
//       {bool isPhoneField = false,
//       bool isNameField = false,
//       bool isBirthDateField = false}) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             label,
//             style: const TextStyle(fontWeight: FontWeight.bold),
//             textDirection: TextDirection.rtl,
//           ),
//           TextField(
//             controller: controller,
//             enabled: isEditing,
//             textDirection: TextDirection.rtl,
//             keyboardType:
//                 isPhoneField ? TextInputType.phone : TextInputType.text,
//             inputFormatters: isPhoneField
//                 ? [
//                     FilteringTextInputFormatter.allow(RegExp(r'[0-9-]')),
//                     LengthLimitingTextInputFormatter(11),
//                   ]
//                 : [],
//             decoration: InputDecoration(
//               hintText: hint,
//               filled: true,
//               fillColor: const Color(0xFFE6E6E6),
//               errorText: (isPhoneField && !isPhoneValid)
//                   ? 'الصيغة يجب أن تكون 09x-xxxxxxx'
//                   : (isNameField && !isNameValid)
//                       ? 'صيغة الاسم غير صحيحة'
//                       : (isBirthDateField && !isBirthDateValid)
//                           ? 'صيغة تاريخ الميلاد غير صحيحة'
//                           : null,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildGenderDropdown() {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'الجنس',
//             style: TextStyle(fontWeight: FontWeight.bold),
//             textDirection: TextDirection.rtl,
//           ),
//           DropdownButtonFormField<String>(
//             value: gender,
//             items: const [
//               DropdownMenuItem(value: 'ذكر', child: Text('ذكر')),
//               DropdownMenuItem(value: 'أنثى', child: Text('أنثى')),
//               DropdownMenuItem(value: 'غير محدد', child: Text('غير محدد')),
//             ],
//             onChanged: isEditing
//                 ? (value) {
//                     setState(() {
//                       gender = value;
//                     });
//                   }
//                 : null,
//             decoration: const InputDecoration(
//               filled: true,
//               fillColor: Color(0xFFE6E6E6),
//               hintText: 'حدد جنسك',
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

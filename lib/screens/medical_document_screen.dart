// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';

// class MedicalDocumentsScreen extends StatefulWidget {
//   const MedicalDocumentsScreen({super.key});

//   @override
//   _MedicalDocumentsScreenState createState() => _MedicalDocumentsScreenState();
// }

// class _MedicalDocumentsScreenState extends State<MedicalDocumentsScreen> {
//   List<String> documents = [];

//   Future<void> _addDocument() async {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return SimpleDialog(
//           title: const Text('اختر مصدر المستند'),
//           children: <Widget>[
//             SimpleDialogOption(
//               onPressed: () {
//                 Navigator.pop(context);
//                 _pickImage();
//               },
//               child: const Text('معرض الصور'),
//             ),
//             SimpleDialogOption(
//               onPressed: () {
//                 Navigator.pop(context);
//                 _pickFile();
//               },
//               child: const Text('ملفات الجهاز'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Future<void> _pickImage() async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? image = await picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       _uploadToFirebase(image.path);
//     }
//   }

//   Future<void> _pickFile() async {
//     final result = await FilePicker.platform.pickFiles();
//     if (result != null && result.files.single.path != null) {
//       _uploadToFirebase(result.files.single.path!);
//     }
//   }

//   Future<void> _uploadToFirebase(String path) async {
//     try {
//       String fileName = path.split('/').last;
//       Reference ref =
//           FirebaseStorage.instance.ref().child('medical_documents/$fileName');
//       UploadTask uploadTask = ref.putFile(File(path));

//       final snapshot = await uploadTask.whenComplete(() {});
//       final url = await snapshot.ref.getDownloadURL();

//       setState(() {
//         documents.add(url);
//       });
//     } catch (e) {
//       print(e.toString());
//       // Handle error
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('المستندات الطبية'),
//         backgroundColor: const Color(0xFF9CC2C3),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.add),
//             onPressed: _addDocument,
//           ),
//         ],
//       ),
//       body: documents.isEmpty
//           ? const Center(
//               child: Text(
//                 'لا يوجد مستندات',
//                 style: TextStyle(color: Colors.grey),
//               ),
//             )
//           : ListView.builder(
//               itemCount: documents.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(documents[index]),
//                 );
//               },
//             ),
//     );
//   }
// }

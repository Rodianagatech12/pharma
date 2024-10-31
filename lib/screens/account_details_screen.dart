import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pharma/providers/authentication_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountDetailsScreen extends StatefulWidget {
  const AccountDetailsScreen({super.key});

  @override
  _AccountDetailsScreenState createState() => _AccountDetailsScreenState();
}

class _AccountDetailsScreenState extends State<AccountDetailsScreen> {
  bool isEditing = false;
  bool isPhoneValid = true;
  bool isNameValid = true;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  String? gender;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  void enableEditing() {
    setState(() {
      isEditing = true;
    });
  }

  Future<void> saveChanges() async {
    bool phoneValid = validatePhone(phoneController.text);
    bool nameValid = validateName(nameController.text);

    setState(() {
      isPhoneValid = phoneValid;
      isNameValid = nameValid;
    });

    if (phoneValid && nameValid) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('name', nameController.text);
      await prefs.setString('phone', phoneController.text);
      await prefs.setString('location', locationController.text);
      await prefs.setString('notes', notesController.text);
      await prefs.setString('gender', gender ?? '');

      // تحديث اسم المستخدم في AuthenticationProvider
      Provider.of<AuthenticationProvider>(context, listen: false)
          .updateUserName(nameController.text);

      setState(() {
        isEditing = false;
      });

      loadUserData();
    }
  }

  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      nameController.text = prefs.getString('name') ?? '';
      phoneController.text = prefs.getString('phone') ?? '';
      locationController.text = prefs.getString('location') ?? '';
      notesController.text = prefs.getString('notes') ?? '';

      String? savedGender = prefs.getString('gender');
      gender =
          (savedGender == 'ذكر' || savedGender == 'أنثى') ? savedGender : null;
    });
  }

  bool validateName(String name) {
    final nameRegExp = RegExp(r'^[a-zA-Z\u0621-\u064A\s]+$');
    return nameRegExp.hasMatch(name);
  }

  bool validatePhone(String phone) {
    final phoneRegExp = RegExp(r'^09\d-\d{7}$');
    return phoneRegExp.hasMatch(phone);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('تفاصيل الحساب')),
        backgroundColor: const Color(0xFF0D526A),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: enableEditing,
            tooltip: 'تعديل',
          ),
        ],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileHeader(),
              const SizedBox(height: 24),
              if (isEditing) _buildEditForm(),
              if (!isEditing) _buildUserInfo(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: const Color(0xFF0D526A),
          child: const Icon(Icons.person, size: 100, color: Colors.white),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isEditing
                    ? 'تعديل الاسم'
                    : nameController.text.isEmpty
                        ? 'الاسم'
                        : nameController.text,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textDirection: TextDirection.rtl,
              ),
              const SizedBox(height: 4),
              if (!isEditing) ...[
                Text(
                  phoneController.text.isEmpty
                      ? 'الهاتف'
                      : phoneController.text,
                  textDirection: TextDirection.ltr,
                ),
                Text(
                  locationController.text.isEmpty
                      ? 'العنوان'
                      : locationController.text,
                  textDirection: TextDirection.ltr,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUserInfo() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _buildInfoTile('الهاتف',
                phoneController.text.isEmpty ? 'الهاتف' : phoneController.text),
            _buildInfoTile(
                'العنوان',
                locationController.text.isEmpty
                    ? 'العنوان'
                    : locationController.text),
            _buildInfoTile('الجنس', gender ?? 'غير محدد'),
            _buildInfoTile(
                'الملاحظات',
                notesController.text.isEmpty
                    ? 'ملاحظات'
                    : notesController.text),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(
            child: Text(value, textDirection: TextDirection.rtl),
          ),
        ],
      ),
    );
  }

  Widget _buildEditForm() {
    return Column(
      children: [
        _buildTextField('الاسم', 'الاسم بالكامل', nameController,
            isNameField: true),
        _buildTextField('الهاتف', '09x-xxxxxxx', phoneController,
            isPhoneField: true),
        _buildGenderDropdown(),
        _buildTextField('العنوان', 'تحديد العنوان', locationController),
        _buildTextField('ملاحظات', 'أدخل أي ملاحظات إضافية', notesController),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: saveChanges,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xB39CC2C3),
            minimumSize: const Size(double.infinity, 50),
          ),
          child: const Text('حفظ'),
        ),
        if (!isPhoneValid)
          const Text(
            'يجب أن يكون رقم الهاتف بصيغة 09x-xxxxxxx',
            style: TextStyle(color: Colors.red),
          ),
        if (!isNameValid)
          const Text(
            'يجب أن يحتوي الاسم على حروف فقط',
            style: TextStyle(color: Colors.red),
          ),
      ],
    );
  }

  Widget _buildTextField(
      String label, String hint, TextEditingController controller,
      {bool isPhoneField = false, bool isNameField = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFE6E6E6),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                label,
                style: const TextStyle(fontWeight: FontWeight.bold),
                textDirection: TextDirection.rtl,
              ),
            ),
            TextField(
              controller: controller,
              enabled: isEditing,
              textDirection: TextDirection.rtl,
              keyboardType:
                  isPhoneField ? TextInputType.phone : TextInputType.text,
              inputFormatters: isPhoneField
                  ? [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9-]')),
                      LengthLimitingTextInputFormatter(11),
                    ]
                  : [],
              decoration: InputDecoration(
                hintText: hint,
                border: InputBorder.none,
                errorText: (isPhoneField && !isPhoneValid)
                    ? 'الصيغة يجب أن تكون 09x-xxxxxxx'
                    : (isNameField && !isNameValid)
                        ? 'صيغة الاسم غير صحيحة'
                        : null,
              ),
              cursorColor: const Color(0xFF0D526A),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderDropdown() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFE6E6E6),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        value: gender,
        decoration: InputDecoration(
          labelText: 'الجنس',
          fillColor: Colors.transparent,
          border: InputBorder.none,
        ),
        onChanged: isEditing
            ? (String? newValue) {
                setState(() {
                  gender = newValue;
                });
              }
            : null,
        items: <String>['ذكر', 'أنثى', 'غير محدد']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}

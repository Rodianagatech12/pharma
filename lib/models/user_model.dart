class CustomUser {
  final String id;
  final String email;
  final String username; // إضافة حقل اسم المستخدم
  final String birthDate; // إضافة حقل تاريخ الميلاد
  final String gender; // إضافة حقل الجنس

  CustomUser({
    required this.id,
    required this.email,
    required this.username,
    required this.birthDate,
    required this.gender,
  });
}

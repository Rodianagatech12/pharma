import 'package:flutter/material.dart';

class AddPillScreen extends StatefulWidget {
  const AddPillScreen({super.key});

  @override
  _AddPillScreenState createState() => _AddPillScreenState();
}

class _AddPillScreenState extends State<AddPillScreen> {
  final TextEditingController _pillNameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  String _selectedPillForm = 'Tablet';

  TimeOfDay _selectedTime = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
        _timeController.text = _selectedTime.format(context);
      });
    }
  }

  void _saveTask() {
    Map<String, dynamic> taskData = {
      'pillName': _pillNameController.text,
      'amount': _amountController.text,
      'time': _selectedTime.format(context),
      'description': _descriptionController.text,
      'pillForm': _selectedPillForm,
    };

    Navigator.pop(context, taskData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D526A),
        title: const Text(
          'إضافة دواء',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  'assets/without.png',
                  height: 200,
                  width: 300,
                ),
                const SizedBox(height: 20),
                const Text(
                  'إضافة دواء',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _pillNameController,
                  decoration: const InputDecoration(
                    labelText: 'اسم الدواء',
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _amountController,
                  decoration: const InputDecoration(
                    labelText: 'الكمية',
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () => _selectTime(context),
                  child: AbsorbPointer(
                    child: TextField(
                      controller: _timeController,
                      decoration: const InputDecoration(
                        labelText: 'اختر الوقت',
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'وصف إضافي',
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  ),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: _selectedPillForm,
                  decoration: const InputDecoration(
                    labelText: 'شكل الدواء',
                    border: OutlineInputBorder(),
                  ),
                  items: ['Tablet', 'Injection', 'Capsule']
                      .map((form) => DropdownMenuItem(
                            value: form,
                            child: Text(form),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedPillForm = value!;
                    });
                  },
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _saveTask,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0D526A),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 40),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: const Text('إضافة تذكير'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

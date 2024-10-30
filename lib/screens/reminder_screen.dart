import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pharma/screens/add_pill_screen.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({super.key});

  @override
  _ReminderScreenState createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  DatePickerController dateController = DatePickerController();
  DateTime _selectedDateValue = DateTime.now();

  List<TimeOfDay?> selectedTimes = [null];
  List<TextEditingController> pillControllers = [
    TextEditingController(text: '1')
  ];
  List<String> taskNames = ["Task 1"];
  List<bool> isMedication = [true];
  List<bool> isTaken = [false]; // إضافة حقل لتتبع حالة أخذ الدواء

  String _formatDate(DateTime date) {
    return DateFormat.yMMMM().format(date);
  }

  Future<void> _selectTime(BuildContext context, int index) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTimes[index] ?? TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTimes[index]) {
      setState(() {
        selectedTimes[index] = picked;
      });
    }
  }

  void _addNewTask(String taskName, String amount, String time,
      String description, bool medication) {
    setState(() {
      taskNames.add(taskName);
      pillControllers.add(TextEditingController(text: amount));
      selectedTimes.add(TimeOfDay.now());
      isMedication.add(medication);
      isTaken.add(false); // إضافة حالة أخذ الدواء
    });
  }

  void _deleteTask(int index) async {
    final confirmDelete = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("تأكيد الحذف"),
        content: const Text("هل أنت متأكد أنك تريد حذف هذا التذكير؟"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text("إلغاء"),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text("حذف"),
          ),
        ],
      ),
    );

    if (confirmDelete) {
      setState(() {
        taskNames.removeAt(index);
        pillControllers.removeAt(index);
        selectedTimes.removeAt(index);
        isMedication.removeAt(index);
        isTaken.removeAt(index); // إزالة حالة أخذ الدواء
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Text(
                    _formatDate(_selectedDateValue),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_drop_down),
                    onPressed: () {
                      showDatePicker(
                              context: context,
                              initialDate: _selectedDateValue,
                              firstDate: DateTime.now(),
                              lastDate:
                                  DateTime.now().add(const Duration(days: 365)))
                          .then((selectedDate) {
                        if (selectedDate != null) {
                          setState(() {
                            _selectedDateValue = selectedDate;
                          });
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: DatePicker(
                height: 70,
                width: 50,
                _selectedDateValue,
                controller: dateController,
                dayTextStyle: const TextStyle(fontSize: 10),
                dateTextStyle: const TextStyle(fontSize: 10),
                monthTextStyle: const TextStyle(fontSize: 12),
                initialSelectedDate: DateTime.now(),
                selectionColor: const Color(0xFF0D526A),
                onDateChange: (date) {
                  setState(() {
                    _selectedDateValue = date;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 242, 245, 244),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(2.0),
                  topRight: Radius.circular(2.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.add, color: Color(0xFF0D526A)),
                          onPressed: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AddPillScreen()),
                            );

                            if (result != null) {
                              _addNewTask(
                                result['pillName'],
                                result['amount'],
                                result['time'],
                                result['description'],
                                result['isMedication'] ?? true,
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('تم إضافة التذكير بنجاح!')),
                              );
                            }
                          },
                        ),
                        const Text(
                          "مواعيد دوائك",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0D526A),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ...List.generate(taskNames.length, (index) {
                      return Column(
                        children: [
                          _buildAlarmTile(index),
                          const SizedBox(height: 10),
                          const Divider(), // إضافة فاصل بين المهام
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAlarmTile(int index) {
    return Container(
      decoration: BoxDecoration(
        color: isMedication[index]
            ? const Color.fromARGB(255, 255, 255, 255)
            : const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    taskNames[index],
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (isMedication[index]) ...[
                    Text(
                      "${pillControllers[index].text} Pill(s)",
                      style: const TextStyle(color: Colors.black),
                    ),
                  ] else ...[
                    const Text(
                      "Task Details",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                  // إضافة حالة أخذ الدواء
                  Row(
                    children: [
                      Icon(
                        isTaken[index]
                            ? Icons.check_circle
                            : Icons.check_circle_outline,
                        color: isTaken[index] ? Colors.green : Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        isTaken[index] ? "أُخذ" : "لم يُؤخذ",
                        style: TextStyle(
                          color: isTaken[index] ? Colors.green : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.access_time, color: Colors.black),
              onPressed: () {
                _selectTime(context, index);
              },
            ),
            if (selectedTimes[index] != null)
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  selectedTimes[index]!.format(context),
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            // إضافة زر لتغيير حالة أخذ الدواء
            IconButton(
              icon: const Icon(Icons.check, color: Colors.blue),
              onPressed: () {
                setState(() {
                  isTaken[index] = !isTaken[index]; // تغيير حالة أخذ الدواء
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                _deleteTask(index);
              },
            ),
          ],
        ),
      ),
    );
  }
}

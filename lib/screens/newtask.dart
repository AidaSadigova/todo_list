import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_list/models/todo_model.dart';
import 'package:todo_list/providers/providers.dart';
import 'package:todo_list/screens/homepage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/utils/helpers.dart';

class AddTask extends ConsumerWidget {
  final Function(Task) onSave;

  const AddTask({super.key, required this.onSave});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    DateTime date = ref.watch(dateProvider);
    TimeOfDay time = ref.watch(timeProvider);

    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.purple, Color.fromARGB(255, 8, 96, 168)])),
      child: Scaffold(
        extendBody: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              icon: const FaIcon(
                FontAwesomeIcons.arrowLeft,
                color: Colors.white,
              )),
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          children: [
            const Text(
              'New Task',
              style: TextStyle(fontSize: 25.0, color: Colors.white),
            ),
            const Divider(
              thickness: 1,
              indent: 30,
              endIndent: 30,
              color: Colors.white70,
            ),
            NewTaskPage(titleController, "Add new task..."),
            NewTaskPage(descriptionController, "Add a decription..."),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: DateFormat.yMMMMd().format(date),
                        fillColor: Colors.white,
                        suffixIcon: IconButton(
                            onPressed: () {
                              _selectDate(context, ref);
                            },
                            icon: const Icon(Icons.calendar_month)),
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8.0),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: Helpers.timeToString(time),
                        fillColor: Colors.white,
                        suffixIcon: IconButton(
                            onPressed: () {
                              _selectTime(context, ref);
                            },
                            icon: const Icon(Icons.timer)),
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8.0),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        final task = Task(
                          title: titleController.text,
                          description: descriptionController.text,
                          date: date,
                          time: time,
                        );
                        onSave(task);
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Save',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _selectTime(BuildContext context, WidgetRef ref) async {
  TimeOfDay? pickedTime = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );

  if (pickedTime != null) {
    ref.read(timeProvider.notifier).state = pickedTime;
  }
}

void _selectDate(BuildContext context, WidgetRef ref) async {
  DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2023),
    lastDate: DateTime(2090),
  );

  if (pickedDate != null) {
    ref.read(dateProvider.notifier).state = pickedDate;
  }
}

Padding NewTaskPage(TextEditingController controller, String hintText) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: Colors.white,
        filled: true,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(color: Colors.white),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(color: Colors.white),
        ),
      ),
    ),
  );
}

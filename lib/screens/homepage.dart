import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:todo_list/models/todo_model.dart';
import 'package:todo_list/screens/newtask.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/utils/helpers.dart';
import 'package:todo_list/widgets/drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selectedDate = DateTime.now();
  List<Task> tasks = [];

  void _addTask(Task task) {
    setState(() {
      tasks.add(task);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color.fromARGB(255, 8, 96, 168), Colors.purple])),
      child: Scaffold(
        extendBody:
            true, //eger bunu yazmasam, add new task+ hissesinde arxa fon gorunmur
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: Builder(builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(
                Icons.menu,
                color: Colors.grey[200],
              ),
            );
          }),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(
                FontAwesomeIcons.squareCheck,
                color: Colors.grey[200],
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                'To-do',
                style: TextStyle(color: Colors.grey[200], fontSize: 22.0),
              ),
            ],
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: FaIcon(FontAwesomeIcons.bell, color: Colors.grey[200])),
          ],
        ),
        drawer: DrawerPage(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Divider(
                thickness: 1.0,
                color: Colors.white70,
              ),
              CalendarTimeline(
                initialDate: DateTime(2020, 4, 20),
                firstDate: DateTime(2019, 1, 15),
                lastDate: DateTime(2020, 11, 20),
                onDateSelected: (date) => print(date),
                leftMargin: 20,
                monthColor: Colors.blueGrey,
                dayColor: Colors.teal[200],
                activeDayColor: Colors.white,
                activeBackgroundDayColor:
                    const Color.fromARGB(255, 223, 140, 238),
                dotsColor: Color(0xFF333A47),
                selectableDayPredicate: (date) => date.day != 23,
                locale: 'en_ISO',
              ),
              const Divider(
                thickness: 1.0,
                color: Colors.white70,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Text(
                      'All',
                      style:
                          TextStyle(color: Colors.green[300], fontSize: 20.0),
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 1.0,
                color: Colors.white70,
                indent: 10,
                endIndent: 360,
              ),
              ListView.builder(
                physics:
                    const NeverScrollableScrollPhysics(), // when i used shrinkWrap, i wasn't able to scroll whole page. for this i should add this "physics".
                shrinkWrap:
                    true, // If i want to write listview.builder inside singlescroll child, then i should use "shrinkWrap".
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return Dismissible(
                    direction: DismissDirection.endToStart,
                    key: Key(task.toString()),
                    onDismissed: (direction) {
                      setState(() {
                        tasks.removeAt(index);
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Task completed")));
                    },
                    background: Container(
                        color: const Color.fromARGB(255, 123, 141, 241)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: 350,
                            height: 130,
                            decoration: BoxDecoration(
                              color: Colors.deepPurple[200],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  task.title,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 20.0),
                                ),
                                Text(
                                  task.description,
                                  style: const TextStyle(
                                      color: Colors.white70, fontSize: 15.0),
                                ),
                                const Divider(
                                  thickness: 1.0,
                                  color: Colors.white70,
                                ),
                                Text(
                                  Helpers.timeToString(task.time),
                                  style: const TextStyle(color: Colors.white),
                                ),
                                Text(
                                  DateFormat.yMMMMd().format(task.date),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 50,
          margin: const EdgeInsets.only(left: 50, right: 50, bottom: 20),
          decoration: BoxDecoration(
            color: Colors.indigo[400],
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
              child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddTask(onSave: _addTask)),
              );
            },
            child: Text('Add new task +',
                style: TextStyle(color: Colors.grey[200], fontSize: 25.0)),
          )),
        ),
      ),
    );
  }
}

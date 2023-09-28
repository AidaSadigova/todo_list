import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_list/models/profile_model.dart';
import 'package:todo_list/screens/homepage.dart';
import 'package:todo_list/screens/profile_screen.dart';

class DrawerPage extends StatefulWidget {
  DrawerPage({Key? key}) : super(key: key);

  final GlobalKey<_DrawerPageState> drawerPageKey =
      GlobalKey<_DrawerPageState>();

  void updateProfileInfo(Profile info) {
    drawerPageKey.currentState?._addProfileInfo(info);
  }

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  List<Profile> infos = [];

  void _addProfileInfo(Profile info) {
    setState(() {
      infos.add(info);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 280,
            child: DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.purple, Color.fromARGB(255, 8, 96, 168)],
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 40.0,
                        backgroundImage: NetworkImage(
                            'https://i.pinimg.com/originals/ed/0f/29/ed0f29d98b934efd208bc4815f96e702.png'),
                      ),
                      const SizedBox(
                        width: 40.0,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Container(
                          width: 110,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 180, 144, 247),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MyProfile(
                                        onSave: _addProfileInfo,
                                        drawerPage: DrawerPage(),
                                      ),
                                    ),
                                  );
                                },
                                child: const Text('edit profile',
                                    style: TextStyle(
                                        fontSize: 18.0, color: Colors.white)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: infos.length,
                    itemBuilder: (context, index) {
                      final info = infos[index];
                      return ListTile(
                        title: Text(
                          info.name,
                          style: const TextStyle(
                              fontSize: 18.0, color: Colors.white),
                        ),
                        subtitle: Text(
                          info.mail,
                          style: const TextStyle(
                              fontSize: 16.0, color: Colors.white),
                        ),
                        trailing: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.copy, color: Colors.white)),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.home,
            ),
            title: const Text('Home'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.share,
            ),
            title: const Text('Tell friends'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.info),
            title: const Text('Information'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.settings,
            ),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

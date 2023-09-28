import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_list/models/profile_model.dart';
import 'package:todo_list/screens/homepage.dart';
import 'package:todo_list/widgets/drawer.dart';

class MyProfile extends StatefulWidget {
  final Function(Profile) onSave;

  final DrawerPage drawerPage;
  const MyProfile({
    Key? key,
    required this.onSave,
    required this.drawerPage,
  }) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final double coverHeight = 300;
  final double profileHeight = 150;

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController mailController = TextEditingController();
    final top = coverHeight - profileHeight / 2;

    return Scaffold(
      body: ListView(padding: EdgeInsets.zero, children: [
        buildTop(top),
        const SizedBox(
          height: 100,
        ),
        NewProfile(nameController, "Add your name and surname..."),
        NewProfile(mailController, "Add your mail..."),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              final prof = Profile(
                name: nameController.text,
                mail: mailController.text,
              );
              widget.onSave(prof);
              widget.drawerPage.updateProfileInfo(prof);
              Navigator.of(context).pop();
            },
            child: const Text(
              'Save',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        ),
      ]),
    );
  }

  Stack buildTop(double top) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        buildCoverImage(),
        Positioned(top: top, child: buildProfileImage()),
      ],
    );
  }

  buildCoverImage() => Container(
        width: double.infinity,
        height: coverHeight,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [
            0.2,
            0.6,
            0.9,
          ],
          colors: [
            Colors.purple,
            Color.fromARGB(255, 228, 161, 184),
            Colors.indigo,
          ],
        )),
        child: IconButton(
            onPressed: () {
              Navigator.pop(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
            icon: const FaIcon(
              FontAwesomeIcons.arrowLeft,
              color: Colors.white,
              size: 50,
            )),
      );

  buildProfileImage() => CircleAvatar(
        radius: profileHeight / 2 + 8,
        backgroundColor: Colors.white,
        child: CircleAvatar(
          radius: profileHeight / 2,
          backgroundImage: const NetworkImage(
              'https://i.pinimg.com/originals/ed/0f/29/ed0f29d98b934efd208bc4815f96e702.png'),
        ),
      );
}

Padding NewProfile(TextEditingController controller, String hintText) {
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
          borderSide: const BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
    ),
  );
}

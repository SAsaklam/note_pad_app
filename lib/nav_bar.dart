import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_pad_app/note_Controler.dart';
import 'package:note_pad_app/favorite.dart';
import 'package:note_pad_app/note.dart';
import 'package:note_pad_app/note_model.dart';
import "package:intl/intl.dart";

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  List<Widget> pages = [Note(), Favorite()];
  int _currentIndex = 0;
  NoteControler noteControler = Get.put(NoteControler());
  TextEditingController titleclt = TextEditingController();
  TextEditingController contentclt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(84, 243, 33, 33),
        child: Icon(Icons.add),
        onPressed: () {
          viewDialouge();
        },
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.brown,
        unselectedItemColor: Colors.blueGrey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.note), label: 'Notes'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'favorites',
          ),
        ],
      ),
    );
  }

  viewDialouge() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: AlertDialog(
            content: Column(
              children: [
                TextField(
                  controller: titleclt,
                  decoration: InputDecoration(hintText: 'Input a title'),
                ),
                TextField(
                  controller: contentclt,
                  decoration: InputDecoration(hintText: 'Input a content'),
                ),
              ],
            ),

            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.brown,
                  foregroundColor: Colors.white,
                ),

                onPressed: () {
                  if (titleclt.text.isNotEmpty && contentclt.text.isNotEmpty) {
                    DateTime now = DateTime.now();

                    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
                    NoteModel note = NoteModel(
                      formattedDate,
                      titleclt.text,
                      contentclt.text,
                    );
                    noteControler.addNote(note);
                    Navigator.pop(context);
                  }
                },
                child: Text("Save"),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.brown,
                  foregroundColor: Colors.white,
                ),

                onPressed: () {},
                child: Text("Cancell"),
              ),
            ],
          ),
        );
      },
    );
  }
}

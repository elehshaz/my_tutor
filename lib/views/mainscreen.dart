import 'package:flutter/material.dart';


class MainScreen extends StatefulWidget {
  
  const MainScreen({Key? key,}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text("Shahida Sharizal"),
              accountEmail: Text("shahida_shrzl@yahoo.com"),

              currentAccountPicture: const CircleAvatar(
                backgroundImage: AssetImage('assets/images/registration.png'),
              ),
            ),
            _createDrawerItem(
              icon: Icons.book,
              text: 'E-book',
              onTap: () {},
            ),
            _createDrawerItem(
              icon: Icons.subject,
              text: 'Subject',
              onTap: () {},
            ),
          ],
        ),
      ),
     
    );
  }

  Widget _createDrawerItem(
      {required IconData icon,
      required String text,
      required GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text),
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}

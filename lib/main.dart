import 'package:flutter/material.dart';
import 'package:mirchaye/widgets/drawer.dart';
import 'screens/home_screen.dart';
import 'screens/party_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eth',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        fontFamily: 'Roboto',
      ),
      home: MainTabs(),
    );
  }
}

class MainTabs extends StatefulWidget {
  @override
  _MainTabsState createState() => _MainTabsState();
}

class _MainTabsState extends State<MainTabs> {
  int _index = 0;
  final screens = [HomeScreen(), PartyListScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const FancyDrawer(),
      body: screens[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: "News"),
          BottomNavigationBarItem(icon: Icon(Icons.groups), label: "Parties"),
        ],
      ),
    );
  }
}

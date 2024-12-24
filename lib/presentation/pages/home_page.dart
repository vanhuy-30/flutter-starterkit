import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/presentation/components/mocules/navigation/appbar.dart';
import 'package:flutter_starter_kit/presentation/components/mocules/navigation/bottom_navigation_bar.dart';
import 'package:flutter_starter_kit/presentation/components/mocules/navigation/tabbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  TextEditingController controller = TextEditingController();

  late TabController _tabController;

  final List<Tab> tabs = const [
    Tab(icon: Icon(Icons.home), text: 'Home'),
    Tab(icon: Icon(Icons.search), text: 'Search'),
    Tab(icon: Icon(Icons.settings), text: 'Settings'),
  ];

  final List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  void onBottomNavTap(int index) {
    setState(() {
      _tabController.index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.title),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTabbar(tabs: tabs, tabController: _tabController),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Center(child: Text('Home Page')),
                Center(child: Text('Search Page')),
                Center(child: Text('Settings Page')),
              ],
            ),
          ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(currentIndex: _tabController.index, onTap: onBottomNavTap, items: items),
    );
  }
}

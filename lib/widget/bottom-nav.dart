import 'package:bitcoin/blockchain.dart';
import 'package:bitcoin/withdraw.dart';
import 'package:flutter/material.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import '../settings.dart';

class CButtomNav extends StatefulWidget {
  const CButtomNav({Key? key}) : super(key: key);

  @override
  State<CButtomNav> createState() => _ButtomNavState();
}

class _ButtomNavState extends State<CButtomNav> {
  int _currentPageIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      Blockchain(),
      BlockchainStatsScreen(),
      SettingsScreen(),
      SettingsScreen(),
    ];

    return Scaffold(
      extendBody: true,
      body: PageView(
        controller: _pageController,
        children: screens,
        onPageChanged: (int index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
            bottom: 10, right: 32, left: 32), // Adjusted bottom padding
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 118, 210, 247),
            borderRadius: BorderRadius.circular(30.0),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 182, 167, 247).withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: BottomBarFloating(
              items: const [
                TabItem(icon: Icons.search),
                TabItem(icon: Icons.area_chart_outlined),
                TabItem(icon: Icons.settings),
                TabItem(icon: Icons.support_agent),
              ],
              indexSelected: _currentPageIndex,
              onTap: (int index) {
                setState(() {
                  _currentPageIndex = index;
                  _pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                });
              },
              backgroundColor: Colors.transparent,
              color: Color.fromARGB(255, 26, 5, 73),
              colorSelected: Color.fromARGB(255, 22, 43, 136),
            ),
          ),
        ),
      ),
    );
  }
}

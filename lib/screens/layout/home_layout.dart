import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:internir/providers/index_provider.dart';
import 'package:internir/screens/home/home_screen.dart';
import 'package:internir/utils/app_assets.dart';
import 'package:internir/utils/app_color.dart';
import 'package:provider/provider.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  var pages = [
    const HomeScreen(),
    Container(),
    Container(),
    Container(),
  ];

  @override
  Widget build(BuildContext context) {
    var indexProvider = Provider.of<IndexProvider>(context);
    return Scaffold(
      body: pages[indexProvider.index],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        currentIndex: indexProvider.index,
        onTap: (index) {
          indexProvider.setIndex(index);
        },
        backgroundColor: AppColor.background,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppAssets.homeIcon),
            label: "Home",
            activeIcon: SvgPicture.asset(AppAssets.homeOpenIcon),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(AppAssets.applyListImage),
            label: "Apply List",
            activeIcon: Image.asset(AppAssets.applyListOpenImage),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(AppAssets.savedImage),
            label: "Saved",
            activeIcon: Image.asset(AppAssets.savedOpenImage),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(AppAssets.profileImage),
            label: "Profile",
            activeIcon: Image.asset(AppAssets.profileOpenImage),
          ),
        ],
      ),
    );
  }
}

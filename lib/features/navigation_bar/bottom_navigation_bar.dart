import 'package:flutter/material.dart';
import 'package:nasa_apod_viewer/core/data/local/colors.dart';
import 'package:nasa_apod_viewer/features/favorite_page/favorites.dart';
import 'package:nasa_apod_viewer/features/home_page/home.dart';
import 'package:nasa_apod_viewer/features/search_page/search.dart';

class BottomNavbar extends StatelessWidget{
  const BottomNavbar({
    this.pageIndex = 0,
    super.key
  });

  final int pageIndex;

  void _redirect(BuildContext context, int index){
    switch (index){
      case 0:
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, _, __) => Home()
          )
        );
        return;
      case 1:
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, _, __) => Favorites()
          )
        );
        return;
      case 2:
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, _, __) => Search()
          )
        );
        return;
      default:
        return;
    }
  }

  @override
  Widget build(BuildContext context){ 
    return BottomNavigationBar(
      backgroundColor: const Color(0xFFFFFFFF),
      currentIndex: pageIndex,
      selectedLabelStyle: const TextStyle(color: DARK_BLUE),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      iconSize: 24,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          activeIcon: Icon(
            Icons.home,
            color: DARK_BLUE,
          ),
          icon: Icon(
            Icons.home_outlined
          ),
          label: 'Home'
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(
            Icons.favorite,
            color: DARK_BLUE,
          ),
          icon: Icon(
            Icons.favorite_border
          ),
          label: 'Favorites'
        ),
        BottomNavigationBarItem(
          activeIcon: Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: DARK_BLUE
            ),
            child: Icon(
              Icons.search,
              color: WHITE,
            ),
          ),
          icon: Icon(
            Icons.search
          ),
          label: 'Search'
        ),
      ],
      onTap: (int index) {
        if (index != pageIndex) {
          _redirect(context, index);
        }
      },
      
    );
  }
}
import 'package:flutter/material.dart';
import 'package:nasa_apod_viewer/core/data/local/colors.dart';
import 'package:nasa_apod_viewer/features/home_page/components/home_persistent_header_delegate.dart';
import 'package:nasa_apod_viewer/features/home_page/components/home_title.dart';
import 'package:nasa_apod_viewer/features/home_page/components/more_info.dart';
import 'package:nasa_apod_viewer/features/home_page/components/todays_image.dart';
import 'package:nasa_apod_viewer/features/navigation_bar/bottom_navigation_bar.dart';

class _HomeState extends State<Home>{
  
  @override
  void initState(){
    super.initState();

    // NasaApiService().searchApod().then((r) => print(r));
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0), 
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: WHITE,
            shadowColor: Colors.transparent,
          ),
        ),
        extendBodyBehindAppBar: false,
        backgroundColor: WHITE,
        body: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              floating: true,
              pinned: true,
              delegate: HomePersistentHeaderDelegate(
                minExtent: kToolbarHeight + 15,
                maxExtent: 300
              )
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    decoration: BoxDecoration(
                      color: WHITE,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20))
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        HomeTitle(),
                        MoreInfo(),
                        SizedBox( height: 24 ),
                        TodaysImage(),
                      ],
                    ),
                  )
                ]
              )
            )
          ],
        ),
        bottomNavigationBar: CustomBottomNavigationBar(),
      )
    );
  }

}

class Home extends StatefulWidget{
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}
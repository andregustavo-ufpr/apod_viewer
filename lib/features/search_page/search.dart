import 'package:flutter/material.dart';
import 'package:nasa_apod_viewer/core/components/apod_viewer.dart';
import 'package:nasa_apod_viewer/core/components/default_appbar.dart';
import 'package:nasa_apod_viewer/core/components/loading_gradient.dart';
import 'package:nasa_apod_viewer/core/data/local/apod.dart';
import 'package:nasa_apod_viewer/core/data/local/colors.dart';
import 'package:nasa_apod_viewer/core/domain/services/nasa_api_service.dart';
import 'package:nasa_apod_viewer/features/navigation_bar/bottom_navigation_bar.dart';
import 'package:nasa_apod_viewer/features/search_page/components/search_date_button.dart';
import 'package:nasa_apod_viewer/features/search_page/components/search_filters_title.dart';
import 'package:nasa_apod_viewer/utils/snackbar.dart';

class _SearchState extends State<Search>{
  DateTime? startDate, endDate;
  List<Apod> results = [];
  bool loading = false;

  void _queryImage(){
    if(startDate == null) return;

    setState(() {
      loading = true;
    });
    NasaApiService().searchApod(date: startDate, endDate: endDate).then((r){
      if(!r["success"]){
        setState(() {
          loading = false;
          results =[];
        });
        if(context.mounted){
          snackbar(
            context: context,
            children: [
              Text(
                r["msg"] ?? "Failed to search images. Try again later",
                style: TextStyle(
                  color: WHITE,
                  fontSize: 16
                ),
              )
            ]
          );
        }

        return;
      }
      List<Apod> apods =[];
      
      if(r.containsKey("response_list")){
        for(Map<String, dynamic> image in r["response_list"]){
          apods.add(Apod.fromMap(image));
        }
      }
      else{
        apods.add(Apod.fromMap(r));
      }

      setState(() {
        loading = false;
        results = apods;
      });
    });
  }

  void _storeDate(String label, DateTime? date){
    if(label == "start"){
      setState(() {
        startDate = date;
      });
      return;
    }

    setState(() {
      endDate = date;
    });
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppbar(
        onLeading: null,
        title: "Search",
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: WHITE,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: kToolbarHeight + 40,),
              SearchFiltersTitle(),
              SizedBox(height: 16),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: SearchDateButton(
                      callback: (date) => _storeDate("start", date),
                      placeholderText: "Start date",
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: SearchDateButton(
                      callback: (date) => _storeDate("end", date),
                      placeholderText: "End Date",
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 24,
              ),
              InkWell(
                onTap: _queryImage,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 250),
                  margin: EdgeInsets.only(bottom: 24),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: startDate == null ? GRAY : DARK_BLUE,
                    border: Border.all(color: DARK_BLUE),
                    borderRadius: BorderRadius.circular(20)
                  ),
                  padding: EdgeInsets.all(12),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search,
                          color: BLUE_BG,
                          size: 20,
                        ),
                        SizedBox( width: 8,),
                        Text(
                          "Discover!",
                          style: TextStyle(
                            color: BLUE_BG,
                            fontSize: 20
                          ),
                        ),
                      ],
                    )
                  ),
                ),
              ),
              if(loading)
                Center(
                  child: LoadingGradient(
                    height: 200,
                  ),
                ),
              if(results.isNotEmpty)
                ListView.separated(
                  padding: EdgeInsets.all(0),
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (c, i) => ApodViewer(
                    apod: results[i],
                  ), 
                  separatorBuilder: (c, i) => const SizedBox(
                    height: 8,
                  ),  
                  itemCount: results.length
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavbar(
        pageIndex: 2,
      ),
    );
  }

}

class Search extends StatefulWidget{
  const Search({super.key});
  
  @override
  State<Search> createState() => _SearchState();

}
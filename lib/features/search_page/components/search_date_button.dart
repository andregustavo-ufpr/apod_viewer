import 'package:flutter/material.dart';
import 'package:nasa_apod_viewer/core/data/local/colors.dart';
import 'package:nasa_apod_viewer/utils/date.dart';

class _SearchDateButtonState extends State<SearchDateButton>{
  
  DateTime? selectedDate;

  Future<void> _openDatePicker(BuildContext context) async{
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2012, 1, 1),
      lastDate: DateTime.now()
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    bool filled = selectedDate != null;
    
    return InkWell(
      onTap: () => _openDatePicker(context),
      child: Container(
        decoration: BoxDecoration(
          color: filled ? DARK_BLUE : BLUE_BG,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: DARK_BLUE
          )
        ),
        child: Text(
          !filled ? "Select a date" : formatDate(selectedDate!),
          style: TextStyle(
            color: filled ? WHITE : DARK_BLUE,
            fontSize: 16,
            fontWeight: FontWeight.w500
          ),
        ),
      ),
    );
  }
}

class SearchDateButton extends StatefulWidget{
  const SearchDateButton({
    this.callback,
    super.key
  });

  final VoidCallback? callback;

  @override
  State<SearchDateButton> createState() => _SearchDateButtonState();

}
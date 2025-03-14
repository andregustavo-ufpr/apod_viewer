import 'package:flutter/material.dart';
import 'package:nasa_apod_viewer/core/data/local/colors.dart';
import 'package:nasa_apod_viewer/utils/date.dart';

class _SearchDateButtonState extends State<SearchDateButton>{
  
  DateTime? selectedDate;

  Future<void> _openDatePicker(BuildContext context) async{
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1995, 6, 16),
      lastDate: DateTime.now()
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });

      widget.callback!(selectedDate);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    bool filled = selectedDate != null;
    
    return InkWell(
      onTap: () => _openDatePicker(context),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: filled ? DARK_BLUE : BLUE_BG,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: DARK_BLUE
          )
        ),
        child: Center(
          child: Text(
            !filled ? 
              (widget.placeholderText ?? "Select a date") 
            : 
              visualFormatDate(selectedDate!),
            style: TextStyle(
              color: filled ? WHITE : DARK_BLUE,
              fontSize: 16,
              fontWeight: FontWeight.w500
            ),
          ),
        ),
      ),
    );
  }
}

class SearchDateButton extends StatefulWidget{
  const SearchDateButton({
    this.callback,
    this.placeholderText,
    super.key
  });

  final Function? callback;
  final String? placeholderText;

  @override
  State<SearchDateButton> createState() => _SearchDateButtonState();

}
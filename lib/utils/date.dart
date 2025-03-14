String formatDate(DateTime aDate){
  return "${aDate.year}-${aDate.month}-${aDate.day}";
}

String visualFormatDate(DateTime aDate){
  return "${aDate.month.toString().padLeft(2, "0")}/${aDate.day.toString().padLeft(2, "0")}/${aDate.year}";
}
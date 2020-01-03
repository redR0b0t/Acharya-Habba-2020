import 'package:intl/intl.dart';

class DatetimeHelper{
  int timestamp;
  DatetimeHelper({this.timestamp=0});

  String getDate(){
    final df = new DateFormat('dd-MM-yyyy');
    var date = df.format(new DateTime.fromMillisecondsSinceEpoch(this.timestamp));
    //String date = "${dateTime.day}/${dateTime.month}/${dateTime.year}";
    return date;
  }

  String getTime(){
    final df = new DateFormat('hh:mm a');
    var time = df.format(new DateTime.fromMillisecondsSinceEpoch(this.timestamp));
    return time;
  }
  String getMonthName(){
    final df = new DateFormat('MMMM');
    var monthName = df.format(new DateTime.fromMillisecondsSinceEpoch(this.timestamp));
    //String date = "${dateTime.day}/${dateTime.month}/${dateTime.year}";
    return monthName;
  }

  String getYear(){
    final df = new DateFormat('yyyy');
    var year = df.format(new DateTime.fromMillisecondsSinceEpoch(this.timestamp));
    //String date = "${dateTime.day}/${dateTime.month}/${dateTime.year}";
    return year;

  }


}
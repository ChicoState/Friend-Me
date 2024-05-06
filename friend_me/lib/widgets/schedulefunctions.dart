//schedule functions.
import 'package:friend_me/widgets/event.dart';
import 'package:flutter/material.dart';
import 'package:kalender/kalender.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:friend_me/auth/user.dart'; 
class FutureResults{
  final http.Response Response; 
  final String? UID; 
  FutureResults({required this.Response, required this.UID});
}

  Future<FutureResults> getResults(CalendarEventsController controller) async {
    final String? _uid = await getUsername(); 
    print("uid: $_uid");
    final http.Response _response = await fetchEvents(controller, _uid); 
    print("response: ${_response.statusCode}"); 
    return FutureResults(Response: _response, UID : _uid);
  }

//Future<List<CalendarEvent<Event>>>
// Function gets Events from the back end and returns the HTTP response.   Function also gets the User ID.
Future<http.Response> fetchEvents(
    CalendarEventsController controller, String? UID) async {
  print("getting events"); 
  var url = Uri(
    scheme: 'http',
    host: '127.0.0.1',
    port: 8000,
    path: 'eventsdetails',
    queryParameters: {'UID' : '$UID'},
  );
  print(url); 
  http.Response response = await http.get(
    url,
    headers: {
      'Authorization': '$UID',
    },
  );
  if (response.statusCode != 200){
    return response; 
  }
  Iterable list = json.decode(response.body);
  List<HTTPEvent> events =
      List<HTTPEvent>.from(list.map((model) => HTTPEvent.fromJson(model)));
  for (var i = 0; i < events.length; i++) {
    var current = events[i];
    DateTime DTStart = getDateTime(current.start_time);
    DateTime DTEnd = getDateTime(current.end_time);
    String start = getTime(DTStart);
    String end = getTime(DTEnd);
    //print("range: $start-$end");
    //print("DT range: $DTStart-$DTEnd");
    String timerange = '$start-$end';
    //print("${DateTimeRange(start: DTStart, end: DTEnd, )}");
    controller.addEvent(CalendarEvent<Event>(
        dateTimeRange: DateTimeRange(
          start: DTStart,
          end: DTEnd,
        ),
        eventData: Event(
            title: timerange,
            description: current.details,
            color: Colors.blue)));
  }
  return response;
}

Future<http.Response> postEvent(CalendarEvent<Event> event, String? UID) {
  print("Posting!");
  print("UID: $UID");
  var url = Uri(
    scheme: 'http',
    host: '127.0.0.1',
    port: 8000,
    path: 'eventsdetails',
  );
  return http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': '$UID',
    },
    body: jsonEncode(<String, String>{
      'UID': "$UID",
      'title': "${event.eventData?.title}",
      'start_time': "${event.dateTimeRange.start}",
      'end_time': "${event.dateTimeRange.end}",
      'description': "${event.eventData?.description}",
    }),
  );
}

Future<http.Response> modifyEvent(CalendarEvent<Event> event, String? UID) {
  print("modifying!!");
  print("UID: $UID");
  var url = Uri(
    scheme: 'http',
    host: '127.0.0.1',
    port: 8000,
    path: 'eventsdetails',
  );
  return http.put(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': '$UID',
    },
    body: jsonEncode(<String, String>{
      'id': "${event.eventData?.id}",
      'UID': "$UID",
      'title': "${event.eventData?.title}",
      'start_time': "${event.dateTimeRange.start}",
      'end_time': "${event.dateTimeRange.end}",
      'description': "${event.eventData?.description}",
    }),
  );
}

Future<http.Response> deleteEvent(CalendarEvent<Event> event, String? UID) {
  print("deleting!");
  var url = Uri(
    scheme: 'http',
    host: '127.0.0.1',
    port: 8000,
    path: 'eventsdetails',
  );
  return http.delete(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': '$UID',
    },
    body: jsonEncode({
      'id': event.eventData?.id,
    }),
  );
}

String getTime(DateTime dateTime) {
  String dHour, dMinute, timeOfDay;
  if (dateTime.hour > 11) {
    if (dateTime.hour > 12) {
      dHour = "${dateTime.hour - 12}";
    } else {
      dHour = "${dateTime.hour}";
    }
    timeOfDay = "PM";
  } else {
    dHour = "${dateTime.hour}";
    timeOfDay = "AM";
  }
  if (dateTime.minute < 10) {
    dMinute = "0${dateTime.minute}";
  } else {
    dMinute = "${dateTime.minute}";
  }
  String time = "$dHour:$dMinute$timeOfDay";
  return time;
}

DateTime getDateTime(String st) {
  st = st.substring(0, st.length - 1);
  return DateTime.parse(st);
}

//class to hold data from the http.get request.  may replace Event with this.
class HTTPEvent {
  final int id;
  final String details;
  final String start_time;
  final String end_time;
  //final int creator_id

  HTTPEvent(
      {required this.id,
      required this.details,
      required this.start_time,
      required this.end_time});

  factory HTTPEvent.fromJson(Map<String, dynamic> json) {
    return HTTPEvent(
      id: json['id'] as int,
      details: json['description'] as String,
      start_time: json['start_time'] as String,
      end_time: json['end_time'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'description': details,
        'start_time': start_time,
        'end_time': end_time,
      };
}

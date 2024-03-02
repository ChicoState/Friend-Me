import 'package:flutter/material.dart';
import 'package:friend_me/main.dart';
import '../pages/schedule.dart';
import 'package:kalender/kalender.dart';
// Class for the nav bar

class NavBar extends StatefulWidget implements PreferredSizeWidget {
  const NavBar({super.key});

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight); // neccessary to return appbar
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  //
  final textstyle = const TextStyle(
      // defines text style
      color: Colors.black,
      fontSize: 12);
  final CalendarEventsController<Event> eventsController =
      CalendarEventsController<Event>();

  final CalendarController<Event> calendarController =
      CalendarController<Event>();

  late CalendarComponents calendarComponents;
  late CalendarStyle calendarStyle;
  late CalendarLayoutDelegates<Event> calendarLayoutDelegates;

  int currentConfiguration = 0;
  List<ViewConfiguration> viewConfigurations = [
    WeekConfiguration(),
    MonthConfiguration(),
    MultiWeekConfiguration(),
  ];

  @override
  void initState() {
    super.initState();
    calendarComponents = CalendarComponents();
    calendarStyle = const CalendarStyle();
    calendarLayoutDelegates = CalendarLayoutDelegates();
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight); // neccessary to return appbar
  Widget build(BuildContext context) {
    // builds the widget
    final ButtonStyle outlineButtonStyle = OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 35,
            vertical: preferredSize.height / 10),
        shape: const LinearBorder(
          side: BorderSide(color: Colors.black, width: 2),
        ));
    return AppBar(
        // appbar
        automaticallyImplyLeading: false, // disables big back button appearing
        backgroundColor: Colors.grey, // sets background color
        title: Column(
          // coloum
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // children in the column
            const Text("Friend Me"), // text
            Row(
              // sets row of menu items
              children: [
                // children
                OutlinedButton(
                    // home button
                    style: outlineButtonStyle,
                    onPressed: () {
                      Navigator.pop; // pops currnet page
                      Navigator.push(
                        // push new page
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyHomePage(
                                title:
                                    'Home')), // temp until home page is seperate
                      );
                    },
                    child: Text("Home", style: textstyle)),
                OutlinedButton(
                    // profile button
                    style: outlineButtonStyle,
                    onPressed: () {},
                    child: Text("Profile", style: textstyle)),
                OutlinedButton(
                    // profile button
                    style: outlineButtonStyle,
                    onPressed: () {
                      Navigator.pop; // pops currnet page
                      Navigator.push(
                          // push new page
                          context,
                          MaterialPageRoute(
                            builder: (context) => ScheduleRoute(
                              eventsController: eventsController,
                              calendarController: calendarController,
                              calendarComponents: calendarComponents,
                              calendarStyle: calendarStyle,
                              currentConfiguration:
                                  viewConfigurations[currentConfiguration],
                              calendarLayoutDelegates: calendarLayoutDelegates,
                              onDateTapped: () {
                                setState(() {
                                  currentConfiguration = 0;
                                });
                              },
                            ), // temp until home page is seperate
                          ));
                    },
                    child: Text("Schedule", style: textstyle)),
                OutlinedButton(
                    // Friends button
                    style: outlineButtonStyle,
                    onPressed: () {},
                    child: Text("Friends", style: textstyle)),
                OutlinedButton(
                    // Settings button
                    style: outlineButtonStyle,
                    onPressed: () {},
                    child: Text("Settings", style: textstyle)),
              ],
            )
          ],
        ));
  }
}

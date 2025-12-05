import 'package:flutter/material.dart';
import 'screens/explore/explore_screen.dart';
import 'screens/planner/trip_planner_screen.dart';
import 'screens/chat/travel_chat_screen.dart';
import 'screens/journal/journal_screen.dart';
import 'screens/profile/profile_screen.dart';

class AiTravelMateApp extends StatefulWidget {
  const AiTravelMateApp({super.key});

  @override
  State<AiTravelMateApp> createState() => _AiTravelMateAppState();
}

class _AiTravelMateAppState extends State<AiTravelMateApp> {
  int _index = 0;

  final screens = const [
    ExploreScreen(),
    TripPlannerScreen(),
    TravelChatScreen(),
    JournalScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI TravelMate',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple,
        fontFamily: '',
      ),
      home: Scaffold(
        body: screens[_index],
        bottomNavigationBar: NavigationBar(
          selectedIndex: _index,
          onDestinationSelected: (i) => setState(() => _index = i),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.explore), label: "Explore"),
            NavigationDestination(icon: Icon(Icons.route), label: "Plan"),
            NavigationDestination(icon: Icon(Icons.chat), label: "Chat"),
            NavigationDestination(icon: Icon(Icons.book), label: "Journal"),
            NavigationDestination(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      ),
    );
  }
}

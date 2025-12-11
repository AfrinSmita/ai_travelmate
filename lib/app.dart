import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'screens/explore/explore_screen.dart';
import 'screens/planner/trip_planner_screen.dart';
import 'screens/chat/travel_chat_screen.dart';
import 'screens/journal/journal_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/profile/login_screen.dart';

class AiTravelMateApp extends StatelessWidget {
  const AiTravelMateApp({super.key});

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
      home: const AuthGate(), // decides: Login vs MainTabs
    );
  }
}

/// Decides whether to show LoginScreen or the main tabbed app
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // While Firebase is checking if user is logged in
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // If we have a logged-in user → go to main app
        if (snapshot.hasData) {
          return const MainTabs();
        }

        // No user → show login
        return const LoginScreen();
      },
    );
  }
}

/// Your old AiTravelMateApp body, now moved here
class MainTabs extends StatefulWidget {
  const MainTabs({super.key});

  @override
  State<MainTabs> createState() => _MainTabsState();
}

class _MainTabsState extends State<MainTabs> {
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
    return Scaffold(
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
    );
  }
}

import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(
                "https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg",
              ),
            ),
            const SizedBox(height: 10),
            const Text("Afsana Afrin Esmita",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text("Beach lover • Budget traveler",
                style: TextStyle(color: Colors.grey.shade700)),
          ],
        ),
      ),
    );
  }
}

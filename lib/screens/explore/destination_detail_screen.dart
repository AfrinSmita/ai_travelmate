import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../models/destination.dart';

class DestinationDetailScreen extends StatelessWidget {
  final Destination destination;

  const DestinationDetailScreen({super.key, required this.destination});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(destination.name)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Hero(
            tag: destination.id,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                imageUrl: destination.imageUrl,
                height: 220,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(destination.description, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 12),
          Text("Best time to visit: ${destination.bestTime}"),
        ],
      ),
    );
  }
}

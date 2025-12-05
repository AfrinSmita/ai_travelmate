import 'package:flutter/material.dart';
import '../../models/destination.dart';

class FeaturedCard extends StatelessWidget {
  final Destination destination;

  const FeaturedCard({super.key, required this.destination});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: destination.id,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // -------- IMAGE (simple & reliable) --------
            Image.network(
              destination.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stack) => Container(
                color: Colors.grey.shade300,
                alignment: Alignment.center,
                child: const Icon(Icons.broken_image, size: 40),
              ),
            ),

            // Gradient overlay
            Container(
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.6),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Text(
                destination.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

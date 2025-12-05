import 'package:flutter/material.dart';
import '../../models/destination.dart';
import 'destination_detail_screen.dart';
import 'featured_card.dart';
import 'destination_card.dart';

// ---------- 5 DEMO DESTINATIONS ----------
final demoDestinations = <Destination>[
  Destination(
    id: '1',
    name: "Cox's Bazar",
    country: 'Bangladesh',
    category: 'Beach',
    imageUrl:
        'https://images.pexels.com/photos/2404370/pexels-photo-2404370.jpeg',
    rating: 4.7,
    bestTime: 'Nov–Feb',
    description:
        'World’s longest natural sandy beach with beautiful sunset views and budget friendly hotels.',
  ),
  Destination(
    id: '2',
    name: 'Bali',
    country: 'Indonesia',
    category: 'Culture',
    imageUrl:
        'https://images.pexels.com/photos/2387873/pexels-photo-2387873.jpeg',
    rating: 4.8,
    bestTime: 'Apr–Oct',
    description:
        'Temples, rice terraces, cafes and beaches — perfect for honeymoon, solo trips and digital nomads.',
  ),
  Destination(
    id: '3',
    name: 'Sajek Valley',
    country: 'Bangladesh',
    category: 'Hill',
    imageUrl:
        'https://images.pexels.com/photos/417074/pexels-photo-417074.jpeg',
    rating: 4.6,
    bestTime: 'Oct–Mar',
    description:
        'Cloud-kissed green hills, calm village life and magical sunrises for nature lovers.',
  ),
  Destination(
    id: '4',
    name: 'Santorini',
    country: 'Greece',
    category: 'Luxury',
    imageUrl:
        'https://images.pexels.com/photos/1430677/pexels-photo-1430677.jpeg',
    rating: 4.9,
    bestTime: 'May–Sep',
    description:
        'Iconic white-and-blue houses, cliffside sunsets and romantic luxury stays.',
  ),
  Destination(
    id: '5',
    name: 'Dubai',
    country: 'UAE',
    category: 'Adventure',
    imageUrl:
        'https://images.pexels.com/photos/2044434/pexels-photo-2044434.jpeg',
    rating: 4.5,
    bestTime: 'Nov–Mar',
    description:
        'Desert safaris, skyscrapers, shopping malls and adrenaline activities all in one city.',
  ),
];

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final _pageController = PageController(viewportFraction: 0.8);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            "Explore",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          // ---------- FEATURED SLIDER ----------
          SizedBox(
            height: 200,
            child: PageView.builder(
              controller: _pageController,
              itemCount: demoDestinations.length, // 5 slides
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: FeaturedCard(destination: demoDestinations[index]),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // ---------- LIST BELOW ----------
          Expanded(
            child: ListView.builder(
              itemCount: demoDestinations.length,
              itemBuilder: (context, index) {
                return DestinationCard(
                  destination: demoDestinations[index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DestinationDetailScreen(
                          destination: demoDestinations[index],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

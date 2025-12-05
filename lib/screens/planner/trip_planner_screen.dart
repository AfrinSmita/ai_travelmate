import 'package:flutter/material.dart';
import '../../services/ai_service.dart';

class TripPlannerScreen extends StatefulWidget {
  const TripPlannerScreen({super.key});

  @override
  State<TripPlannerScreen> createState() => _TripPlannerScreenState();
}

class _TripPlannerScreenState extends State<TripPlannerScreen> {
  final TextEditingController _cityCtrl = TextEditingController();
  final TextEditingController _daysCtrl = TextEditingController();
  final TextEditingController _peopleCtrl = TextEditingController();

  String? aiPlan;
  bool loading = false;

  // -----------------------
  // AI TRIP PLANNER FUNCTION
  // -----------------------
  void generatePlan() async {
    setState(() => loading = true);

    final text = await AIService.generatePlan(
      _cityCtrl.text.trim(),
      int.tryParse(_daysCtrl.text.trim()) ?? 3,
      int.tryParse(_peopleCtrl.text.trim()) ?? 2,
    );

    setState(() {
      aiPlan = text;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AI Trip Planner")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _cityCtrl,
              decoration: const InputDecoration(
                labelText: "City / Country",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: _daysCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Number of Days",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: _peopleCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Number of People",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: loading ? null : generatePlan,
                child: loading
                    ? const CircularProgressIndicator()
                    : const Text("Generate Trip Itinerary"),
              ),
            ),

            const SizedBox(height: 20),

            if (aiPlan != null)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 8,
                      color: Colors.black.withOpacity(0.1),
                    )
                  ],
                ),
                child: Text(
                  aiPlan!,
                  style: const TextStyle(fontSize: 15, height: 1.4),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

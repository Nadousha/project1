
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../services/mock_service.dart';
import 'tour_detail_screen.dart';

class PlanTripStep4Screen extends StatefulWidget {
  final String destination;
  final DateTimeRange dateRange;

  // New budget fields
  final double budget;
  final String currency;

  const PlanTripStep4Screen({
    super.key,
    required this.destination,
    required this.dateRange,
    required this.budget,
    required this.currency,
  });

  @override
  State<PlanTripStep4Screen> createState() =>
      _PlanTripStep4ScreenState();
}

class _PlanTripStep4ScreenState
    extends State<PlanTripStep4Screen> {

  final Set<String> selected = {};
  bool _loading = false;

  final List<Map<String, String>> interests = [
    {'emoji': '🏛️', 'label': 'Pyramids'},
    {'emoji': '🚢', 'label': 'Nile Cruise'},
    {'emoji': '🛍️', 'label': 'Bazaars'},
    {'emoji': '🤿', 'label': 'Diving'},
    {'emoji': '🥗', 'label': 'Food'},
    {'emoji': '🐪', 'label': 'Desert'},
    {'emoji': '📜', 'label': 'History'},
    {'emoji': '🌙', 'label': 'Nightlife'},
    {'emoji': '🎨', 'label': 'Art'},
    {'emoji': '🌊', 'label': 'Beach'},
  ];

  Future<void> _generateTour() async {
    setState(() => _loading = true);

    try {
      final tour = await MockService.generateTour(
        destination: widget.destination,
        departure: widget.dateRange.start,
        returnDate: widget.dateRange.end,

        // Pass the user's budget
        budget: widget.budget,
        currency: widget.currency,

        // Pass the selected interests
        interests: selected.toList(),
      );

      if (!mounted) return;

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => TourDetailScreen(tour: tour),
        ),
        (route) => route.isFirst,
      );

    } catch (e) {
      if (!mounted) return;

      setState(() => _loading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkNavy,

      appBar: AppBar(
        backgroundColor: const Color(0xFF1565C0),
        title: const Text('Plan Your Trip'),

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                '4/4',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],

        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: Row(
            children: List.generate(
              4,
              (i) => Expanded(
                child: Container(
                  height: 4,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: AppColors.cyan,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),

      body: Stack(
        children: [

          Padding(
            padding: const EdgeInsets.all(24),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                const SizedBox(height: 16),

                const Text(
                  'INTERESTS',
                  style: TextStyle(
                    color: AppColors.yellow,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  'What do you love?',
                  style: TextStyle(
                    color: AppColors.textWhite,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                const Text(
                  'Select all that apply',
                  style: TextStyle(
                    color: AppColors.textGrey,
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 24),

                // Display interests
                Wrap(
                  spacing: 10,
                  runSpacing: 12,

                  children: interests.map((item) {
                    final label = item['label']!;
                    final isSelected = selected.contains(label);

                    return GestureDetector(
                      onTap: () => setState(() {
                        isSelected
                            ? selected.remove(label)
                            : selected.add(label);
                      }),

                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),

                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.yellow
                              : AppColors.navyCard,
                          borderRadius: BorderRadius.circular(30),
                        ),

                        child: Row(
                          mainAxisSize: MainAxisSize.min,

                          children: [
                            Text(
                              item['emoji']!,
                              style: const TextStyle(fontSize: 18),
                            ),

                            const SizedBox(width: 8),

                            Text(
                              label,
                              style: TextStyle(
                                color: isSelected
                                    ? AppColors.darkNavy
                                    : AppColors.textWhite,
                                fontSize: 15,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),

                const Spacer(),

                // Generate button
                YellowButton(
                  label: 'GENERATE MY TOUR',
                  enabled: selected.isNotEmpty && !_loading,
                  onPressed: selected.isNotEmpty && !_loading
                      ? _generateTour
                      : null,
                ),

                const SizedBox(height: 16),
              ],
            ),
          ),

          // Loading overlay
          if (_loading)
            Container(
              color: Colors.black.withOpacity(0.7),

              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,

                  children: [

                    const CircularProgressIndicator(
                      color: AppColors.yellow,
                      strokeWidth: 3,
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      '✨ AI is crafting your tour...',
                      style: TextStyle(
                        color: AppColors.textWhite,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Personalizing for ${widget.destination}',
                      style: const TextStyle(
                        color: AppColors.textGrey,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

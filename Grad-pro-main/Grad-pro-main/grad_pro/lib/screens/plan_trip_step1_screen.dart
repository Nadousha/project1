import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'plan_trip_step2_screen.dart';

class PlanTripStep1Screen extends StatefulWidget {
  const PlanTripStep1Screen({super.key});

  @override
  State<PlanTripStep1Screen> createState() => _PlanTripStep1ScreenState();
}

class _PlanTripStep1ScreenState extends State<PlanTripStep1Screen> {
  String? selectedDestination;
  final TextEditingController _controller = TextEditingController();

  final List<String> destinations = ['Cairo', 'Luxor', 'Aswan', 'Giza', 'Alexandria', 'Hurghada'];

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
                '1/4',
                style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 16),
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: Row(
            children: List.generate(4, (i) {
              return Expanded(
                child: Container(
                  height: 4,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: i == 0 ? AppColors.cyan : AppColors.cyan.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Text(
              'WHERE TO?',
              style: TextStyle(
                color: AppColors.yellow,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Choose your Egyptian\ndestination',
              style: TextStyle(
                color: AppColors.textWhite,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 24),

            // Search Field
            TextField(
              controller: _controller,
              onChanged: (val) => setState(() => selectedDestination = val.isEmpty ? null : val),
              style: const TextStyle(color: AppColors.textWhite),
              decoration: InputDecoration(
                hintText: 'e.g. Cairo, Luxor, Aswan...',
                hintStyle: const TextStyle(color: AppColors.textGrey),
                filled: true,
                fillColor: AppColors.navyCard,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: AppColors.cyan, width: 1.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: AppColors.cyan, width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: AppColors.cyan, width: 2),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              ),
            ),

            const SizedBox(height: 20),

            // Quick chips
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: destinations.map((d) {
                final isSelected = selectedDestination == d;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDestination = d;
                      _controller.text = d;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.cyan.withOpacity(0.2) : AppColors.navyCard,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: isSelected ? AppColors.cyan : AppColors.navyLight,
                      ),
                    ),
                    child: Text(
                      d,
                      style: TextStyle(
                        color: isSelected ? AppColors.cyan : AppColors.textWhite,
                        fontSize: 14,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const Spacer(),

            YellowButton(
              label: 'CONTINUE',
              enabled: selectedDestination != null && selectedDestination!.isNotEmpty,
              onPressed: selectedDestination != null
                  ? () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PlanTripStep2Screen(destination: selectedDestination!),
                        ),
                      )
                  : null,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

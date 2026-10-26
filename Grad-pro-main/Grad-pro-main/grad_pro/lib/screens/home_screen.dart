import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../services/mock_service.dart';
import 'plan_trip_step1_screen.dart';
import 'tour_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Map<String, dynamic>>> _destinationsFuture;
  late Future<List<Map<String, dynamic>>> _toursFuture;

  final user = MockService.getCurrentUser() ?? {'name': 'Anas'};

  String get _greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning,';
    if (hour < 17) return 'Good afternoon,';
    return 'Good evening,';
  }

  @override
  void initState() {
    super.initState();
    _destinationsFuture = MockService.getDestinations();
    _toursFuture = MockService.getMyTours();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkNavy,
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.yellow,
          backgroundColor: AppColors.navyCard,
          onRefresh: () async {
            setState(() {
              _destinationsFuture = MockService.getDestinations();
              _toursFuture = MockService.getMyTours();
            });
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                // Header
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        width: 48, height: 48,
                        color: AppColors.navyCard,
                        child: const Icon(Icons.explore, color: AppColors.cyan, size: 28),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_greeting, style: const TextStyle(color: AppColors.textGrey, fontSize: 14)),
                        Text(user['name'] ?? 'Traveller',
                            style: const TextStyle(color: AppColors.textWhite, fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      width: 44, height: 44,
                      decoration: BoxDecoration(color: AppColors.navyLight, shape: BoxShape.circle),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Plan Banner
                GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PlanTripStep1Screen())),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF1A3A6B), Color(0xFF00BCD4)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Plan Your Egypt Adventure',
                                  style: TextStyle(color: AppColors.textWhite, fontSize: 18, fontWeight: FontWeight.bold)),
                              SizedBox(height: 6),
                              Text('Tell us your preferences and let AI craft your perfect Egyptian itinerary',
                                  style: TextStyle(color: Colors.white70, fontSize: 13)),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          width: 56, height: 56,
                          decoration: BoxDecoration(color: Colors.teal.withOpacity(0.6), borderRadius: BorderRadius.circular(14)),
                          child: const Icon(Icons.place, color: Colors.redAccent, size: 32),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                // Explore Egypt
                const Text('Explore Egypt', style: TextStyle(color: AppColors.textWhite, fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 14),

                FutureBuilder<List<Map<String, dynamic>>>(
                  future: _destinationsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox(
                        height: 130,
                        child: Center(child: CircularProgressIndicator(color: AppColors.cyan, strokeWidth: 2)),
                      );
                    }
                    final destinations = snapshot.data ?? [];
                    return SizedBox(
                      height: 130,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: destinations.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 12),
                        itemBuilder: (_, i) {
                          final d = destinations[i];
                          return Container(
                            width: 120,
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(color: AppColors.navyCard, borderRadius: BorderRadius.circular(16)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(d['emoji'], style: const TextStyle(fontSize: 28)),
                                const SizedBox(height: 8),
                                Text(d['city'], style: const TextStyle(color: AppColors.textWhite, fontSize: 15, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 3),
                                Text(d['subtitle'], style: const TextStyle(color: AppColors.textGrey, fontSize: 11), maxLines: 2, overflow: TextOverflow.ellipsis),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),

                const SizedBox(height: 28),

                // My Tours
                const Text('My Tours', style: TextStyle(color: AppColors.textWhite, fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 14),

                FutureBuilder<List<Map<String, dynamic>>>(
                  future: _toursFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator(color: AppColors.cyan, strokeWidth: 2));
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            const Icon(Icons.map_outlined, color: AppColors.textGrey, size: 48),
                            const SizedBox(height: 12),
                            const Text('No tours yet', style: TextStyle(color: AppColors.textGrey, fontSize: 16)),
                            const SizedBox(height: 6),
                            TextButton(
                              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PlanTripStep1Screen())),
                              child: const Text('Plan your first trip →', style: TextStyle(color: AppColors.cyan)),
                            ),
                          ],
                        ),
                      );
                    }

                    return Column(
                      children: snapshot.data!.map((tour) {
                        return GestureDetector(
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => TourDetailScreen(tour: tour))),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: AppColors.navyCard,
                              borderRadius: BorderRadius.circular(20),
                              border: const Border(left: BorderSide(color: AppColors.cyan, width: 3)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(tour['city'], style: const TextStyle(color: AppColors.yellow, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 2)),
                                const SizedBox(height: 6),
                                Text(tour['title'], style: const TextStyle(color: AppColors.textWhite, fontSize: 20, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 6),
                                Text(tour['description'], style: const TextStyle(color: AppColors.textGrey, fontSize: 13), maxLines: 2, overflow: TextOverflow.ellipsis),
                                const SizedBox(height: 12),
                                Wrap(
                                  spacing: 8,
                                  children: [
                                    Text('${tour['startDate']} – ${tour['endDate']}', style: const TextStyle(color: AppColors.textGrey, fontSize: 12)),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(color: AppColors.cyan.withOpacity(0.15), borderRadius: BorderRadius.circular(20)),
                                      child: Text('${tour['days']} days', style: const TextStyle(color: AppColors.cyan, fontSize: 12)),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(color: AppColors.yellow.withOpacity(0.15), borderRadius: BorderRadius.circular(20)),
                                      child: Text('👑 ${tour['style']}', style: const TextStyle(color: AppColors.yellow, fontSize: 12)),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Wrap(
                                  spacing: 8,
                                  children: (tour['interests'] as List).map((tag) => Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                                    decoration: BoxDecoration(border: Border.all(color: AppColors.navyLight), borderRadius: BorderRadius.circular(20)),
                                    child: Text(tag, style: const TextStyle(color: AppColors.textGrey, fontSize: 12)),
                                  )).toList(),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

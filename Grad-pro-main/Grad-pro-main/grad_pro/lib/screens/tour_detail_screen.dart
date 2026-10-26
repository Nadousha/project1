import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class TourDetailScreen extends StatefulWidget {
  final Map<String, dynamic> tour;
  const TourDetailScreen({super.key, required this.tour});

  @override
  State<TourDetailScreen> createState() => _TourDetailScreenState();
}

class _TourDetailScreenState extends State<TourDetailScreen> {
  int selectedDay = 0;

  List<Map<String, dynamic>> get _itinerary =>
      List<Map<String, dynamic>>.from(widget.tour['itinerary'] ?? []);

  Color _getIconBg(String color) {
    switch (color) {
      case 'orange': return Colors.deepOrange;
      case 'cyan': return Colors.cyan.shade700;
      case 'yellow': return Colors.amber.shade700;
      case 'purple': return Colors.purple.shade700;
      case 'green': return Colors.green.shade700;
      default: return AppColors.navyLight;
    }
  }

  @override
  Widget build(BuildContext context) {
    final itinerary = _itinerary;
    final currentDay = selectedDay < itinerary.length ? itinerary[selectedDay] : null;
    final activities = currentDay != null
        ? List<Map<String, dynamic>>.from(currentDay['activities'] ?? [])
        : <Map<String, dynamic>>[];

    return Scaffold(
      backgroundColor: AppColors.darkNavy,
      body: Column(
        children: [
          // Header
          Container(
            color: const Color(0xFF00BCD4).withOpacity(0.85),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.tour['city'] ?? '',
                            style: const TextStyle(color: AppColors.yellow, fontSize: 13, fontWeight: FontWeight.w600)),
                        Text(widget.tour['title'] ?? '',
                            style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      width: 40, height: 40,
                      decoration: BoxDecoration(color: AppColors.cyan.withOpacity(0.3), shape: BoxShape.circle),
                      child: const Icon(Icons.share, color: Colors.white, size: 20),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Meta
          Container(
            color: AppColors.navyCard,
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.tour['description'] ?? '',
                    style: const TextStyle(color: Colors.white70, fontSize: 13, height: 1.4),
                    maxLines: 2, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text('${widget.tour['startDate']} – ${widget.tour['endDate']}',
                        style: const TextStyle(color: AppColors.textGrey, fontSize: 13)),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: Colors.black38, borderRadius: BorderRadius.circular(20)),
                      child: Text('👑 ${widget.tour['style']}',
                          style: const TextStyle(color: AppColors.yellow, fontSize: 12)),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Day tabs
          Container(
            color: AppColors.navyCard,
            height: 64,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: itinerary.length,
              itemBuilder: (_, i) {
                final isActive = i == selectedDay;
                return GestureDetector(
                  onTap: () => setState(() => selectedDay = i),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(
                        color: isActive ? AppColors.cyan : Colors.transparent,
                        width: 2,
                      )),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Day ${itinerary[i]['dayNumber']}',
                            style: TextStyle(
                              color: isActive ? AppColors.cyan : AppColors.textGrey,
                              fontSize: 13,
                              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                            )),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Day title
          if (currentDay != null)
            Container(
              color: const Color(0xFF0D1F3C),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              width: double.infinity,
              child: Text(currentDay['title'] ?? '',
                  style: const TextStyle(color: AppColors.textWhite, fontSize: 15, fontWeight: FontWeight.w600)),
            ),

          // Activities
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: activities.length,
              itemBuilder: (_, i) {
                final item = activities[i];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: AppColors.navyCard, borderRadius: BorderRadius.circular(14)),
                  child: Row(
                    children: [
                      Container(
                        width: 44, height: 44,
                        decoration: BoxDecoration(color: _getIconBg(item['color'] ?? 'blue'), shape: BoxShape.circle),
                        child: Center(child: Text(item['emoji'] ?? '📍', style: const TextStyle(fontSize: 22))),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item['time'] ?? '', style: const TextStyle(color: AppColors.textGrey, fontSize: 12)),
                            const SizedBox(height: 3),
                            Text(item['title'] ?? '',
                                style: const TextStyle(color: AppColors.textWhite, fontSize: 16, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                      Text(item['duration'] ?? '', style: const TextStyle(color: AppColors.textGrey, fontSize: 13)),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

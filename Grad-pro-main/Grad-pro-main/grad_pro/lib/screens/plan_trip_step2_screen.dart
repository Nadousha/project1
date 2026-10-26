import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'plan_trip_step3_screen.dart';

class PlanTripStep2Screen extends StatefulWidget {
  final String destination;
  const PlanTripStep2Screen({super.key, required this.destination});

  @override
  State<PlanTripStep2Screen> createState() => _PlanTripStep2ScreenState();
}

class _PlanTripStep2ScreenState extends State<PlanTripStep2Screen> {
  DateTime? departure;
  DateTime? returnDate;
  bool _pickingDeparture = true;

  String _formatDate(DateTime? d) {
    if (d == null) return '—';
    const months = ['', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${months[d.month]} ${d.day}';
  }

  int get _tripDays {
    if (departure == null || returnDate == null) return 0;
    return returnDate!.difference(departure!).inDays + 1;
  }

  Future<void> _pickDate(bool isDeparture) async {
    final now = DateTime.now();
    final initial = isDeparture
        ? (departure ?? now)
        : (returnDate ?? (departure?.add(const Duration(days: 1)) ?? now.add(const Duration(days: 1))));

    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: isDeparture ? now : (departure ?? now).add(const Duration(days: 1)),
      lastDate: now.add(const Duration(days: 365)),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: const ColorScheme.dark(
            primary: AppColors.yellow,
            onPrimary: AppColors.darkNavy,
            surface: AppColors.navyCard,
            onSurface: AppColors.textWhite,
          ),
        ),
        child: child!,
      ),
    );

    if (picked != null) {
      setState(() {
        if (isDeparture) {
          departure = picked;
          // Reset return if it's before new departure
          if (returnDate != null && returnDate!.isBefore(picked.add(const Duration(days: 1)))) {
            returnDate = null;
          }
        } else {
          returnDate = picked;
        }
      });
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
              child: Text('2/4',
                  style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 16)),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: Row(
            children: List.generate(4, (i) => Expanded(
              child: Container(
                height: 4,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  color: i <= 1 ? AppColors.cyan : AppColors.cyan.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            )),
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
              'WHEN?',
              style: TextStyle(
                color: AppColors.yellow,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Select your travel dates',
              style: TextStyle(
                color: AppColors.textWhite,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 28),

            // DEPARTURE card
            GestureDetector(
              onTap: () => _pickDate(true),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
                decoration: BoxDecoration(
                  color: AppColors.navyCard,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: departure != null ? AppColors.cyan.withOpacity(0.4) : Colors.transparent,
                    width: 1.5,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'DEPARTURE',
                      style: TextStyle(
                        color: AppColors.textGrey,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Text(
                        departure != null ? _formatDate(departure) : 'Tap to select',
                        style: TextStyle(
                          color: departure != null ? AppColors.textWhite : AppColors.textGrey,
                          fontSize: departure != null ? 32 : 18,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // RETURN card
            GestureDetector(
              onTap: departure != null ? () => _pickDate(false) : null,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
                decoration: BoxDecoration(
                  color: AppColors.navyCard,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: returnDate != null ? AppColors.cyan.withOpacity(0.4) : Colors.transparent,
                    width: 1.5,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'RETURN',
                      style: TextStyle(
                        color: departure != null ? AppColors.textGrey : AppColors.textGrey.withOpacity(0.4),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Text(
                        returnDate != null
                            ? _formatDate(returnDate)
                            : (departure != null ? 'Tap to select' : '—'),
                        style: TextStyle(
                          color: returnDate != null
                              ? AppColors.textWhite
                              : AppColors.textGrey.withOpacity(departure != null ? 1 : 0.4),
                          fontSize: returnDate != null ? 32 : 18,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Days pill
            if (_tripDays > 0) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  '$_tripDays days in ${widget.destination}',
                  style: const TextStyle(
                    color: AppColors.textWhite,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],

            const Spacer(),

            YellowButton(
              label: 'CONTINUE',
              enabled: departure != null && returnDate != null,
              onPressed: (departure != null && returnDate != null)
                  ? () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PlanTripStep3Screen(
                            destination: widget.destination,
                            dateRange: DateTimeRange(
                              start: departure!,
                              end: returnDate!,
                            ),
                          ),
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

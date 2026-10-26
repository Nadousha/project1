
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_theme.dart';
import 'plan_trip_step4_screen.dart';

class PlanTripStep3Screen extends StatefulWidget {
  final String destination;
  final DateTimeRange dateRange;

  const PlanTripStep3Screen({
    super.key,
    required this.destination,
    required this.dateRange,
  });

  @override
  State<PlanTripStep3Screen> createState() =>
      _PlanTripStep3ScreenState();
}

class _PlanTripStep3ScreenState
    extends State<PlanTripStep3Screen> {

  // Controller for the budget input
  final TextEditingController budgetController =
      TextEditingController();

  // Selected currency
  String selectedCurrency = 'EGP';

  // Budget validation
  String? budgetError;

  // Available currencies
  final List<String> currencies = [
    'EGP',
    'SAR',
    'USD',
  ];

  @override
  void dispose() {
    budgetController.dispose();
    super.dispose();
  }

  void continueToNextStep() {
    final budgetText = budgetController.text.trim();

    // Check if the user entered a budget
    if (budgetText.isEmpty) {
      setState(() {
        budgetError = 'Please enter your travel budget';
      });
      return;
    }

    // Convert the input into a number
    final budget = double.tryParse(budgetText);

    // Check if the budget is valid
    if (budget == null || budget <= 0) {
      setState(() {
        budgetError = 'Please enter a valid budget';
      });
      return;
    }

    // Clear any previous error
    setState(() {
      budgetError = null;
    });

    // Navigate to Step 4
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PlanTripStep4Screen(
          destination: widget.destination,
          dateRange: widget.dateRange,
          budget: budget,
          currency: selectedCurrency,
        ),
      ),
    );
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
                '3/4',
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
                    color: i <= 2
                        ? AppColors.cyan
                        : AppColors.cyan.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(24),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const SizedBox(height: 16),

            // Section title
            const Text(
              'BUDGET',
              style: TextStyle(
                color: AppColors.yellow,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),

            const SizedBox(height: 10),

            // Main question
            const Text(
              'What is your travel budget?',
              style: TextStyle(
                color: AppColors.textWhite,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              'Enter the total amount you want to spend '
              'on your trip.',
              style: TextStyle(
                color: AppColors.textGrey,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 32),

            // Budget input label
            const Text(
              'YOUR BUDGET',
              style: TextStyle(
                color: AppColors.textWhite,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            // Budget input and currency dropdown
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // Numeric budget input
                Expanded(
                  child: TextField(
                    controller: budgetController,

                    keyboardType:
                        const TextInputType.numberWithOptions(
                      decimal: true,
                    ),

                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^\d*\.?\d*'),
                      ),
                    ],

                    style: const TextStyle(
                      color: AppColors.textWhite,
                      fontSize: 20,
                    ),

                    decoration: InputDecoration(
                      hintText: 'e.g. 15000',
                      hintStyle: const TextStyle(
                        color: AppColors.textGrey,
                      ),

                      filled: true,
                      fillColor: AppColors.navyCard,

                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 20,
                      ),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: AppColors.cyan.withOpacity(0.3),
                        ),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: AppColors.cyan,
                          width: 1.5,
                        ),
                      ),

                      errorText: budgetError,
                    ),

                    onChanged: (_) {
                      if (budgetError != null) {
                        setState(() {
                          budgetError = null;
                        });
                      }
                    },
                  ),
                ),

                const SizedBox(width: 12),

                // Currency dropdown
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),

                  decoration: BoxDecoration(
                    color: AppColors.navyCard,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.cyan.withOpacity(0.3),
                    ),
                  ),

                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedCurrency,

                      dropdownColor: AppColors.navyCard,

                      style: const TextStyle(
                        color: AppColors.textWhite,
                        fontSize: 16,
                      ),

                      iconEnabledColor: AppColors.cyan,

                      items: currencies.map((currency) {
                        return DropdownMenuItem<String>(
                          value: currency,
                          child: Text(currency),
                        );
                      }).toList(),

                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            selectedCurrency = value;
                          });
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Budget hint
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline,
                  color: AppColors.cyan,
                  size: 18,
                ),

                SizedBox(width: 8),

                Expanded(
                  child: Text(
                    'Your budget will help our AI recommend '
                    'destinations, hotels, and activities '
                    'that match your spending limit.',
                    style: TextStyle(
                      color: AppColors.textGrey,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),

            const Spacer(),

            // Continue button
            YellowButton(
              label: 'CONTINUE',
              enabled: true,
              onPressed: continueToNextStep,
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

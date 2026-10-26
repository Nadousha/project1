
class MockService {
  // Simulated logged-in user
  static Map<String, dynamic>? _currentUser;

  // ============================================================
  // AUTH
  // ============================================================

  /// Login — simulated login
  static Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    await Future.delayed(const Duration(seconds: 1));

    if (password.length < 3) {
      throw Exception('Invalid email or password');
    }

    _currentUser = {
      'id': 'user_001',
      'name': 'Anas',
      'email': email,
      'avatar': null,
    };

    return _currentUser!;
  }

  /// Register — simulated registration
  static Future<Map<String, dynamic>> register(
    String name,
    String email,
    String password,
  ) async {
    await Future.delayed(const Duration(seconds: 1));

    if (password.length < 6) {
      throw Exception(
        'Password must be at least 6 characters',
      );
    }

    _currentUser = {
      'id': 'user_002',
      'name': name,
      'email': email,
      'avatar': null,
    };

    return _currentUser!;
  }

  /// Logout
  static Future<void> logout() async {
    await Future.delayed(
      const Duration(milliseconds: 300),
    );

    _currentUser = null;
  }

  /// Get current logged-in user
  static Map<String, dynamic>? getCurrentUser() =>
      _currentUser;

  // ============================================================
  // HOME
  // ============================================================

  /// Fetch destinations for Explore section
  static Future<List<Map<String, dynamic>>>
      getDestinations() async {
    await Future.delayed(
      const Duration(milliseconds: 600),
    );

    return [
      {
        'emoji': '🏛️',
        'city': 'Cairo',
        'subtitle': 'City of Pharaohs',
      },
      {
        'emoji': '🗿',
        'city': 'Luxor',
        'subtitle': 'Open-Air Museum',
      },
      {
        'emoji': '🐪',
        'city': 'Aswan',
        'subtitle': 'Nubian Gem',
      },
      {
        'emoji': '🌊',
        'city': 'Hurghada',
        'subtitle': 'Red Sea Paradise',
      },
      {
        'emoji': '🏖️',
        'city': 'Alexandria',
        'subtitle': 'Mediterranean Pearl',
      },
      {
        'emoji': '🏜️',
        'city': 'Giza',
        'subtitle': 'Land of Pyramids',
      },
    ];
  }

  /// Fetch saved tours for the current user
  static Future<List<Map<String, dynamic>>>
      getMyTours() async {
    await Future.delayed(
      const Duration(seconds: 1),
    );

    return [
      {
        'id': 'tour_001',
        'city': 'CAIRO',
        'title': 'Cairo Adventure',
        'description':
            'Explore the rich history and vibrant culture '
            'of Cairo over eight unforgettable days.',
        'startDate': 'May 16, 2026',
        'endDate': 'May 23, 2026',
        'days': 8,
        'style': 'Comfort',
        'interests': [
          'Pyramids',
          'History',
          'Food',
        ],
        'accentColor': 'cyan',
      },
      {
        'id': 'tour_002',
        'city': 'LUXOR',
        'title': 'Luxor Explorer',
        'description':
            'Discover the Valley of the Kings and '
            'ancient Egyptian temples.',
        'startDate': 'Jun 1, 2026',
        'endDate': 'Jun 6, 2026',
        'days': 5,
        'style': 'Economy',
        'interests': [
          'History',
          'Art',
          'Desert',
        ],
        'accentColor': 'yellow',
      },
    ];
  }

  // ============================================================
  // PLAN TRIP — BUDGET-BASED TOUR GENERATION
  // ============================================================

  /// Generate a tour using the user's budget and interests.
  ///
  /// NOTE:
  /// This is still a mock implementation.
  /// A real AI API will be connected later.
  static Future<Map<String, dynamic>> generateTour({
    required String destination,
    required DateTime departure,
    required DateTime returnDate,
    required double budget,
    required String currency,
    required List<String> interests,
  }) async {
    // Simulate AI processing time
    await Future.delayed(
      const Duration(seconds: 3),
    );

    // Calculate the trip duration
    final days =
        returnDate.difference(departure).inDays + 1;

    // Reject invalid trip dates
    if (days <= 0) {
      throw Exception(
        'Return date must be on or after departure date.',
      );
    }

    // Reject invalid budgets
    if (!budget.isFinite || budget <= 0) {
      throw Exception(
        'Please enter a valid travel budget.',
      );
    }

    // Generate a simulated itinerary
    final itinerary = _generateFakeItinerary(
      destination,
      days,
    );

    // Return the generated tour data
    return {
      'id': 'tour_new_001',

      'city': destination.toUpperCase(),

      'title': '$destination Adventure',

      'description':
          'Embark on an unforgettable journey through '
          '$destination, where ancient wonders meet '
          'vibrant street life.',

      'startDate': _formatDate(departure),

      'endDate': _formatDate(returnDate),

      'days': days,

      // User-defined budget
      'budget': budget,

      // User-selected currency
      'currency': currency,

      // The user enters a custom budget instead
      // of selecting Economy, Comfort, or Luxury.
      'style': 'Custom Budget',

      // User-selected interests
      'interests': List<String>.from(interests),

      // Simulated daily activities
      'itinerary': itinerary,
    };
  }

  // ============================================================
  // TOUR DETAIL
  // ============================================================

  /// Fetch a single tour by ID
  static Future<Map<String, dynamic>> getTourById(
    String tourId,
  ) async {
    await Future.delayed(
      const Duration(milliseconds: 800),
    );

    return {
      'id': tourId,
      'city': 'CAIRO',
      'title': 'Cairo Adventure',
      'description':
          'Embark on an unforgettable journey through '
          'Cairo, where ancient wonders meet vibrant '
          'street life.',
      'startDate': 'May 16, 2026',
      'endDate': 'May 23, 2026',
      'days': 8,
      'style': 'Comfort',
      'interests': [
        'Pyramids',
        'History',
        'Food',
      ],
      'itinerary': _generateFakeItinerary(
        'Cairo',
        8,
      ),
    };
  }

  // ============================================================
  // HELPERS
  // ============================================================

  /// Format a date for display
  static String _formatDate(DateTime date) {
    const months = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    return '${months[date.month]} '
        '${date.day}, ${date.year}';
  }

  /// Generate a simulated itinerary
  static List<Map<String, dynamic>>
      _generateFakeItinerary(
    String destination,
    int days,
  ) {
    // Activities available for each destination
    final Map<String, List<Map<String, dynamic>>> pool = {
      'Cairo': [
        {
          'emoji': '🏛️',
          'time': '9:00 AM',
          'duration': '3 hrs',
          'title': 'Giza Pyramid Complex',
          'color': 'blue',
        },
        {
          'emoji': '🥗',
          'time': '12:30 PM',
          'duration': '1.5 hrs',
          'title': 'Lunch at Felfela',
          'color': 'orange',
        },
        {
          'emoji': '🏛️',
          'time': '2:00 PM',
          'duration': '1 hr',
          'title': 'Great Sphinx of Giza',
          'color': 'blue',
        },
        {
          'emoji': '🌙',
          'time': '3:30 PM',
          'duration': '1.5 hrs',
          'title': 'Sound and Light Show',
          'color': 'purple',
        },
        {
          'emoji': '🏺',
          'time': '9:00 AM',
          'duration': '3 hrs',
          'title': 'Egyptian Museum',
          'color': 'blue',
        },
        {
          'emoji': '🛍️',
          'time': '1:00 PM',
          'duration': '2 hrs',
          'title': 'Khan el-Khalili Bazaar',
          'color': 'green',
        },
        {
          'emoji': '🕌',
          'time': '3:30 PM',
          'duration': '1 hr',
          'title': 'Al-Azhar Mosque',
          'color': 'blue',
        },
        {
          'emoji': '🚢',
          'time': '8:00 AM',
          'duration': '4 hrs',
          'title': 'Nile Felucca Cruise',
          'color': 'cyan',
        },
      ],

      'Luxor': [
        {
          'emoji': '👑',
          'time': '8:00 AM',
          'duration': '4 hrs',
          'title': 'Valley of the Kings',
          'color': 'yellow',
        },
        {
          'emoji': '🏛️',
          'time': '1:00 PM',
          'duration': '2 hrs',
          'title': 'Karnak Temple',
          'color': 'blue',
        },
        {
          'emoji': '🚢',
          'time': '6:00 PM',
          'duration': '2 hrs',
          'title': 'Nile Sunset Cruise',
          'color': 'cyan',
        },
        {
          'emoji': '🎨',
          'time': '9:00 AM',
          'duration': '2 hrs',
          'title': 'Luxor Museum',
          'color': 'purple',
        },
      ],

      'Aswan': [
        {
          'emoji': '🐪',
          'time': '9:00 AM',
          'duration': '3 hrs',
          'title': 'Nubian Village Tour',
          'color': 'orange',
        },
        {
          'emoji': '🏛️',
          'time': '1:00 PM',
          'duration': '2 hrs',
          'title': 'Philae Temple',
          'color': 'blue',
        },
        {
          'emoji': '🚢',
          'time': '5:00 PM',
          'duration': '2 hrs',
          'title': 'Felucca Ride at Sunset',
          'color': 'cyan',
        },
      ],
    };

    // Match the destination regardless of capitalization
    final normalizedDestination =
        destination.trim().toLowerCase();

    final matchedDestination = pool.keys.firstWhere(
      (key) => key.toLowerCase() == normalizedDestination,
      orElse: () => 'Cairo',
    );

    final activities = pool[matchedDestination]!;

    // Create one group of activities per day
    return List.generate(days, (dayIndex) {
      final startIndex = (dayIndex * 3) % activities.length;

      final dayActivities = [
        activities[startIndex % activities.length],
        activities[(startIndex + 1) % activities.length],
        activities[(startIndex + 2) % activities.length],
      ];

      return {
        'dayNumber': dayIndex + 1,
        'title': _dayTitle(dayIndex),
        'activities': dayActivities,
      };
    });
  }

  /// Get a title for each day
  static String _dayTitle(int index) {
    const titles = [
      '✨ Ancient Wonders & Pyramids',
      '🏺 Museums & History',
      '🚢 Nile & Local Life',
      '🛍️ Bazaars & Food',
      '🌅 Desert & Sunsets',
      '🎨 Art & Culture',
      '🕌 Mosques & Architecture',
      '🌊 Leisure & Relaxation',
    ];

    return titles[index % titles.length];
  }
}

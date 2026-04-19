import 'package:flutter/material.dart';

void main() => runApp(const FriendzyApp());

class FriendzyApp extends StatelessWidget {
  const FriendzyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFAF9FE),
      ),
      home: const MatchesScreen(),
    );
  }
}

class MatchesScreen extends StatelessWidget {
  const MatchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildStatsSection(),
            _buildYourMatchesHeader(),
            Expanded(
              child: _buildMatchesGrid(),
            ),
            _buildBottomNav(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildIconButton(Icons.arrow_back_ios_new, size: 20),
          const Text(
            'Matches',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1A2E),
            ),
          ),
          _buildIconButton(Icons.tune, size: 24),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon, {double size = 24}) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Icon(
        icon,
        size: size,
        color: const Color(0xFF1A1A2E),
      ),
    );
  }

  Widget _buildStatsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildStatItem(
            iconImage: 'assets/heart.png',
            label: 'Likes',
            count: '32',
            backgroundImage: 'assets/bg1.png',
          ),
          const SizedBox(width: 24),
          _buildStatItem(
            iconImage: 'assets/chat.png',
            label: 'Connect',
            count: '15',
            backgroundImage: 'assets/bg2.png',
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required String iconImage,
    required String label,
    required String count,
    required String backgroundImage,
  }) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          padding: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(
              color: const Color(0xFFDD88CF),
              width: 2,
            ),
          ),
          child: ClipOval(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    backgroundImage,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(color: Colors.grey.shade300);
                    },
                  ),
                ),
                Center(
                  child: Image.asset(
                    iconImage,
                    width: 40,
                    height: 40,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        RichText(
          text: TextSpan(
            style: const TextStyle(fontSize: 16),
            children: [
              TextSpan(
                text: '$label ',
                style: const TextStyle(
                  color: Color(0xFF1A1A2E),
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextSpan(
                text: count,
                style: const TextStyle(
                  color: const Color(0xFFDD88CF),
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildYourMatchesHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
      child: Row(
        children: [
          const Text(
            'Your Matches',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Color(0xFF4A2C5A),
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            '47',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Color(0xFFDD88CF),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMatchesGrid() {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.65,
      ),
      itemCount: matches.length,
      itemBuilder: (context, index) {
        return _buildMatchCard(context, matches[index]);
      },
    );
  }

  Widget _buildMatchCard(BuildContext context, Map<String, dynamic> match) {
    return GestureDetector(
      onTap: () {
        if (match['name'] == 'Alfredo') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AlfredoProfileScreen()),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: Color(0xFFDD88CF),
            width: 5,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(21),
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  match['image'],
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(color: Colors.grey[300]);
                  },
                ),
              ),
              Positioned(
                top: 0,
                left: 40,
                right: 40,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  decoration: BoxDecoration(
                    color: Color(0xFFDD88CF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${match['matchPercentage']}% Match',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 90,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.white,
                        width: 0.6,
                      ),
                    ),
                    child: Text(
                      '${match['distance']} km away',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                left: 12,
                right: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${match['name']}, ${match['age']}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        if (match['online'] ?? false) ...[
                          const SizedBox(width: 6),
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: Color(0xFF4ADE80),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      match['location'].toUpperCase(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home_outlined, false),
          _buildNavItem(Icons.explore_outlined, false),
          _buildNavItem(Icons.add, false),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Color(0xFFDD88CF),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.people,
              color: Colors.white,
              size: 28,
            ),
          ),
          _buildNavItem(Icons.chat_bubble_outline, false),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, bool isActive, {Color? activeColor}) {
    return Container(
      width: 55,
      height: 48,
      decoration: isActive
          ? BoxDecoration(
        color: (activeColor ?? const Color(0xFFC471F5)).withOpacity(0.15),
        shape: BoxShape.circle,
      )
          : null,
      child: Icon(
        icon,
        color: isActive ? (activeColor ?? const Color(0xFFC471F5)) : const Color(0xFF9B9B9B),
        size: 24,
      ),
    );
  }
}

class AlfredoProfileScreen extends StatelessWidget {
  const AlfredoProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/alfredoFull.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(color: Colors.grey[300]);
              },
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: _buildTopButton(Icons.arrow_back, Colors.white),
                  ),
                  _buildDistanceBadge(),
                ],
              ),
            ),
          ),

          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Alfredo Calzoni, 20',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    shadows: [Shadow(blurRadius: 8, color: Colors.black26)],
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'HAMBURG, GERMANY',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 24),
                _buildMatchButton(),
              ],
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 110),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(height: 24),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: const Text('About', style: TextStyle(color: Colors.grey, fontSize: 16)),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'A good listener. I love having a good talk to know each other\'s side 😍.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, height: 1.4),
                    ),
                    const SizedBox(height: 24),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: const Text('Interest', style: TextStyle(color: Colors.grey, fontSize: 16)),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        _buildTag('🌿 Nature'),
                        _buildTag('🏝️ Travel'),
                        _buildTag('✍️ Writing'),
                        _buildTag('😊 Pe'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildActionButton(Icons.close, Colors.grey.shade600, Colors.white),
                const SizedBox(width: 24),
                _buildActionButton(Icons.star, Colors.white, const Color(0xFF4A148C)),
                const SizedBox(width: 24),
                _buildActionButton(Icons.favorite, Colors.white, Colors.pink.shade300),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopButton(IconData icon, Color color) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: color)),
      child: Icon(icon, color: color, size: 20),
    );
  }

  Widget _buildDistanceBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white),
      ),
      child: const Row(
        children: [
          Icon(Icons.location_on_outlined, color: Colors.white, size: 16),
          SizedBox(width: 4),
          Text('2.5 km', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildMatchButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF7B1FA2),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.pink.shade200, width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 50,
            height: 36,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: 0.8,
                  color: Colors.pink.shade200,
                  backgroundColor: Colors.white.withOpacity(0.3),
                  strokeWidth: 3,
                ),
                const Text('80%', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(width: 12),
          const Text('Match', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(width: 12),
        ],
      ),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text, style: const TextStyle(fontSize: 14)),
    );
  }

  Widget _buildActionButton(IconData icon, Color iconColor, Color bgColor) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: bgColor,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8, offset: const Offset(0, 4))
        ],
      ),
      child: Icon(icon, color: iconColor, size: 28),
    );
  }
}

final List<Map<String, dynamic>> matches = [
  {
    'name': 'James',
    'age': 20,
    'location': 'Hanover',
    'distance': 1.3,
    'matchPercentage': 100,
    'online': true,
    'image': 'assets/james.png',
  },
  {
    'name': 'Eddie',
    'age': 23,
    'location': 'Dortmund',
    'distance': 2,
    'matchPercentage': 94,
    'online': true,
    'image': 'assets/eddie.png',
  },
  {
    'name': 'Brandon',
    'age': 20,
    'location': 'Berlin',
    'distance': 2.5,
    'matchPercentage': 89,
    'online': false,
    'image': 'assets/brandon.png',
  },
  {
    'name': 'Alfredo',
    'age': 20,
    'location': 'Munich',
    'distance': 2.5,
    'matchPercentage': 80,
    'online': true,
    'image': 'assets/alfredo.png',
  },
];
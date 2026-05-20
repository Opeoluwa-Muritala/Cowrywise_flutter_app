import 'package:flutter/material.dart';
import '../theme.dart';

class CompanyProfileScreen extends StatefulWidget {
  const CompanyProfileScreen({super.key});

  @override
  State<CompanyProfileScreen> createState() => _CompanyProfileScreenState();
}

class _CompanyProfileScreenState extends State<CompanyProfileScreen> {
  bool _isFollowing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
        onTap: (index) {
          if (index == 0) Navigator.pop(context);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.explore_outlined), activeIcon: Icon(Icons.explore), label: 'Discover'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark_outline), activeIcon: Icon(Icons.bookmark), label: 'Saved'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment_outlined), activeIcon: Icon(Icons.assignment), label: 'Applied'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), activeIcon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          children: [
            _header(context),
            const SizedBox(height: 12),
            _hero(),
            const SizedBox(height: 58),
            const Center(child: Text('Spotify', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900))),
            const SizedBox(height: 4),
            const Center(child: Text('Music & Entertainment', style: TextStyle(color: AppColors.textSecondary, fontSize: 12))),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                _TinyMeta(icon: Icons.people_outline, text: '5,001 - 10,000 Employees'),
                SizedBox(width: 12),
                _TinyMeta(icon: Icons.location_on_outlined, text: 'Stockholm, SE'),
              ],
            ),
            const SizedBox(height: 18),
            SizedBox(
              height: 46,
              child: ElevatedButton(
                onPressed: () => setState(() => _isFollowing = !_isFollowing),
                style: ElevatedButton.styleFrom(backgroundColor: _isFollowing ? AppColors.chipBackground : AppColors.primary, foregroundColor: _isFollowing ? AppColors.primary : Colors.white),
                child: Text(_isFollowing ? 'Following' : 'Follow Company'),
              ),
            ),
            const SizedBox(height: 26),
            _aboutCard(),
            const SizedBox(height: 24),
            const Text('Culture & Life', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900)),
            const SizedBox(height: 12),
            _cultureCard(height: 170, label: 'Collaborative Hubs', colors: const [Color(0xFF214E7B), Color(0xFFE18B48)]),
            const SizedBox(height: 10),
            _cultureCard(height: 92, label: '', colors: const [Color(0xFF0F172A), Color(0xFF6B8AA8)]),
            const SizedBox(height: 24),
            Row(
              children: [
                const Expanded(child: Text('Open Android\nRoles', style: TextStyle(fontSize: 17, height: 1.15, fontWeight: FontWeight.w900))),
                _orangePill('3 ROLES'),
              ],
            ),
            const SizedBox(height: 12),
            _roleCard('Senior Android Engineer,\nPlayer Experience', 'Remote', ['Kotlin', 'Compose', 'Dagger/Hilt']),
            _roleCard('Android SDK Specialist', 'Stockholm - Hybrid', ['SDK Design', 'Java/Kotlin', 'Performance']),
            const SizedBox(height: 18),
            _quickInsights(),
            const SizedBox(height: 16),
            _techEcosystem(),
          ],
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Row(
      children: [
        IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back)),
        const Expanded(child: Text('Opportunity', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w900))),
        IconButton(onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No new notifications.'))), icon: const Icon(Icons.notifications_none, size: 21)),
        const CircleAvatar(radius: 15, backgroundColor: AppColors.textPrimary, child: Icon(Icons.person, color: Colors.white, size: 15)),
      ],
    );
  }

  Widget _hero() {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: 170,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            gradient: const LinearGradient(colors: [Color(0xFFCFD8DC), Color(0xFF64748B)], begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
          child: const Center(child: Icon(Icons.apartment, color: Colors.white70, size: 64)),
        ),
        Positioned(
          bottom: -38,
          child: Container(
            width: 76,
            height: 76,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 22)]),
            child: const Icon(Icons.music_note, color: Color(0xFF1DB954), size: 36),
          ),
        ),
      ],
    );
  }

  Widget _aboutCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('About the Company', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900)),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
          child: const Text(
            'Our mission is to unlock the potential of human creativity - by giving a million creative artists the opportunity to live off their art and billions of fans the opportunity to enjoy and be inspired by it.\n\nSpotify is a global music, podcast, and video service that gives you access to millions of songs and other content from creators all over the world.',
            style: TextStyle(color: AppColors.textSecondary, height: 1.48, fontSize: 12),
          ),
        ),
      ],
    );
  }

  Widget _cultureCard({required double height, required String label, required List<Color> colors}) {
    return Container(
      height: height,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(22), gradient: LinearGradient(colors: colors, begin: Alignment.topLeft, end: Alignment.bottomRight)),
      child: Stack(
        children: [
          const Positioned(right: 20, top: 20, child: Icon(Icons.groups_2_outlined, color: Colors.white30, size: 54)),
          if (label.isNotEmpty)
            Positioned(
              left: 14,
              bottom: 14,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(color: AppColors.accent, borderRadius: BorderRadius.circular(12)),
                child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w800)),
              ),
            ),
        ],
      ),
    );
  }

  Widget _roleCard(String title, String subtitle, List<String> tags) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$title selected'))),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 13)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(color: AppColors.textSecondary, fontSize: 11)),
                  const SizedBox(height: 10),
                  Wrap(spacing: 6, runSpacing: 6, children: tags.map(_chip).toList()),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }

  Widget _quickInsights() {
    return _infoPanel(
      title: 'QUICK INSIGHTS',
      children: const [
        _InsightRow(icon: Icons.groups_outlined, label: 'Company Size', value: '123K+ Staff'),
        _InsightRow(icon: Icons.work_outline, label: 'Work Mode', value: 'Work From Anywhere'),
        _InsightRow(icon: Icons.star_border, label: 'Glassdoor', value: '4.8 / 5.0'),
      ],
    );
  }

  Widget _techEcosystem() {
    return _infoPanel(
      title: 'TECHNICAL ECOSYSTEM',
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: ['Kotlin Multiplatform', 'Jetpack Compose', 'GraphQL', 'Coroutines', 'Bazel'].map(_chip).toList(),
        ),
      ],
    );
  }

  Widget _infoPanel({required String title, required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(color: AppColors.textSecondary, fontSize: 10, fontWeight: FontWeight.w900)),
        const SizedBox(height: 12),
        ...children,
      ]),
    );
  }

  Widget _chip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(color: AppColors.chipBackground, borderRadius: BorderRadius.circular(10)),
      child: Text(label, style: const TextStyle(fontSize: 9, color: AppColors.textSecondary, fontWeight: FontWeight.w800)),
    );
  }

  Widget _orangePill(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(color: AppColors.accent, borderRadius: BorderRadius.circular(14)),
      child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w900)),
    );
  }
}

class _TinyMeta extends StatelessWidget {
  final IconData icon;
  final String text;

  const _TinyMeta({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(icon, size: 13, color: AppColors.textSecondary),
      const SizedBox(width: 4),
      Text(text, style: const TextStyle(color: AppColors.textSecondary, fontSize: 10)),
    ]);
  }
}

class _InsightRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InsightRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(children: [
        CircleAvatar(radius: 16, backgroundColor: AppColors.lightBlue, child: Icon(icon, color: AppColors.primary, size: 16)),
        const SizedBox(width: 10),
        Expanded(child: Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 11, fontWeight: FontWeight.w700))),
        Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900)),
      ]),
    );
  }
}

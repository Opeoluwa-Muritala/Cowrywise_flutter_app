import 'package:flutter/material.dart';
import '../theme.dart';

class CompanyProfileScreen extends StatelessWidget {
  const CompanyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text('Opportunity', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            actions: [
              IconButton(icon: const Icon(Icons.person_outline, color: Colors.black), onPressed: () {}),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                'https://placeholder.com/company_bg', // Placeholder
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey.shade200),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Transform.translate(
              offset: const Offset(0, -30),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                ),
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20)],
                        ),
                        child: const Icon(Icons.music_note, size: 40, color: Color(0xFF1DB954)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Center(
                      child: Column(
                        children: [
                          Text('Spotify', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                          Text('Music & Entertainment', style: TextStyle(color: AppColors.textSecondary)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildCompanyStat(Icons.people_outline, '5,001 - 10,000 Employees'),
                        const SizedBox(width: 16),
                        _buildCompanyStat(Icons.location_on_outlined, 'Stockholm, SE'),
                      ],
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Follow Company'),
                    ),
                    const SizedBox(height: 32),
                    const Text('About the Company', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    const Text(
                      "Our mission is to unlock the potential of human creativity—by giving a million creative artists the opportunity to live off their art and billions of fans the opportunity to enjoy and be inspired by it.\n\nSpotify is a digital music, podcast, and video service that gives you access to millions of songs and other content from creators all over the world.",
                      style: TextStyle(color: AppColors.textSecondary, height: 1.5),
                    ),
                    const SizedBox(height: 32),
                    const Text('Culture & Life', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    _buildCultureImage(),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Open Android Roles', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(color: AppColors.accent, borderRadius: BorderRadius.circular(8)),
                          child: const Text('3 POSITIONS', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildRoleItem('Senior Android Engineer, Player Experience', 'Remote (Stockholm) • Full-time', ['KOTLIN', 'COMPOSE', 'DAGGER HILT']),
                    _buildRoleItem('Android SDK Specialist', 'Stockholm • Hybrid', ['SDK DESIGN', 'JAVA/KOTLIN', 'PERFORMANCE']),
                    const SizedBox(height: 32),
                    const Text('QUICK INSIGHTS', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1)),
                    const SizedBox(height: 16),
                    _buildInsightTile(Icons.trending_up, 'GROWTH RATE', '12% YOY'),
                    _buildInsightTile(Icons.work_outline, 'WORK MODE', 'Work From Anywhere'),
                    _buildInsightTile(Icons.star_outline, 'GLASSDOOR', '4.2 / 5.0'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompanyStat(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: AppColors.textSecondary),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
      ],
    );
  }

  Widget _buildCultureImage() {
    return Column(
      children: [
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: const DecorationImage(
              image: NetworkImage('https://placeholder.com/culture1'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            alignment: Alignment.bottomLeft,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.transparent, Colors.black.withOpacity(0.7)]),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Text('Collaborative Hubs', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: Container(height: 100, decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.grey.shade200))),
            const SizedBox(width: 12),
            Expanded(child: Container(height: 100, decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.grey.shade200))),
          ],
        ),
      ],
    );
  }

  Widget _buildRoleItem(String title, String subtitle, List<String> tags) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14))),
              const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(color: AppColors.textSecondary, fontSize: 11)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: tags.map((tag) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
              child: Text(tag, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.grey)),
            )).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildInsightTile(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), shape: BoxShape.circle),
            child: Icon(icon, size: 20, color: AppColors.primary),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold)),
              Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            ],
          ),
        ],
      ),
    );
  }
}

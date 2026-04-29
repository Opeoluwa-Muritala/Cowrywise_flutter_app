import 'package:flutter/material.dart';
import '../theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.black,
                        child: Icon(Icons.person, color: Colors.white, size: 20),
                      ),
                      SizedBox(width: 12),
                      Text(
                        'SkillBoard',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.primary),
                      ),
                    ],
                  ),
                  const Icon(Icons.tune, color: AppColors.primary),
                ],
              ),
              const SizedBox(height: 32),
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(24),
                        image: const DecorationImage(
                          image: NetworkImage('https://placeholder.com/profile'), // Placeholder
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: const Icon(Icons.person, size: 60, color: Colors.white24),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Marcus Chen',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'Senior Android Engineer',
                      style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStat('12', 'PROJECTS'),
                  Container(width: 1, height: 30, color: Colors.grey.shade200),
                  _buildStat('8.4k', 'IMPACT'),
                  Container(width: 1, height: 30, color: Colors.grey.shade200),
                  _buildStat('4', 'AWARDS'),
                ],
              ),
              const SizedBox(height: 32),
              _buildSectionTitle('About'),
              const SizedBox(height: 12),
              const Text(
                'Passionate about building fluid, performant mobile experiences. Specialized in Jetpack Compose, Kotlin Multiplatform, and reactive architecture. Currently leading core initiatives at tech-flow.',
                style: TextStyle(color: AppColors.textSecondary, height: 1.5),
              ),
              const SizedBox(height: 32),
              _buildSectionTitle('Core Expertise'),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildExpertiseChip('KOTLIN'),
                  _buildExpertiseChip('JETPACK COMPOSE'),
                  _buildExpertiseChip('COROUTINES'),
                  _buildExpertiseChip('DAGGER HILT'),
                  _buildExpertiseChip('CLEAN ARCHITECTURE'),
                  _buildExpertiseChip('SENIOR LEVEL', color: AppColors.accent),
                ],
              ),
              const SizedBox(height: 32),
              _buildMenuItem(Icons.edit_outlined, 'Edit Profile'),
              _buildMenuItem(Icons.settings_outlined, 'Preferences'),
              const SizedBox(height: 16),
              _buildMenuItem(Icons.logout, 'LogOut', color: Colors.red),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStat(String value, String label) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 10, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildExpertiseChip(String label, {Color? color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color?.withOpacity(0.1) ?? AppColors.chipBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color ?? AppColors.textPrimary,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, {Color? color}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: color ?? AppColors.primary),
          const SizedBox(width: 16),
          Text(title, style: TextStyle(fontWeight: FontWeight.w500, color: color)),
          const Spacer(),
          Icon(Icons.chevron_right, size: 20, color: Colors.grey.shade400),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../theme.dart';
import '../models/job.dart';
import '../services/job_service.dart';
import 'company_profile_screen.dart';
import 'filter_screen.dart';
import 'job_listing_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Job> _jobs = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadJobs();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadJobs({String? query}) async {
    setState(() => _isLoading = true);
    final jobs = await JobService.getJobs(query: query);
    if (mounted) {
      setState(() {
        _jobs = jobs;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final featuredJob = _jobs.length > 3 ? _jobs[3] : (_jobs.isNotEmpty ? _jobs.first : null);
    return Scaffold(
      backgroundColor: AppColors.background,
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Create alert coming soon.'))),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => _loadJobs(query: _searchController.text),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            children: [
              _header(),
              const SizedBox(height: 24),
              const Text('GOOD MORNING, ALEX', style: TextStyle(color: AppColors.textSecondary, fontSize: 11, fontWeight: FontWeight.w900)),
              const SizedBox(height: 8),
              const Text('Your next career\nmove is waiting.', style: TextStyle(fontSize: 29, height: 1.08, fontWeight: FontWeight.w900)),
              const SizedBox(height: 22),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      onSubmitted: (value) => _loadJobs(query: value),
                      decoration: const InputDecoration(
                        hintText: 'Search roles, companies, or skills...',
                        prefixIcon: Icon(Icons.search, size: 18),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(22)), borderSide: BorderSide.none),
                      ),
                      onChanged: (_) => setState(() {}),
                    ),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FilterScreen())),
                    child: Container(
                      width: 46,
                      height: 46,
                      decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                      child: const Icon(Icons.tune, color: Colors.white, size: 20),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 26),
              _sectionHeader(
                'Jobs for You',
                subtitle: 'Curated based on your Senior UI Designer profile',
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const JobListingScreen())),
              ),
              const SizedBox(height: 14),
              if (_isLoading)
                const Center(child: Padding(padding: EdgeInsets.all(28), child: CircularProgressIndicator()))
              else if (featuredJob != null)
                _featuredJobCard(featuredJob),
              const SizedBox(height: 28),
              const Text('Recent Opportunities', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
              const SizedBox(height: 14),
              _skeletonCard(),
              _skeletonCard(),
              _skeletonCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Row(
      children: [
        const CircleAvatar(radius: 18, backgroundColor: AppColors.textPrimary, child: Icon(Icons.person, color: Colors.white, size: 18)),
        const SizedBox(width: 10),
        const Expanded(child: Text('Opportunity', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w900, fontSize: 16))),
        IconButton(onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No new notifications.'))), icon: const Icon(Icons.notifications_none)),
      ],
    );
  }

  Widget _sectionHeader(String title, {required String subtitle, VoidCallback? onTap}) {
    return Row(
      children: [
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
            const SizedBox(height: 4),
            Text(subtitle, style: const TextStyle(color: AppColors.textSecondary, fontSize: 11)),
          ]),
        ),
        TextButton(onPressed: onTap, child: const Text('View all')),
      ],
    );
  }

  Widget _featuredJobCard(Job job) {
    return InkWell(
      borderRadius: BorderRadius.circular(28),
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CompanyProfileScreen())),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 10))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _logo(job.logo),
                const Spacer(),
                IconButton(
                  onPressed: () => setState(() => JobService.toggleSaveJob(job.id)),
                  icon: Icon(job.isSaved ? Icons.bookmark : Icons.bookmark_border, color: AppColors.primary),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Text(job.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
            const SizedBox(height: 4),
            Text('${job.company} - ${job.location}', style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
            const SizedBox(height: 14),
            _salaryBadge(job.salary),
          ],
        ),
      ),
    );
  }

  Widget _skeletonCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.7), borderRadius: BorderRadius.circular(24)),
      child: Row(
        children: [
          Container(width: 48, height: 48, decoration: BoxDecoration(color: AppColors.chipBackground, borderRadius: BorderRadius.circular(18))),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 12, width: double.infinity, decoration: BoxDecoration(color: AppColors.chipBackground, borderRadius: BorderRadius.circular(12))),
                const SizedBox(height: 10),
                Container(height: 12, width: 120, decoration: BoxDecoration(color: AppColors.chipBackground, borderRadius: BorderRadius.circular(12))),
              ],
            ),
          ),
          const SizedBox(width: 14),
          Container(width: 38, height: 38, decoration: BoxDecoration(color: AppColors.chipBackground, borderRadius: BorderRadius.circular(18))),
        ],
      ),
    );
  }

  Widget _logo(String text) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(color: AppColors.chipBackground, borderRadius: BorderRadius.circular(16)),
      child: Center(child: Text(text.isEmpty ? '?' : text.substring(0, 1), style: const TextStyle(fontWeight: FontWeight.w900))),
    );
  }

  Widget _salaryBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(color: AppColors.accent.withOpacity(0.12), borderRadius: BorderRadius.circular(18)),
      child: Text(text, style: const TextStyle(color: AppColors.accent, fontSize: 11, fontWeight: FontWeight.w900)),
    );
  }
}

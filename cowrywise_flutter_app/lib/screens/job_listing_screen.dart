import 'package:flutter/material.dart';
import '../theme.dart';
import '../models/job.dart';
import '../services/job_service.dart';
import 'company_profile_screen.dart';

class JobListingScreen extends StatefulWidget {
  const JobListingScreen({super.key});

  @override
  State<JobListingScreen> createState() => _JobListingScreenState();
}

class _JobListingScreenState extends State<JobListingScreen> {
  List<Job> _jobs = [];
  bool _isLoading = true;
  String _selectedCategory = 'All Jobs';
  final Set<String> _savedIds = {'spotify_product_designer'};

  @override
  void initState() {
    super.initState();
    _loadJobs();
  }

  Future<void> _loadJobs() async {
    final jobs = await JobService.getJobs();
    if (mounted) {
      setState(() {
        _jobs = jobs.take(3).toList();
        _isLoading = false;
      });
    }
  }

  void _openCompany() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => const CompanyProfileScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index != 0) Navigator.pop(context);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.explore_outlined), activeIcon: Icon(Icons.explore), label: 'Discover'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark_outline), activeIcon: Icon(Icons.bookmark), label: 'Saved'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment_outlined), activeIcon: Icon(Icons.assignment), label: 'Applied'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), activeIcon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                children: [
                  _header(),
                  const SizedBox(height: 20),
                  const Text('Find your next career\nmove', style: TextStyle(fontSize: 25, height: 1.12, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 14),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(children: ['All Jobs', 'Remote', 'Design', 'Android', 'Product'].map(_categoryChip).toList()),
                  ),
                  const SizedBox(height: 18),
                  _jobCard(_jobs[0], 'SPOTIFY'),
                  _jobCard(_jobs[1], 'AIRBNB'),
                  _featuredPartnerCard(),
                  _jobCard(_jobs[2], 'STRIPE'),
                ],
              ),
      ),
    );
  }

  Widget _header() {
    return Row(
      children: [
        const CircleAvatar(radius: 17, backgroundColor: AppColors.textPrimary, child: Icon(Icons.person, color: Colors.white, size: 17)),
        const SizedBox(width: 8),
        const Expanded(child: Text('Opportunity', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w900, fontSize: 16))),
        IconButton(onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No new notifications.'))), icon: const Icon(Icons.notifications_none, size: 21)),
      ],
    );
  }

  Widget _categoryChip(String label) {
    final selected = _selectedCategory == label;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        selectedColor: AppColors.primary,
        backgroundColor: Colors.white,
        labelStyle: TextStyle(color: selected ? Colors.white : AppColors.textSecondary, fontSize: 11, fontWeight: FontWeight.w800),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18), side: BorderSide(color: selected ? AppColors.primary : AppColors.border)),
        onSelected: (_) => setState(() => _selectedCategory = label),
      ),
    );
  }

  Widget _jobCard(Job job, String category) {
    final saved = _savedIds.contains(job.id);
    return InkWell(
      onTap: _openCompany,
      borderRadius: BorderRadius.circular(22),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 18, offset: const Offset(0, 10))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _logo(job.logo),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(category, style: const TextStyle(color: AppColors.textSecondary, fontSize: 9, fontWeight: FontWeight.w900)),
                      const SizedBox(height: 3),
                      Text(job.title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w900)),
                      const SizedBox(height: 3),
                      Text('${job.company} - ${job.location}', maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: AppColors.textSecondary, fontSize: 11)),
                    ],
                  ),
                ),
                IconButton(
                  constraints: const BoxConstraints(),
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    setState(() {
                      saved ? _savedIds.remove(job.id) : _savedIds.add(job.id);
                      JobService.toggleSaveJob(job.id);
                    });
                  },
                  icon: Icon(saved ? Icons.bookmark : Icons.bookmark_border, color: saved ? AppColors.primary : AppColors.textSecondary, size: 20),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(children: [_salaryBadge(job.salary), const SizedBox(width: 8), ...job.tags.take(2).map(_tag)]),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.access_time, size: 13, color: Colors.grey.shade400),
                const SizedBox(width: 4),
                Text(job.timeAgo, style: const TextStyle(color: AppColors.textSecondary, fontSize: 10)),
                const Spacer(),
                TextButton(onPressed: _openCompany, child: const Text('Details +', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900))),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _featuredPartnerCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('FEATURED PARTNER', style: TextStyle(color: Colors.white70, fontSize: 9, fontWeight: FontWeight.w900)),
          const SizedBox(height: 10),
          const Text('Lead UI Artist for\nNext-Gen Platforms', style: TextStyle(color: Colors.white, fontSize: 19, height: 1.12, fontWeight: FontWeight.w900)),
          const SizedBox(height: 14),
          const Row(
            children: [
              CircleAvatar(radius: 14, backgroundColor: Colors.white24, child: Icon(Icons.palette_outlined, color: Colors.white, size: 15)),
              SizedBox(width: 8),
              Text('ByteCreative\nBerlin, Germany', style: TextStyle(color: Colors.white70, fontSize: 11, height: 1.25)),
            ],
          ),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            height: 42,
            child: ElevatedButton(
              onPressed: _openCompany,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: AppColors.primary),
              child: const Text('View Partnership'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _logo(String text) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(color: AppColors.chipBackground, borderRadius: BorderRadius.circular(14)),
      child: Center(child: Text(text.isEmpty ? '?' : text.substring(0, 1), style: const TextStyle(fontWeight: FontWeight.w900))),
    );
  }

  Widget _salaryBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(color: AppColors.accent.withOpacity(0.12), borderRadius: BorderRadius.circular(10)),
      child: Text(text, style: const TextStyle(color: AppColors.accent, fontSize: 9, fontWeight: FontWeight.w900)),
    );
  }

  Widget _tag(String label) {
    return Container(
      margin: const EdgeInsets.only(right: 6),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(color: AppColors.chipBackground, borderRadius: BorderRadius.circular(10)),
      child: Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 9, fontWeight: FontWeight.w800)),
    );
  }
}

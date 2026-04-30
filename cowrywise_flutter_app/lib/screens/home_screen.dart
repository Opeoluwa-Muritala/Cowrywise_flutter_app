import 'package:flutter/material.dart';
import '../theme.dart';
import '../models/job.dart';
import '../services/job_service.dart';
import 'job_details_screen.dart';

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
    if (!mounted) return;
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: CircleAvatar(
            backgroundColor: Colors.black,
            child: Icon(Icons.person, size: 20, color: Colors.white),
          ),
        ),
        title: const Text(
          'Marcus Chen',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _loadJobs(query: _searchController.text),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'GOOD MORNING, MARCUS',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Your next career\nmove is waiting.',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      onSubmitted: (value) => _loadJobs(query: value),
                      decoration: InputDecoration(
                        hintText: 'Search roles, companies, or...',
                        prefixIcon: const Icon(Icons.search),
                        filled: true,
                        fillColor: AppColors.cardBackground,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear, size: 18),
                          onPressed: () {
                            _searchController.clear();
                            _loadJobs();
                          },
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {}); 
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.tune, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              _isLoading
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.all(32.0),
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Jobs for You',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text('View all', style: TextStyle(color: AppColors.primary)),
                            ),
                          ],
                        ),
                        const Text(
                          'Curated based on your Senior Android Engineer profile',
                          style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
                        ),
                        const SizedBox(height: 16),
                        if (_jobs.isNotEmpty)
                          _buildFeaturedJobCard(_jobs.first)
                        else
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text('No jobs found matching your search.'),
                            ),
                          ),
                        const SizedBox(height: 32),
                        if (_jobs.length > 1) ...[
                          const Text(
                            'Recent Opportunities',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _jobs.length > 3 ? 3 : _jobs.length - 1,
                            separatorBuilder: (context, index) => const SizedBox(height: 16),
                            itemBuilder: (context, index) {
                              return _buildRecentJobItem(_jobs[index + 1]);
                            },
                          ),
                        ],
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedJobCard(Job job) {
    return InkWell(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => JobDetailsScreen(job: job)),
        );
        if (mounted) _loadJobs(query: _searchController.text);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                      child: Text(job.logo.isNotEmpty ? job.logo : job.company[0],
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold))),
                ),
                const Spacer(),
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: Icon(job.isSaved ? Icons.bookmark : Icons.bookmark_border,
                      color: job.isSaved ? AppColors.primary : Colors.black),
                  onPressed: () {
                    setState(() {
                      JobService.toggleSaveJob(job.id);
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              job.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              '${job.company} • ${job.location}',
              style: const TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.accent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                job.salary,
                style: const TextStyle(
                    color: AppColors.accent,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentJobItem(Job job) {
    return InkWell(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => JobDetailsScreen(job: job)),
        );
        if (mounted) _loadJobs(query: _searchController.text);
      },
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(child: Text(job.logo.isNotEmpty ? job.logo : job.company[0])),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(job.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text('${job.company} • ${job.location}',
                    style: const TextStyle(
                        color: AppColors.textSecondary, fontSize: 12)),
              ],
            ),
          ),
          IconButton(
            icon: Icon(job.isSaved ? Icons.bookmark : Icons.bookmark_border,
                color: job.isSaved ? AppColors.primary : Colors.grey, size: 20),
            onPressed: () {
              setState(() {
                JobService.toggleSaveJob(job.id);
              });
            },
          ),
        ],
      ),
    );
  }
}

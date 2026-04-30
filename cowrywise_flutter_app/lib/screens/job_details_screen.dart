import 'package:flutter/material.dart';
import '../theme.dart';
import '../models/job.dart';
import '../services/job_service.dart';
import 'company_profile_screen.dart';

class JobDetailsScreen extends StatefulWidget {
  final Job job;
  const JobDetailsScreen({super.key, required this.job});

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  late Job _currentJob;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _currentJob = widget.job;
    _fetchFullDetails();
  }

  Future<void> _fetchFullDetails() async {
    // If it's a mock job or already has description, don't fetch from API
    if (_currentJob.id.startsWith('mock_') || _currentJob.description != 'No description available.') {
      return;
    }

    setState(() => _isLoading = true);
    try {
      final details = await JobService.getJobDetails(_currentJob.id);
      if (mounted) {
        setState(() {
          _currentJob = details;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('SkillBoard', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(icon: const Icon(Icons.share_outlined, color: Colors.black), onPressed: () {}),
          IconButton(
            icon: Icon(
              _currentJob.isSaved ? Icons.bookmark : Icons.bookmark_border,
              color: _currentJob.isSaved ? AppColors.primary : Colors.black,
            ),
            onPressed: () {
              setState(() {
                JobService.toggleSaveJob(_currentJob.id);
              });
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CompanyProfileScreen()),
                      );
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: _currentJob.logo.isNotEmpty && _currentJob.logo.startsWith('http')
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(_currentJob.logo, fit: BoxFit.cover),
                            )
                          : Center(
                              child: Text(
                                _currentJob.logo.isNotEmpty ? _currentJob.logo : _currentJob.company[0],
                                style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(_currentJob.title, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, height: 1.1)),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CompanyProfileScreen()),
                      );
                    },
                    child: Text('${_currentJob.company} • ${_currentJob.location}',
                        style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w500)),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _buildInfoBadge(_currentJob.salary),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(child: _buildDetailItem('EXPERIENCE', _currentJob.experience)),
                      Expanded(child: _buildDetailItem('JOB TYPE', _currentJob.type)),
                    ],
                  ),
                  const SizedBox(height: 32),
                  const Text('Job Description', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Text(
                    _currentJob.description,
                    style: const TextStyle(color: AppColors.textSecondary, height: 1.6),
                  ),
                  const SizedBox(height: 32),
                  if (_currentJob.tags.isNotEmpty) ...[
                    const Text('Core Skills', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _currentJob.tags.map((tag) => _buildSkillChip(tag, tag == _currentJob.tags.first)).toList(),
                    ),
                    const SizedBox(height: 32),
                  ],
                  if (_currentJob.requirements.isNotEmpty) ...[
                    const Text('Requirements', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    ..._currentJob.requirements.map((req) => _buildRequirementItem(req)).toList(),
                    const SizedBox(height: 100),
                  ],
                ],
              ),
            ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: const Offset(0, -2))],
        ),
        child: ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Application Submitted Successfully!')),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Apply Now'),
              SizedBox(width: 8),
              Icon(Icons.arrow_forward, size: 18),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoBadge(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.accent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label, style: const TextStyle(color: AppColors.accent, fontWeight: FontWeight.bold, fontSize: 12)),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 10, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildSkillChip(String label, bool isPrimary) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isPrimary ? AppColors.primary : AppColors.chipBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isPrimary ? Colors.white : AppColors.textPrimary,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildRequirementItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 6.0),
            child: Icon(Icons.circle, size: 6, color: AppColors.primary),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: const TextStyle(color: AppColors.textSecondary, height: 1.5))),
        ],
      ),
    );
  }
}

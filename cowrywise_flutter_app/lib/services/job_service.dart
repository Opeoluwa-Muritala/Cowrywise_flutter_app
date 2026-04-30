import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/job.dart';

class JobService {
  static const String _mockUrl = 'https://901522ec-fa4d-4b63-aecc-a237dc24ac90.mock.pstmn.io/jobs';
  
  static final List<Job> _localJobs = [];

  static Future<List<Job>> getJobs({String? query, String? location}) async {
    try {
      final response = await http.get(Uri.parse(_mockUrl));

      if (response.statusCode == 200) {
        // Sanitize the JSON string to remove control characters like newlines within strings
        final sanitizedBody = response.body.replaceAll(RegExp(r'[\x00-\x1F]'), ' ');
        final List<dynamic> rawData = jsonDecode(sanitizedBody);
        final List<Job> fetchedJobs = [];
        
        String currentCompany = '';
        String currentCompanyId = '';
        String currentLogo = '';

        for (var i = 0; i < rawData.length; i++) {
          final item = rawData[i];
          
          if (item is String) continue;

          if (item is Map<String, dynamic>) {
            if (item.containsKey('company')) {
              currentCompany = item['company'] ?? '';
              currentCompanyId = item['id']?.toString() ?? '';
              currentLogo = currentCompany.isNotEmpty ? currentCompany[0] : '';
            } else if (item.containsKey('Title')) {
              final String title = item['Title'] ?? '';
              final String loc = item['Location'] ?? '';
              
              fetchedJobs.add(Job(
                id: '${currentCompanyId}_$i',
                title: title,
                company: currentCompany,
                location: loc,
                salary: 'Confidential',
                type: 'Full-time',
                timeAgo: 'Recently',
                logo: currentLogo,
                tags: [
                  if (loc.toLowerCase().contains('remote')) 'REMOTE',
                  'DESIGN',
                ],
                isRemote: loc.toLowerCase().contains('remote'),
                description: item['Description'] ?? 'No description available.',
                requirements: [],
                experience: 'N/A',
              ));
            }
          }
        }
        
        for (var job in fetchedJobs) {
          final existing = _localJobs.firstWhere((j) => j.id == job.id, orElse: () => job);
          job.isSaved = existing.isSaved;
        }

        List<Job> filteredJobs = fetchedJobs;
        if (query != null && query.isNotEmpty) {
          filteredJobs = fetchedJobs.where((job) => 
            job.title.toLowerCase().contains(query.toLowerCase()) || 
            job.company.toLowerCase().contains(query.toLowerCase())
          ).toList();
        }
        
        _localJobs.clear();
        _localJobs.addAll(fetchedJobs);
        
        return filteredJobs;
      } else {
        throw Exception('Failed to load jobs');
      }
    } catch (e) {
      print('Error fetching jobs: $e');
      return _localJobs;
    }
  }

  static Future<Job> getJobDetails(String id) async {
    return _localJobs.firstWhere((job) => job.id == id);
  }

  static void toggleSaveJob(String id) {
    final index = _localJobs.indexWhere((job) => job.id == id);
    if (index != -1) {
      _localJobs[index].isSaved = !_localJobs[index].isSaved;
    }
  }

  static List<Job> getSavedJobs() {
    return _localJobs.where((job) => job.isSaved).toList();
  }
}

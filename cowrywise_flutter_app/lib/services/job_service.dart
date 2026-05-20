import '../models/job.dart';

class JobService {
  static final List<Job> _localJobs = [
    Job(
      id: 'spotify_product_designer',
      title: 'Senior Product Designer',
      company: 'Spotify',
      location: 'San Francisco, CA',
      salary: r'$120K - $150K',
      type: 'Full-time',
      timeAgo: '3h ago',
      logo: 'S',
      tags: const ['UI/UX', 'Figma', 'SaaS'],
      description:
          'Design elegant mobile experiences for creators and listeners across a global audio platform.',
      requirements: const [
        'Strong product design portfolio with mobile case studies.',
        'Experience using Figma and design systems at scale.',
        'Ability to partner closely with product and engineering teams.',
      ],
      experience: '5+ Years',
      isSaved: true,
    ),
    Job(
      id: 'airbnb_ios_engineer',
      title: 'Staff iOS Engineer',
      company: 'Airbnb',
      location: 'Remote',
      salary: r'$150K - $190K',
      type: 'Full-time',
      timeAgo: '8h ago',
      logo: 'A',
      tags: const ['Swift', 'UIKit', 'iOS'],
      isRemote: true,
      description:
          'Lead high-impact iOS architecture for marketplace experiences used by hosts and guests.',
      requirements: const [
        'Deep Swift and UIKit experience.',
        'Experience mentoring senior mobile engineers.',
      ],
      experience: '7+ Years',
    ),
    Job(
      id: 'stripe_product_marketing',
      title: 'Product Marketing Manager',
      company: 'Stripe',
      location: 'New York, NY',
      salary: r'$130K - $160K',
      type: 'Full-time',
      timeAgo: '1d ago',
      logo: 'St',
      tags: const ['Growth', 'SaaS', 'Product'],
      description:
          'Own product narratives and launch plans for developer-focused financial tools.',
      requirements: const [
        'Experience launching SaaS products.',
        'Strong positioning and customer research skills.',
      ],
      experience: '4+ Years',
    ),
    Job(
      id: 'airbnb_product_designer',
      title: 'Product Designer',
      company: 'Airbnb',
      location: 'Remote',
      salary: r'$150K - $190K',
      type: 'Contract',
      timeAgo: '2h ago',
      logo: 'A',
      tags: const ['Figma', 'UX', 'Research'],
      isRemote: true,
      isSaved: true,
    ),
  ];

  static Future<List<Job>> getJobs({String? query, String? location}) async {
    await Future.delayed(const Duration(milliseconds: 250));
    var jobs = List<Job>.from(_localJobs);
    if (query != null && query.trim().isNotEmpty) {
      final term = query.toLowerCase();
      jobs = jobs
          .where((job) =>
              job.title.toLowerCase().contains(term) ||
              job.company.toLowerCase().contains(term) ||
              job.tags.any((tag) => tag.toLowerCase().contains(term)))
          .toList();
    }
    return jobs;
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

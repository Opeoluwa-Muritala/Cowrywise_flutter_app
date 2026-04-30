class Job {
  final String id;
  final String title;
  final String company;
  final String location;
  final String salary;
  final String type;
  final String timeAgo;
  final String logo;
  final List<String> tags;
  final bool isRemote;
  final String description;
  final List<String> requirements;
  final String experience;
  bool isSaved;

  Job({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.salary,
    required this.type,
    required this.timeAgo,
    required this.logo,
    required this.tags,
    this.isRemote = false,
    this.description = 'No description available.',
    this.requirements = const [],
    this.experience = 'N/A',
    this.isSaved = false,
  });

  factory Job.fromBingJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'] ?? '',
      title: json['title'] ?? 'No Title',
      company: json['company'] ?? 'Unknown Company',
      location: json['location'] ?? 'N/A',
      salary: 'N/A', // Bing search doesn't return salary usually in list
      type: json['employmentType'] ?? 'Full-time',
      timeAgo: json['postedTimeAgo'] ?? 'Recently',
      logo: json['image'] ?? '',
      tags: [
        json['employmentType'] ?? 'Full-time',
        'REMOTE',
      ],
      isRemote: true,
    );
  }

  factory Job.fromDetailsJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'] ?? '',
      title: json['title'] ?? 'No Title',
      company: json['companyName'] ?? 'Unknown Company',
      location: json['location'] ?? 'N/A',
      salary: 'N/A',
      type: json['employmentType'] ?? 'Full-time',
      timeAgo: json['postedTimeAgo'] ?? 'Recently',
      logo: '', 
      tags: [json['employmentType'] ?? 'Full-time'],
      description: json['description'] ?? 'No description available.',
      experience: 'N/A',
      requirements: [],
    );
  }
}

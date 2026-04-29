class Job {
  final String title;
  final String company;
  final String location;
  final String salary;
  final String type;
  final String timeAgo;
  final String logo;
  final List<String> tags;

  Job({
    required this.title,
    required this.company,
    required this.location,
    required this.salary,
    required this.type,
    required this.timeAgo,
    required this.logo,
    required this.tags,
  });
}

final List<Job> recentJobs = [
  Job(
    title: 'Lead Android Architect',
    company: 'Google Cloud',
    location: 'Remote',
    salary: '\$140k - \$210k',
    type: 'Full-time',
    timeAgo: '2d ago',
    logo: 'G',
    tags: ['KOTLIN', 'JETPACK COMPOSE'],
  ),
  Job(
    title: 'Senior UX Engineer',
    company: 'Airbnb',
    location: 'San Francisco',
    salary: '\$120k - \$180k',
    type: 'Contract',
    timeAgo: '5h ago',
    logo: 'A',
    tags: ['DESIGN SYSTEMS'],
  ),
  Job(
    title: 'Product Designer',
    company: 'Spotify',
    location: 'New York',
    salary: '\$130k - \$190k',
    type: 'Full-time',
    timeAgo: '1d ago',
    logo: 'S',
    tags: ['FIGMA', 'UI/UX'],
  ),
];

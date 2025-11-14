// lib/constants/content.dart
// Centralized content strings and data to make the portfolio reusable.

const String personName = 'Md. Shoroardi Sumon';

const String homeJobTitle = 'Flutter Developer | Spring Boot Developer';

const List<String> homeParagraphs = [
  'Flutter developer with 3 years of experience building high-performance mobile and web applications. I also work with Spring Boot to develop scalable REST APIs.'
];

const String downloadCvPath = '/assets/CV-MdShoroardiSumon.pdf';
const String downloadCvLabel = 'Download CV';
const String viewProjectsLabel = 'View Projects';

const String aboutTitle = 'About Me';
const List<String> aboutParagraphs = [
  'I am a Flutter Developer with 3 years of experience building fast, reliable, and visually polished applications for Android, iOS, and the web. I specialize in Flutter, Dart, Provider, Riverpod, and BLoC, and have delivered multiple production apps integrating real-time data, secure payments, authentication, and advanced UI/UX animations.',
  'I also work with Spring Boot to design high-performance REST APIs that follow clean architecture, scalable design patterns, and strong security practices. My focus is building seamless end-to-end experiences where frontend and backend work together smoothly.',
  'To stay efficient and modern, I actively use AI-assisted development tools such as GitHub Copilot and Claude Code, which help me speed up development, maintain clean code, and solve complex engineering problems more effectively.',
  'I enjoy working in Agile/Scrum environments, collaborating with teams, and building solutions that solve real business problems with clean, maintainable code.',
];

const Map<String, String> contactInfo = {
  'address': 'House 11, Road 12, North Badda, Dhaka 1212, Bangladesh',
  'phone': '+8801776954809',
  'email': 'shoroardi.sumon@gmail.com',
};

const Map<String, String> socialLinks = {
  'github': 'https://github.com/shoroardiSumon',
  'linkedin': 'https://www.linkedin.com/in/md-shoroardi-sumon-a00a1a184/',
  'email': 'mailto:shoroardi.sumon@gmail.com',
};

const List<Map<String, String>> educations = [
  {
    'institution': 'Pabna University of Science & Technology, Pabna',
    'degree': 'B.Sc. Engineering',
    'department': 'Department of Electronic & Telecommunication Engineering',
    'period': 'January, 2015 - May, 2021',
    'gpa': 'CGPA: 3.18',
  },
  {
    'institution': 'Ullapara Science College, Ullapara, Sirajganj',
    'degree': 'HSC',
    'department': '',
    'period': 'Session: 2011-2012',
    'gpa': 'GPA: 4.90',
  },
  {
    'institution': 'Momena Ali Biggan School, Ullapara, Sirajganj',
    'degree': 'SSC',
    'department': '',
    'period': 'Session: 2009-2010',
    'gpa': 'GPA: 5.00',
  },
];

const List<String> skillsList = ['Flutter', 'Dart', 'Spring Boot', 'REST', 'Firebase', 'Git'];

const Map<String, dynamic> stats = {
  'experience': '3+',
  'projects': '7+',
  'primary': 'Flutter',
  'secondary': 'Spring Boot',
};

// Experience entries
const List<Map<String, dynamic>> experiences = [
  {
    'company': 'Automation Services Ltd, Gulshan-1, Dhaka',
    'role': 'Software Engineer',
    'duration': 'Nov 2022 – Present',
    'description': [
      'Built and maintained Flutter mobile apps with REST API integration.',
      'Developed and maintained Spring Boot REST APIs for backend services.',
      'Improved the BPDB Electricity Prepaid Metering System (Struts + JSP + Oracle).',
      'Collaborated with backend teams to ensure robust API integrations.',
      'Managed app deployment on Play Store and internal testing via TestFlight.',
    ],
  },
];

// Grouped skills for the Skills section (keeps categories in one place)
const Map<String, List<String>> skillsGroups = {
  'Flutter & Mobile App': [
    'Flutter',
    'Provider',
    'BLoC',
    'Riverpod',
    'REST/GraphQL/XML API Integration',
    'CustomPainter',
    'Google Maps',
    'Firebase Authentication',
    'FCM',
    'Stripe',
    'RevenueCat',
    'Play Store',
    'App Store',
    'TestFlight',
  ],
  'Backend & APIs': [
    'Spring Boot (REST API)',
    'Firebase',
  ],
  'Architecture & Development': [
    'Clean Architecture',
    'Modular Code',
    'Debugging',
    'Agile/Scrum',
  ],
  'AI-Agent Development': [
    'GitHub Copilot',
    'Claude Code'
  ],
  'Languages & Databases': [
    'Dart',
    'Java',
    'C',
    'JavaScript',
    'HTML',
    'CSS',
    'Oracle',
    'MySQL',
    'PostgreSQL',
    'SQLite',
    'Firebase',
  ],
};

const List<Map<String, dynamic>> projects = [
  {
    'name': 'My Bitcoin Canvas App',
    'description': 'A canvas-based Bitcoin tracking app with real-time updates.',
    'technologies': 'Flutter, Dart, REST API',
    'link': 'https://apps.apple.com/us/app/my-bitcoin-canvas/id6740707716',
    'image': 'assets/images/my-bitcoin-canvas.png',
  },
  {
    'name': 'Be Thankful E-commerce App',
    'description': 'Full-featured e-commerce app with payment integration.',
    'technologies': 'Flutter, Stripe, Firebase',
    'link': 'https://play.google.com/store/apps/details?id=com.tariqdesignloops.bethankful',
    'image': 'assets/images/be-thankful.png',
  },
  {
    'name': 'Be Thankful Driver App',
    'description': 'Full-featured driver app for order delivery management.',
    'technologies': 'Flutter, Firebase',
    'link': 'https://play.google.com/store/apps/details?id=com.tariqdesignloops.bethankfuldriver',
    'image': 'assets/images/be-thankful-driver.png',
  },
  {
    'name': 'BPDB Prepaid App',
    'description': 'Internal app for electricity prepaid metering.',
    'technologies': 'Flutter, Spring Boot',
    'link': null,
    'image': 'assets/images/bpdb-prepaid.png',
  },
  {
    'name': 'BPDB FDM App',
    'description': 'Fault detection and management internal app.',
    'technologies': 'Flutter, REST API',
    'link': null,
    'image': 'assets/images/bpdb-prepaid.png',
  },
  {
    'name': 'AmarBoard App',
    'description': 'E-learning app built with Flutter & Dart.',
    'technologies': 'Flutter, Dart, Firebase',
    'link': 'https://play.google.com/store/apps/details?id=com.bd.amarboard',
    'image': 'assets/images/amarboard.jpg',
  },
  {
    'name': 'HR Management App',
    'description': 'Internal HR system for employee management.',
    'technologies': 'Flutter, Spring Boot',
    'link': null,
    'image': 'assets/images/nexahr.png',
  },
];

// Contact / form labels
const String contactTitle = 'Contact';
const String nameLabel = 'Name';
const String emailLabel = 'Email';
const String messageLabel = 'Message';
const String sendMessageLabel = 'Send Message';
const String sendSavedMessage = 'Message saved & mail composer opened.';
const String sendFallbackMessage = 'Message not saved to Sheets; mail composer opened.';

// Footer
const String footerCopyright = '© 2025 Md. Shoroardi Sumon — All Rights Reserved.';

// Section & UI labels
const String experienceTitle = 'Experience';
const String projectsTitle = 'Projects';
const String skillsTitle = 'Skills';
const String educationTitle = 'Education';

const String viewOnStoreLabel = 'View on Store';
const String technologiesLabel = 'Technologies:';

const String contactInfoTitle = 'Contact Information';

// Small stat labels
const String yearsExperienceLabel = 'Years Experience';
const String projectsLabel = 'Projects';
const String primaryLabel = 'Primary';

// Navigation labels (header)
const Map<String, String> navLabels = {
  'about': 'About',
  'skills': 'Skills',
  'projects': 'Projects',
  'experience': 'Experience',
  'education': 'Education',
  'contact': 'Contact',
};

// Tooltip / misc
const String openNavigationTooltip = 'Open navigation';
const String githubTooltip = 'GitHub Profile';
const String linkedinTooltip = 'LinkedIn Profile';
const String sendEmailTooltip = 'Send Email';


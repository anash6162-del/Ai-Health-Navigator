
import 'package:material_ui/material_ui.dart';
import '../../../../core/theme/app_colors.dart';

class DoctorScreen extends StatefulWidget {
  const DoctorScreen({super.key});

  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  final TextEditingController searchController =
  TextEditingController();

  String searchQuery = '';
  String selectedFilter = 'All';

  final List<Map<String, dynamic>> doctors = [
    {
      'name': 'Dr. Anil Sharma',
      'specialty': 'Cardiologist',
      'hospital': 'Grande International Hospital',
      'experience': '12 years',
      'rating': '4.8',
      'availability': 'Available',
      'qualification': 'MD, DM Cardiology',
      'about': 'Specialist in heart and cardiovascular care.',
    },
    {
      'name': 'Dr. Sita Thapa',
      'specialty': 'Dermatologist',
      'hospital': 'Norvic International Hospital',
      'experience': '8 years',
      'rating': '4.7',
      'availability': 'Available',
      'qualification': 'MD Dermatology',
      'about': 'Specialist in skin and hair conditions.',
    },
    {
      'name': 'Dr. Rajesh Karki',
      'specialty': 'Neurologist',
      'hospital': 'Patan Hospital',
      'experience': '10 years',
      'rating': '4.6',
      'availability': 'Unavailable',
      'qualification': 'MD Neurology',
      'about': 'Specialist in brain and nervous system care.',
    },
    {
      'name': 'Dr. Mira Shrestha',
      'specialty': 'Pediatrician',
      'hospital': 'Civil Service Hospital',
      'experience': '9 years',
      'rating': '4.9',
      'availability': 'Available',
      'qualification': 'MD Pediatrics',
      'about': 'Specialist in child health and development.',
    },
    {
      'name': 'Dr. Suman Adhikari',
      'specialty': 'Orthopedic',
      'hospital': 'Grande International Hospital',
      'experience': '11 years',
      'rating': '4.5',
      'availability': 'Available',
      'qualification': 'MS Orthopedics',
      'about': 'Specialist in bone and joint care.',
    },
  ];

  List<Map<String, dynamic>> get filteredDoctors {
    return doctors.where((doctor) {
      final matchesSearch =
          doctor['name'].toString().toLowerCase().contains(
            searchQuery.toLowerCase(),
          ) ||
              doctor['specialty'].toString().toLowerCase().contains(
                searchQuery.toLowerCase(),
              ) ||
              doctor['hospital'].toString().toLowerCase().contains(
                searchQuery.toLowerCase(),
              );

      final matchesFilter =
          selectedFilter == 'All' ||
              doctor['specialty'] == selectedFilter;

      return matchesSearch && matchesFilter;
    }).toList();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Find Doctors',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: AppColors.textPrimary,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Find the right doctor for you',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),

              const SizedBox(height: 7),

              const Text(
                'Search doctors by name or specialty.',
                style: TextStyle(
                  color: AppColors.textSecondary,
                ),
              ),

              const SizedBox(height: 22),

              // Search bar
              TextField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search doctor or specialty...',
                  prefixIcon: const Icon(
                    Icons.search,
                    color: AppColors.primary,
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      searchController.clear();
                      setState(() {
                        searchQuery = '';
                      });
                    },
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'Filter by Specialty',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),

              const SizedBox(height: 12),

              Wrap(
                spacing: 9,
                runSpacing: 5,
                children: [
                  'All',
                  'Cardiologist',
                  'Dermatologist',
                  'Neurologist',
                  'Pediatrician',
                  'Orthopedic',
                ].map((filter) {
                  final isSelected = selectedFilter == filter;

                  return ChoiceChip(
                    label: Text(filter),
                    selected: isSelected,
                    selectedColor: AppColors.primary,
                    backgroundColor: Colors.white,
                    labelStyle: TextStyle(
                      color: isSelected
                          ? Colors.white
                          : AppColors.textPrimary,
                    ),
                    onSelected: (_) {
                      setState(() {
                        selectedFilter = filter;
                      });
                    },
                  );
                }).toList(),
              ),

              const SizedBox(height: 25),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Available Doctors',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    '${filteredDoctors.length} found',
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              if (filteredDoctors.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 50,
                          color: AppColors.textSecondary,
                        ),
                        SizedBox(height: 10),
                        Text('No doctors found'),
                      ],
                    ),
                  ),
                ),

              ...filteredDoctors.map((doctor) {
                return doctorCard(doctor);
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget doctorCard(Map<String, dynamic> doctor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(13),
                decoration: BoxDecoration(
                  color: AppColors.lightBlue,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: const Icon(
                  Icons.medical_services_outlined,
                  color: AppColors.primary,
                  size: 30,
                ),
              ),

              const SizedBox(width: 13),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctor['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      doctor['specialty'],
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              const Icon(
                Icons.star,
                color: Colors.orange,
                size: 17,
              ),
              Text(doctor['rating']),
            ],
          ),

          const SizedBox(height: 15),

          detailItem(
            Icons.local_hospital_outlined,
            doctor['hospital'],
          ),

          detailItem(
            Icons.work_outline,
            '${doctor['experience']} experience',
          ),

          detailItem(
            Icons.circle,
            doctor['availability'],
            color: doctor['availability'] == 'Available'
                ? Colors.green
                : Colors.red,
          ),

          const Divider(height: 25),

          Row(
            children: [
              const Expanded(
                child: Text(
                  'Doctor information',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DoctorDetailsScreen(
                        doctor: doctor,
                      ),
                    ),
                  );
                },
                child: const Text('View Details'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget detailItem(
      IconData icon,
      String value, {
        Color color = AppColors.textSecondary,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Icon(icon, size: 17, color: color),
          const SizedBox(width: 9),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}

// Doctor details screen

class DoctorDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> doctor;

  const DoctorDetailsScreen({
    super.key,
    required this.doctor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Doctor Details'),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: AppColors.lightBlue,
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Icon(
                Icons.person_outline,
                color: AppColors.primary,
                size: 75,
              ),
            ),

            const SizedBox(height: 22),

            Text(
              doctor['name'],
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              doctor['specialty'],
              style: const TextStyle(
                color: AppColors.primary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 20),

            detailRow(
              Icons.local_hospital,
              doctor['hospital'],
            ),

            detailRow(
              Icons.school_outlined,
              doctor['qualification'],
            ),

            detailRow(
              Icons.work_outline,
              '${doctor['experience']} experience',
            ),

            detailRow(
              Icons.star,
              '${doctor['rating']} Rating',
            ),

            detailRow(
              Icons.circle,
              doctor['availability'],
            ),

            const SizedBox(height: 25),

            const Text(
              'About Doctor',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              doctor['about'],
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Appointment booking will be added next.',
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.calendar_month),
                label: const Text('Book Appointment'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget detailRow(IconData icon, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary),
          const SizedBox(width: 12),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

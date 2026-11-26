
import 'package:material_ui/material_ui.dart';
import '../../../../core/theme/app_colors.dart';

class HospitalScreen extends StatefulWidget {
  const HospitalScreen({super.key});

  @override
  State<HospitalScreen> createState() => _HospitalScreenState();
}

class _HospitalScreenState extends State<HospitalScreen> {
  final TextEditingController searchController =
  TextEditingController();

  String searchQuery = '';
  String selectedFilter = 'All';

  final List<Map<String, dynamic>> hospitals = [
    {
      'name': 'Grande International Hospital',
      'address': 'Dhapasi, Kathmandu',
      'type': 'Multi-speciality',
      'distance': '4.2 km',
      'rating': '4.5',
      'phone': '01-5159266',
      'departments': ['Cardiology', 'Neurology', 'Orthopedics'],
      'emergency': true,
    },
    {
      'name': 'Norvic International Hospital',
      'address': 'Thapathali, Kathmandu',
      'type': 'Multi-speciality',
      'distance': '2.8 km',
      'rating': '4.4',
      'phone': '01-5970032',
      'departments': ['Cardiology', 'General Medicine', 'Surgery'],
      'emergency': true,
    },
    {
      'name': 'Civil Service Hospital',
      'address': 'Minbhawan, Kathmandu',
      'type': 'General Hospital',
      'distance': '3.5 km',
      'rating': '4.2',
      'phone': '01-4107000',
      'departments': ['General Medicine', 'Pediatrics', 'Surgery'],
      'emergency': true,
    },
    {
      'name': 'Patan Hospital',
      'address': 'Lagankhel, Lalitpur',
      'type': 'General Hospital',
      'distance': '5.6 km',
      'rating': '4.6',
      'phone': '01-5422278',
      'departments': ['Emergency', 'Pediatrics', 'Gynecology'],
      'emergency': true,
    },
  ];

  List<Map<String, dynamic>> get filteredHospitals {
    return hospitals.where((hospital) {
      final matchesSearch =
          hospital['name'].toString().toLowerCase().contains(
            searchQuery.toLowerCase(),
          ) ||
              hospital['address'].toString().toLowerCase().contains(
                searchQuery.toLowerCase(),
              );

      final matchesFilter = selectedFilter == 'All' ||
          (selectedFilter == 'Emergency' &&
              hospital['emergency'] == true) ||
          (selectedFilter == 'Multi-speciality' &&
              hospital['type'] == 'Multi-speciality');

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
          'Find Hospitals',
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
                'Find the right care for you',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),

              const SizedBox(height: 7),

              const Text(
                'Search hospitals and explore available services.',
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
                  hintText: 'Search hospital or location...',
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

              // Filter options
              const Text(
                'Filter Hospitals',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),

              const SizedBox(height: 12),

              Wrap(
                spacing: 9,
                children: ['All', 'Emergency', 'Multi-speciality']
                    .map((filter) {
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
                    'Available Hospitals',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    '${filteredHospitals.length} found',
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              if (filteredHospitals.isEmpty)
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
                        Text('No hospitals found'),
                      ],
                    ),
                  ),
                ),

              ...filteredHospitals.map((hospital) {
                return hospitalCard(hospital);
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget hospitalCard(Map<String, dynamic> hospital) {
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
                  Icons.local_hospital,
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
                      hospital['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      hospital['type'],
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 17,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  hospital['address'],
                  style: const TextStyle(fontSize: 13),
                ),
              ),
              const Icon(
                Icons.star,
                color: Colors.orange,
                size: 17,
              ),
              Text(
                hospital['rating'],
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              const Icon(
                Icons.directions_walk,
                size: 17,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 5),
              Text(
                hospital['distance'],
                style: const TextStyle(fontSize: 13),
              ),
              const Spacer(),
              const Icon(
                Icons.phone_outlined,
                size: 16,
                color: AppColors.primary,
              ),
              const SizedBox(width: 5),
              Text(
                hospital['phone'],
                style: const TextStyle(fontSize: 13),
              ),
            ],
          ),

          const Divider(height: 25),

          Row(
            children: [
              const Expanded(
                child: Text(
                  'Hospital information',
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
                      builder: (_) => HospitalDetailsScreen(
                        hospital: hospital,
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
}

// Hospital details screen

class HospitalDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> hospital;

  const HospitalDetailsScreen({
    super.key,
    required this.hospital,
  });

  @override
  Widget build(BuildContext context) {
    final departments =
    hospital['departments'] as List<String>;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Hospital Details'),
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
                Icons.local_hospital,
                color: AppColors.primary,
                size: 65,
              ),
            ),

            const SizedBox(height: 22),

            Text(
              hospital['name'],
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),

            const SizedBox(height: 12),

            detailRow(
              Icons.location_on,
              hospital['address'],
            ),

            detailRow(
              Icons.phone,
              hospital['phone'],
            ),

            detailRow(
              Icons.star,
              '${hospital['rating']} Rating',
            ),

            detailRow(
              Icons.directions_walk,
              hospital['distance'],
            ),

            const SizedBox(height: 25),

            const Text(
              'Available Departments',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),

            const SizedBox(height: 15),

            ...departments.map((department) {
              return Card(
                color: Colors.white,
                elevation: 0,
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  leading: const Icon(
                    Icons.medical_services_outlined,
                    color: AppColors.primary,
                  ),
                  title: Text(department),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                  ),
                ),
              );
            }),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Map integration will be added next.',
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.map),
                label: const Text('View on Map'),
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

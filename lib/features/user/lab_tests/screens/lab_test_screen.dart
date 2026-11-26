
import 'package:material_ui/material_ui.dart';
import '../../../../core/theme/app_colors.dart';

class LabTestScreen extends StatefulWidget {
  const LabTestScreen({super.key});

  @override
  State<LabTestScreen> createState() => _LabTestScreenState();
}

class _LabTestScreenState extends State<LabTestScreen> {
  final TextEditingController searchController = TextEditingController();

  String selectedCategory = 'All';

  final List<Map<String, dynamic>> tests = [
    {
      'name': 'Complete Blood Count (CBC)',
      'category': 'Blood',
      'price': 'Rs. 500',
      'sample': 'Blood',
      'preparation': 'No special preparation required.',
      'description': 'A blood test that measures different components of blood.',
    },
    {
      'name': 'Blood Glucose Test',
      'category': 'Blood',
      'price': 'Rs. 300',
      'sample': 'Blood',
      'preparation': 'Fasting may be required depending on the test ordered.',
      'description': 'Measures the level of glucose in your blood.',
    },
    {
      'name': 'Lipid Profile',
      'category': 'Blood',
      'price': 'Rs. 900',
      'sample': 'Blood',
      'preparation': 'Follow the laboratory or clinician instructions about fasting.',
      'description': 'Measures cholesterol and triglyceride levels.',
    },
    {
      'name': 'Thyroid Function Test',
      'category': 'Hormone',
      'price': 'Rs. 1000',
      'sample': 'Blood',
      'preparation': 'Ask your healthcare professional if any preparation is needed.',
      'description': 'Evaluates thyroid hormone levels.',
    },
    {
      'name': 'Urine Routine Test',
      'category': 'Urine',
      'price': 'Rs. 250',
      'sample': 'Urine',
      'preparation': 'Follow the laboratory instructions for sample collection.',
      'description': 'Examines urine for several health indicators.',
    },
    {
      'name': 'Vitamin D Test',
      'category': 'Vitamin',
      'price': 'Rs. 1200',
      'sample': 'Blood',
      'preparation': 'Usually no special preparation is required.',
      'description': 'Measures vitamin D levels in the blood.',
    },
  ];

  List<Map<String, dynamic>> get filteredTests {
    return tests.where((test) {
      final matchesSearch = test['name']
          .toString()
          .toLowerCase()
          .contains(searchController.text.toLowerCase());

      final matchesCategory = selectedCategory == 'All' ||
          test['category'] == selectedCategory;

      return matchesSearch && matchesCategory;
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
        title: const Text('Lab Tests'),
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: searchController,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'Search lab tests...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          SizedBox(
            height: 45,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: ['All', 'Blood', 'Urine', 'Hormone', 'Vitamin']
                  .map((category) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(category),
                    selected: selectedCategory == category,
                    selectedColor: AppColors.lightBlue,
                    onSelected: (_) {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 12),

          Expanded(
            child: filteredTests.isEmpty
                ? const Center(child: Text('No lab tests found.'))
                : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredTests.length,
              itemBuilder: (context, index) {
                final test = filteredTests[index];

                return Card(
                  color: Colors.white,
                  elevation: 1,
                  margin: const EdgeInsets.only(bottom: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: CircleAvatar(
                      backgroundColor: AppColors.lightBlue,
                      child: Icon(
                        Icons.science_outlined,
                        color: AppColors.primary,
                      ),
                    ),
                    title: Text(
                      test['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        '${test['category']} • ${test['sample']}\n${test['price']}',
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          height: 1.5,
                        ),
                      ),
                    ),
                    isThreeLine: true,
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              LabTestDetailsScreen(test: test),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class LabTestDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> test;

  const LabTestDetailsScreen({super.key, required this.test});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Test Details'),
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 38,
                backgroundColor: AppColors.lightBlue,
                child: Icon(
                  Icons.science_outlined,
                  size: 40,
                  color: AppColors.primary,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              test['name'],
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 20),
            _detailRow('Category', test['category']),
            _detailRow('Sample Type', test['sample']),
            _detailRow('Sample Price', test['price']),
            _detailRow('Preparation', test['preparation']),
            const SizedBox(height: 20),
            const Text(
              'About this test',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              test['description'],
              style: const TextStyle(
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Test booking will be available soon.'),
                    ),
                  );
                },
                child: const Text('Book Test'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _detailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

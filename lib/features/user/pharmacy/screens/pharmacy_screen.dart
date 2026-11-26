
import 'package:material_ui/material_ui.dart';
import '../../../../core/theme/app_colors.dart';

class PharmacyScreen extends StatefulWidget {
  const PharmacyScreen({super.key});

  @override
  State<PharmacyScreen> createState() => _PharmacyScreenState();
}

class _PharmacyScreenState extends State<PharmacyScreen> {
  final TextEditingController searchController = TextEditingController();

  String selectedCategory = 'All';

  final List<Map<String, dynamic>> medicines = [
    {
      'name': 'Paracetamol',
      'category': 'Pain Relief',
      'price': 'Rs. 30',
      'description': 'Commonly used to relieve pain and reduce fever.',
      'prescription': 'Check the product label and consult a pharmacist.'
    },
    {
      'name': 'Cetirizine',
      'category': 'Allergy',
      'price': 'Rs. 50',
      'description': 'An antihistamine used for allergy symptoms.',
      'prescription': 'Ask a pharmacist whether it is suitable for you.'
    },
    {
      'name': 'Vitamin C',
      'category': 'Vitamins',
      'price': 'Rs. 150',
      'description': 'A vitamin supplement containing vitamin C.',
      'prescription': 'Follow the product label or professional advice.'
    },
    {
      'name': 'Antacid',
      'category': 'Digestive',
      'price': 'Rs. 80',
      'description': 'A product used to relieve symptoms of acidity.',
      'prescription': 'Consult a pharmacist if symptoms persist.'
    },
    {
      'name': 'Oral Rehydration Salts',
      'category': 'Digestive',
      'price': 'Rs. 25',
      'description': 'A rehydration product used to replace fluids and salts.',
      'prescription': 'Prepare exactly according to the packet instructions.'
    },
    {
      'name': 'Multivitamin',
      'category': 'Vitamins',
      'price': 'Rs. 250',
      'description': 'A supplement containing multiple vitamins.',
      'prescription': 'Ask a healthcare professional if you need a supplement.'
    },
  ];

  List<Map<String, dynamic>> get filteredMedicines {
    return medicines.where((medicine) {
      final matchesSearch = medicine['name']
          .toString()
          .toLowerCase()
          .contains(searchController.text.toLowerCase());

      final matchesCategory = selectedCategory == 'All' ||
          medicine['category'] == selectedCategory;

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
        title: const Text('Pharmacy'),
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
                hintText: 'Search medicines...',
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
              children: [
                'All',
                'Pain Relief',
                'Allergy',
                'Vitamins',
                'Digestive',
              ].map((category) {
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
            child: filteredMedicines.isEmpty
                ? const Center(child: Text('No medicines found.'))
                : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredMedicines.length,
              itemBuilder: (context, index) {
                final medicine = filteredMedicines[index];

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
                        Icons.medication_outlined,
                        color: AppColors.primary,
                      ),
                    ),
                    title: Text(
                      medicine['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        '${medicine['category']}\n${medicine['price']}',
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          height: 1.5,
                        ),
                      ),
                    ),
                    isThreeLine: true,
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MedicineDetailsScreen(medicine: medicine),
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

class MedicineDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> medicine;

  const MedicineDetailsScreen({
    super.key,
    required this.medicine,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Medicine Details'),
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
                radius: 40,
                backgroundColor: AppColors.lightBlue,
                child: Icon(
                  Icons.medication_outlined,
                  size: 42,
                  color: AppColors.primary,
                ),
              ),
            ),
            const SizedBox(height: 24),

            Text(
              medicine['name'],
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 20),

            _detailRow('Category', medicine['category']),
            _detailRow('Sample Price', medicine['price']),
            _detailRow('Description', medicine['description']),

            const SizedBox(height: 16),

            const Text(
              'Important Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),

            Text(
              medicine['prescription'],
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
                      content: Text(
                        'Medicine ordering will be available soon.',
                      ),
                    ),
                  );
                },
                child: const Text('Order Medicine'),
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

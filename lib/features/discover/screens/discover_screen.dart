
import 'package:flutter/material.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {

  String searchQuery = '';

  final List<Map<String, dynamic>> topics = [
    {
      'title': 'Heart Health',
      'category': 'Health',
      'icon': Icons.favorite,
      'color': Colors.red,
    },
    {
      'title': 'Mental Wellness',
      'category': 'Wellness',
      'icon': Icons.psychology,
      'color': Colors.purple,
    },
    {
      'title': 'Nutrition',
      'category': 'Lifestyle',
      'icon': Icons.restaurant,
      'color': Colors.orange,
    },
    {
      'title': 'First Aid',
      'category': 'Emergency',
      'icon': Icons.medical_services,
      'color': Colors.blue,
    },
    {
      'title': 'Fitness',
      'category': 'Lifestyle',
      'icon': Icons.fitness_center,
      'color': Colors.green,
    },
    {
      'title': 'Sleep Health',
      'category': 'Wellness',
      'icon': Icons.bedtime,
      'color': Colors.indigo,
    },
  ];

  @override
  Widget build(BuildContext context) {

    final filteredTopics = topics.where((topic) {
      return topic['title']
          .toLowerCase()
          .contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),

      appBar: AppBar(
        title: const Text(
          'Discover',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF173D4A),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              'Explore Healthcare',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Color(0xFF173D4A),
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              'Discover health topics and useful information.',
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 22),

            // Search bar
            TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },

              decoration: InputDecoration(
                hintText: 'Search health topics...',
                prefixIcon: const Icon(
                  Icons.search,
                  color: Color(0xFF168B83),
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Explore Categories',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            // Categories
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                'Health',
                'Wellness',
                'Lifestyle',
                'Emergency',
              ].map((category) {
                return ActionChip(
                  label: Text(category),
                  backgroundColor: Colors.white,
                  onPressed: () {
                    setState(() {
                      searchQuery = category;
                    });
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 25),

            Text(
              searchQuery.isEmpty
                  ? 'Popular Topics'
                  : 'Search Results',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            if (filteredTopics.isEmpty)
              const Padding(
                padding: EdgeInsets.all(25),
                child: Center(
                  child: Text('No matching topics found'),
                ),
              ),

            // Topic cards
            ...filteredTopics.map((topic) {

              return Card(
                color: Colors.white,
                elevation: 0,
                margin: const EdgeInsets.only(bottom: 12),

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),

                child: ListTile(
                  contentPadding: const EdgeInsets.all(14),

                  leading: CircleAvatar(
                    backgroundColor:
                    topic['color'].withOpacity(0.12),
                    child: Icon(
                      topic['icon'],
                      color: topic['color'],
                    ),
                  ),

                  title: Text(
                    topic['title'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  subtitle: Text(topic['category']),

                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                  ),

                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          '${topic['title']} selected',
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

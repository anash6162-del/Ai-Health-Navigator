
import 'package:material_ui/material_ui.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() =>
      _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  String selectedFilter = 'All';

  final List<Map<String, dynamic>> notifications = [
    {
      'title': 'Appointment Reminder',
      'message': 'Your upcoming appointment is tomorrow.',
      'time': '10:30 AM',
      'icon': Icons.calendar_month,
      'color': Colors.blue,
      'category': 'Reminders',
      'read': false,
    },
    {
      'title': 'Medicine Reminder',
      'message': 'Don\'t forget your scheduled medication.',
      'time': '09:00 AM',
      'icon': Icons.medication,
      'color': Colors.orange,
      'category': 'Reminders',
      'read': false,
    },
    {
      'title': 'Health Update',
      'message': 'Your weekly health summary is ready.',
      'time': 'Yesterday',
      'icon': Icons.favorite,
      'color': Colors.purple,
      'category': 'Health',
      'read': true,
    },
    {
      'title': 'Welcome to MediNav AI',
      'message': 'Your healthcare journey starts here!',
      'time': 'Yesterday',
      'icon': Icons.health_and_safety,
      'color': Colors.teal,
      'category': 'General',
      'read': true,
    },
  ];

  int get unreadCount =>
      notifications.where((n) => n['read'] == false).length;

  @override
  Widget build(BuildContext context) {

    final filteredNotifications = notifications.where((n) {
      if (selectedFilter == 'All') return true;
      if (selectedFilter == 'Unread') return !n['read'];
      return n['category'] == selectedFilter;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Notifications',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF173D4A),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                for (var notification in notifications) {
                  notification['read'] = true;
                }
              });
            },
            child: const Text('Mark all read'),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              '$unreadCount unread notifications',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 20),

            Wrap(
              spacing: 8,
              children: ['All', 'Unread', 'Reminders',
                'Health', 'General'].map((filter) {

                return ChoiceChip(
                  label: Text(filter),
                  selected: selectedFilter == filter,
                  selectedColor: const Color(0xFF168B83),
                  labelStyle: TextStyle(
                    color: selectedFilter == filter
                        ? Colors.white
                        : Colors.black87,
                  ),
                  onSelected: (_) {
                    setState(() {
                      selectedFilter = filter;
                    });
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: filteredNotifications.isEmpty
                  ? const Center(
                child: Text(
                  'No notifications found',
                  style: TextStyle(color: Colors.grey),
                ),
              )
                  : ListView.builder(
                itemCount: filteredNotifications.length,
                itemBuilder: (context, index) {

                  final notification =
                  filteredNotifications[index];

                  return Card(
                    color: notification['read']
                        ? Colors.white
                        : const Color(0xFFEAF6F5),
                    elevation: 0,
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),

                    child: ListTile(
                      contentPadding:
                      const EdgeInsets.all(12),

                      leading: CircleAvatar(
                        backgroundColor:
                        notification['color'].withOpacity(0.12),
                        child: Icon(
                          notification['icon'],
                          color: notification['color'],
                        ),
                      ),

                      title: Text(
                        notification['title'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),

                      subtitle: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 5),
                          Text(notification['message']),
                          const SizedBox(height: 6),
                          Text(
                            notification['time'],
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),

                      trailing: notification['read']
                          ? null
                          : const Icon(
                        Icons.circle,
                        size: 10,
                        color: Color(0xFF168B83),
                      ),

                      onTap: () {
                        setState(() {
                          notification['read'] = true;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

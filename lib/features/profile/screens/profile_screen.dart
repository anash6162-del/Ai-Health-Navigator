
import 'package:material_ui/material_ui.dart';

import '../../../core/theme/app_colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Demo profile data
  String name = 'Aarya Adhikari';
  String email = 'aarya.adhikari@example.com';
  String phone = '+977 980 123 4567';

  final String patientId = 'MN-10284';
  final String age = '28 years';
  final String bloodGroup = 'Blood group O+';

  bool notificationsEnabled = true;
  String selectedLanguage = 'English';

  // Demo family members
  final List<Map<String, String>> familyMembers = [
    {'name': 'Rahul Adhikari', 'relation': 'Brother'},
    {'name': 'Sita Adhikari', 'relation': 'Mother'},
  ];

  // Demo appointments
  final List<Map<String, String>> appointments = [
    {
      'doctor': 'Dr. Anisha Sharma',
      'speciality': 'General Physician',
      'date': '24 November 2026',
      'time': '10:30 AM',
    },
  ];

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  // Edit personal information
  Future<void> _editPersonalDetails() async {
    final nameController = TextEditingController(text: name);
    final emailController = TextEditingController(text: email);
    final phoneController = TextEditingController(text: phone);

    await showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Edit personal details'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Full name',
                  ),
                ),
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email address',
                  ),
                ),
                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Phone number',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.trim().isEmpty ||
                    emailController.text.trim().isEmpty ||
                    phoneController.text.trim().isEmpty) {
                  return;
                }

                setState(() {
                  name = nameController.text.trim();
                  email = emailController.text.trim();
                  phone = phoneController.text.trim();
                });

                Navigator.pop(dialogContext);
              },
              child: const Text('Save changes'),
            ),
          ],
        );
      },
    );

    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
  }

  // Add a family member
  Future<void> _addFamilyMember() async {
    final nameController = TextEditingController();
    final relationController = TextEditingController();

    await showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Add family member'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Member name',
                ),
              ),
              TextField(
                controller: relationController,
                decoration: const InputDecoration(
                  labelText: 'Relationship',
                  hintText: 'e.g. Mother, Father',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final memberName = nameController.text.trim();
                final relation = relationController.text.trim();

                if (memberName.isEmpty || relation.isEmpty) {
                  return;
                }

                setState(() {
                  familyMembers.add({
                    'name': memberName,
                    'relation': relation,
                  });
                });

                Navigator.pop(dialogContext);
              },
              child: const Text('Add member'),
            ),
          ],
        );
      },
    );

    nameController.dispose();
    relationController.dispose();
  }

  // Remove family member
  void _removeFamilyMember(int index) {
    setState(() {
      familyMembers.removeAt(index);
    });

    _showMessage('Family member removed.');
  }

  // Show appointments
  void _showAppointments() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'My appointments',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkNavy,
                  ),
                ),
                const SizedBox(height: 16),
                if (appointments.isEmpty)
                  const Text('No appointments available.')
                else
                  ...appointments.map(
                        (appointment) => ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const CircleAvatar(
                        backgroundColor: AppColors.lightBlue,
                        child: Icon(
                          Icons.calendar_month,
                          color: AppColors.primary,
                        ),
                      ),
                      title: Text(appointment['doctor']!),
                      subtitle: Text(
                        '${appointment['speciality']}\n'
                            '${appointment['date']} · ${appointment['time']}',
                      ),
                    ),
                  ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        );
      },
    );
  }

  // Change language preference
  void _selectLanguage() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Select language'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(
                title: const Text('English'),
                value: 'English',
                groupValue: selectedLanguage,
                onChanged: (value) {
                  setState(() => selectedLanguage = value!);
                  Navigator.pop(dialogContext);
                },
              ),
              RadioListTile<String>(
                title: const Text('नेपाली'),
                value: 'Nepali',
                groupValue: selectedLanguage,
                onChanged: (value) {
                  setState(() => selectedLanguage = value!);
                  Navigator.pop(dialogContext);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Privacy information
  void _showPrivacy() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Privacy & security'),
          content: const Text(
            'Your health information is important. '
                'This demo screen does not upload or store '
                'your profile information on a server.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  // Support information
  void _showSupport() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Help & support'),
          content: const Text(
            'Welcome to MediNav AI support.\n\n'
                'Support contact: support@medinav.ai\n\n'
                'This is demo contact information. '
                'Connect a real support service before production.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  // Sign out confirmation
  void _confirmSignOut() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Sign out'),
          content: const Text(
            'Are you sure you want to sign out?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                _showMessage(
                  'Demo mode: connect Firebase Authentication '
                      'to enable actual sign out.',
                );
              },
              child: const Text(
                'Sign out',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  // Reusable section heading
  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
        bottom: 10,
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: AppColors.darkNavy,
        ),
      ),
    );
  }

  // Reusable menu item
  Widget _menuItem({
    required IconData icon,
    required String title,
    required String trailing,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      dense: true,
      leading: Icon(
        icon,
        color: AppColors.primary,
        size: 21,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 13,
          color: AppColors.darkNavy,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            trailing,
            style: const TextStyle(
              fontSize: 10,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(width: 8),
          const Icon(
            Icons.chevron_right,
            color: AppColors.textSecondary,
            size: 19,
          ),
        ],
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'My profile',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkNavy,
                ),
              ),

              const SizedBox(height: 18),

              // Personal profile card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(17),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            name,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: AppColors.darkNavy,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.person_outline,
                          color: AppColors.primary,
                          size: 27,
                        ),
                      ],
                    ),

                    const SizedBox(height: 4),

                    Text(
                      'Patient ID - $patientId',
                      style: const TextStyle(
                        fontSize: 10,
                        color: AppColors.textSecondary,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Wrap(
                      spacing: 7,
                      children: [
                        _infoChip(age),
                        _infoChip(bloodGroup),
                      ],
                    ),

                    const SizedBox(height: 12),

                    Text(
                      email,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      phone,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                      ),
                    ),

                    const SizedBox(height: 15),

                    SizedBox(
                      width: double.infinity,
                      height: 43,
                      child: ElevatedButton(
                        onPressed: _editPersonalDetails,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.lightBlue,
                          foregroundColor: AppColors.primary,
                          elevation: 0,
                        ),
                        child: const Text(
                          'Edit personal details',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Care and preferences
              _sectionTitle('Care & preferences'),

              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    _menuItem(
                      icon: Icons.people_outline,
                      title: 'Family members',
                      trailing: '${familyMembers.length} members',
                      onTap: _showFamilyMembers,
                    ),

                    _menuItem(
                      icon: Icons.calendar_month_outlined,
                      title: 'Appointments',
                      trailing: '${appointments.length} upcoming',
                      onTap: _showAppointments,
                    ),

                    SwitchListTile(
                      dense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                      secondary: const Icon(
                        Icons.notifications_none,
                        color: AppColors.primary,
                        size: 21,
                      ),
                      title: const Text(
                        'Notifications',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.darkNavy,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      value: notificationsEnabled,
                      activeTrackColor: AppColors.primary,
                      onChanged: (value) {
                        setState(() {
                          notificationsEnabled = value;
                        });
                      },
                    ),

                    _menuItem(
                      icon: Icons.language,
                      title: 'Language',
                      trailing: selectedLanguage == 'English'
                          ? 'English / Nepali'
                          : 'नेपाली',
                      onTap: _selectLanguage,
                    ),
                  ],
                ),
              ),

              // Family members preview
              _sectionTitle('Family members'),

              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    ...familyMembers.asMap().entries.map((entry) {
                      final index = entry.key;
                      final member = entry.value;

                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const CircleAvatar(
                          backgroundColor: AppColors.lightBlue,
                          child: Icon(
                            Icons.person_outline,
                            color: AppColors.primary,
                          ),
                        ),
                        title: Text(
                          member['name']!,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          member['relation']!,
                          style: const TextStyle(fontSize: 11),
                        ),
                        trailing: IconButton(
                          tooltip: 'Remove member',
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.redAccent,
                            size: 20,
                          ),
                          onPressed: () => _removeFamilyMember(index),
                        ),
                      );
                    }),

                    OutlinedButton.icon(
                      onPressed: _addFamilyMember,
                      icon: const Icon(Icons.add),
                      label: const Text('Add family member'),
                    ),
                  ],
                ),
              ),

              // Privacy and support
              _sectionTitle('Privacy & support'),

              Container(
                decoration: BoxDecoration(
                  color: AppColors.lightBlue,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    _menuItem(
                      icon: Icons.verified_user_outlined,
                      title: 'Privacy & security',
                      trailing: '',
                      onTap: _showPrivacy,
                    ),
                    _menuItem(
                      icon: Icons.help_outline,
                      title: 'Help & support',
                      trailing: '',
                      onTap: _showSupport,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // Sign out
              TextButton.icon(
                onPressed: _confirmSignOut,
                icon: const Icon(
                  Icons.logout,
                  color: Colors.redAccent,
                  size: 18,
                ),
                label: const Text(
                  'Sign out',
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Center(
                child: Text(
                  'MediNav AI  ·  Version 1.0\n'
                      'Your Health. Connected.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 9,
                    height: 1.6,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: AppColors.lightBlue,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.primary,
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // Family members dialog
  void _showFamilyMembers() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Family members',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkNavy,
                      ),
                    ),
                    const SizedBox(height: 12),
                    if (familyMembers.isEmpty)
                      const Text('No family members added yet.'),
                    ...familyMembers.asMap().entries.map((entry) {
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(
                          Icons.person_outline,
                          color: AppColors.primary,
                        ),
                        title: Text(entry.value['name']!),
                        subtitle: Text(entry.value['relation']!),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            _removeFamilyMember(entry.key);
                            setSheetState(() {});
                          },
                        ),
                      );
                    }),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          Navigator.pop(context);
                          await _addFamilyMember();
                        },
                        icon: const Icon(Icons.add),
                        label: const Text('Add family member'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

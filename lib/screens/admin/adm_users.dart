import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fancy/providers/admin_provider.dart';

class AdminUsersScreen extends StatefulWidget {
  const AdminUsersScreen({super.key});

  @override
  State<AdminUsersScreen> createState() => _AdminUsersScreenState();
}

class _AdminUsersScreenState extends State<AdminUsersScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<AdminProvider>().getAllUsers());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Users')),
      body: Consumer<AdminProvider>(
        builder: (context, adminProvider, child) {
          if (adminProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: adminProvider.users.length,
            itemBuilder: (context, index) {
              final user = adminProvider.users[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage:
                        user.profilePictureURL.isNotEmpty
                            ? NetworkImage(user.profilePictureURL)
                            : null,
                    child:
                        user.profilePictureURL.isEmpty
                            ? const Icon(Icons.person)
                            : null,
                  ),
                  title: Text(user.username),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(user.email), Text(user.contactNumber)],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

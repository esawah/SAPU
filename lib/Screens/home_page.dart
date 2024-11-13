import 'package:flutter/material.dart';
import 'package:sapu/Screens/edit_page.dart';
import 'package:sapu/Screens/viewData_page.dart';
import 'package:sapu/db/database_helper.dart';
import 'package:sapu/models/user_data.dart';
import 'add_page.dart';
import 'package:sapu/widget/bottom_navigation.dart';
import 'package:sapu/Screens/report_page.dart';
import 'package:sapu/Screens/import_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<User>> _usersFuture;
  List<User> _allUsers = [];
  List<User> _filteredUsers = [];
  String _searchQuery = '';
  int _selectedIndex = 1;

  bool _isExpanded = false;
  bool _isFocused = false;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  final List<Widget> _pages = [

    ImportPage(),
    Scaffold(), // Placeholder for the main user list page
    ReportPage(),
  ];

  @override
  void initState() {
    super.initState();
    _loadUsers();

    // Add listener to detect focus on TextField
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  // Load user data from database
  void _loadUsers() {
    _usersFuture = DatabaseHelper().getUsers();
    _usersFuture.then((users) {
      setState(() {
        _allUsers = users;
        _filteredUsers = users;
      });
    });
  }

  // Search users based on query
  void _search(String query) {
    setState(() {
      _searchQuery = query;
      _filteredUsers = _allUsers
          .where(
              (user) => user.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  Future<void> _deleteData(int? id) async {
    if (id != null) {
      await DatabaseHelper().deleteData(id);
      _loadUsers(); // Reload data after deletion
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ID tidak valid')),
      );
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Extends the body behind the navigation bar
      // backgroundColor: Colors.white,
      body: SafeArea(
        child: _selectedIndex == 1 // Check if it's the main page index
            ? Column(
                children: [
                  // Search bar and user list for the main screen
                  // Padding(
                  //   padding: const EdgeInsets.all(16.0),
                  //   child: TextField(
                  //     controller: _searchController,
                  //     focusNode: _focusNode,
                  //     onChanged: _search,
                  //     decoration: InputDecoration(
                  //       labelText: 'Search',
                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(10.0),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 10, top: 10),
                          child: Text('Daftar Data Siswa',
                              style: TextStyle(fontSize: 24)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                width: _isExpanded ? 250 : 50,
                                child: TextField(
                                  controller: _searchController,
                                  focusNode: _focusNode,
                                  onChanged: _search,
                                  onTap: () {
                                    setState(() {
                                      _isExpanded = true;
                                    });
                                  },
                                  onEditingComplete: () {
                                    setState(() {
                                      _isExpanded = false;
                                    });
                                    _focusNode.unfocus();
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Cari siswa...',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                        color: _isFocused
                                            ? Colors.black
                                            : Colors.transparent,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: const BorderSide(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: const BorderSide(
                                          color: Colors.black, width: 2.0),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    suffixIcon: const Icon(Icons.search),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder<List<User>>(
                      future: _usersFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return const Center(
                              child: Text("Error loading users"));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Center(child: Text("No users found"));
                        }

                        return ListView.builder(
                          itemCount: _filteredUsers.length,
                          itemBuilder: (context, index) {
                            final user = _filteredUsers[index];
                            return UserListTile(
                              user: user,
                              onView: () => _navigateToViewPage(user),
                              onEdit: () => _navigateToEditPage(user),
                              onDelete: () => _confirmDelete(user.id),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              )
            : _pages[
                _selectedIndex], // Show ReportPage or ImportPage based on _selectedIndex
      ),
      floatingActionButton: _selectedIndex == 1
        ? FloatingActionButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddPage()),
              );
              // Reload data after adding new user
              _loadUsers();
            },
            child: const Icon(Icons.add, color: Colors.white),
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          )
        : null, // No FAB on other pages
    bottomNavigationBar: BottomNavigation(
      onTap: _onItemTapped,
      initialIndex: _selectedIndex, // Ensure index updates correctly
    ),
  );
}

  void _navigateToViewPage(User user) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ViewDataPage(user: user)),
    );
  }

  Future<void> _navigateToEditPage(User user) async {
    final isUpdated = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditPage(user: user)),
    );
    if (isUpdated == true) {
      _loadUsers(); // Reload data after editing
    }
  }

  void _confirmDelete(int? id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Konfirmasi'),
          content: const Text("Apakah Anda yakin ingin menghapus data ini?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal"),
            ),
            TextButton(
              onPressed: () {
                _deleteData(id);
                Navigator.pop(context);
              },
              child: const Text("Hapus"),
            ),
          ],
        );
      },
    );
  }
}

class UserListTile extends StatelessWidget {
  final User user;
  final VoidCallback onView;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const UserListTile({
    Key? key,
    required this.user,
    required this.onView,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(color: Colors.black),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Flexible(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Plat Nomor',
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Text(user.plateNumber),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Flexible(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nama',
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        user.name,
                        style: const TextStyle(fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Action buttons
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.visibility),
                  onPressed: onView,
                  iconSize: 20,
                  padding: EdgeInsets.zero,
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: onEdit,
                  iconSize: 20,
                  padding: EdgeInsets.zero,
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: onDelete,
                  iconSize: 20,
                  padding: EdgeInsets.zero,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

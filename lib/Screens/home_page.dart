import 'package:flutter/material.dart';
import 'package:sapu/Screens/edit_page.dart';
import 'package:sapu/Screens/viewData_page.dart';
import 'package:sapu/db/database_helper.dart';
import 'package:sapu/models/user_data.dart';
import 'add_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<User>> _usersFuture;
  List<User> _filteredUsers = [];
  String _searchQuery = '';
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _refreshUsers();
  }

  void _refreshUsers() {
    setState(() {
      _usersFuture = DatabaseHelper().getUsers();
      _usersFuture.then((users) {
        setState(() {
          _filteredUsers = users;
        });
      });
    });
  }

  void _updateSearch(String query) {
    setState(() {
      _searchQuery = query;
      _usersFuture.then((users) {
        _filteredUsers = users
            .where(
                (user) => user.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    });
  }

  Future<void> _deleteData(int? id) async {
    if (id != null) {
      await DatabaseHelper().deleteData(id);
      _refreshUsers();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ID tidak valid')),
      );
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // Tambahkan aksi navigasi sesuai index, misalnya untuk membuka halaman tertentu.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Data Siswa'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              onChanged: _updateSearch,
              decoration: InputDecoration(
                hintText: 'Cari siswa...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<User>>(
        future: _usersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading data'));
          } else if (!snapshot.hasData || _filteredUsers.isEmpty) {
            return const Center(child: Text('Tidak Ada Daftar Data Siswa'));
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddPage()),
          );
          _refreshUsers();
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Students',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
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
      _refreshUsers();
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
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8.0),
      decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(color: Colors.black)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Plat Nomor dan Nama
          Expanded(
            child: Row(
              children: [
                Flexible(
                  flex: 3, // Memberikan ruang yang lebih kecil untuk Plat Nomor
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
                  flex: 4, // Memberikan ruang yang lebih besar untuk Nama
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
          // Tombol aksi
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min, // Ruang minimum untuk ikon
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

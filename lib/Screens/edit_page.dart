import 'package:flutter/material.dart';
import 'package:sapu/db/database_helper.dart';
import 'package:sapu/models/user_data.dart';

class EditPage extends StatefulWidget {
  final User user;
  const EditPage({super.key, required this.user});

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late TextEditingController _nameController;
  late TextEditingController _nisController;
  late TextEditingController _nisnController;
  late TextEditingController _educationController;
  late TextEditingController _pdbController;
  late TextEditingController _adressController;
  late TextEditingController _villageController;
  late TextEditingController _wardController;
  late TextEditingController _subDistrictController;
  late TextEditingController _rtController;
  late TextEditingController _rwController;
  late TextEditingController _namefatherController;
  late TextEditingController _namemotherController;
  late TextEditingController _nohpController;
  late TextEditingController _closetcotactController;
  late TextEditingController _plateNumberController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name);
    _nisController = TextEditingController(text: widget.user.nis);
    _nisnController = TextEditingController(text: widget.user.nisn);
    _educationController = TextEditingController(text: widget.user.education);
    _pdbController = TextEditingController(text: widget.user.pdb);
    _adressController = TextEditingController(text: widget.user.address);
    _villageController = TextEditingController(text: widget.user.village);
    _wardController = TextEditingController(text: widget.user.ward);
    _subDistrictController = TextEditingController(text: widget.user.subDistrict);
    _rtController = TextEditingController(text: widget.user.rt);
    _rwController = TextEditingController(text: widget.user.rw);
    _namefatherController = TextEditingController(text: widget.user.namefather);
    _namemotherController = TextEditingController(text: widget.user.namemother);
    _nohpController = TextEditingController(text: widget.user.nohp);
    _closetcotactController = TextEditingController(text: widget.user.closetcontact);
    _plateNumberController = TextEditingController(text: widget.user.plateNumber);
  }

  void _updateUser() async {
    User updatedUser = User(
      id: widget.user.id,
      name: _nameController.text,
      nis: _nisController.text,
      nisn: _nisnController.text,
      education: _educationController.text,
      pdb: _pdbController.text,
      address: _adressController.text,
      village: _villageController.text,
      ward: _wardController.text,
      subDistrict: _subDistrictController.text,
      rt: _rtController.text,
      rw: _rwController.text,
      namefather: _namefatherController.text,
      namemother: _namemotherController.text,
      nohp: _nohpController.text,
      closetcontact: _closetcotactController.text,
      plateNumber: _plateNumberController.text,
    );

    DatabaseHelper dbHelper = DatabaseHelper();
    await dbHelper.updateUser(updatedUser);
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit User")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Personal Information",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            _buildTextField(_nameController, "Nama Lengkap"),
            _buildTextField(_nisController, "NIS"),
            _buildTextField(_nisnController, "NISN"),
            _buildTextField(_educationController, "Satuan Pendidikan"),
            _buildTextField(_pdbController, "Tempat Tanggal Lahir"),

            const SizedBox(height: 20),
            const Text(
              "Address Information",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            _buildTextField(_adressController, "Alamat Rumah"),
            _buildTextField(_villageController, "Desa/ Kelurahan"),
            _buildTextField(_wardController, "Kota/ Kabupaten"),
            _buildTextField(_subDistrictController, "Kecamatan"),
            _buildTextField(_rtController, "RT"),
            _buildTextField(_rwController, "RW"),

            const SizedBox(height: 20),
            const Text(
              "Family Information",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            _buildTextField(_namefatherController, "Nama Ayah"),
            _buildTextField(_namemotherController, "Nama Ibu"),
            _buildTextField(_nohpController, "Nomor Telepon"),
            _buildTextField(_closetcotactController, "Kontak Terdekat"),

            const SizedBox(height: 20),
            const Text(
              "Other Information",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            _buildTextField(_plateNumberController, "Plat Nomor"),

            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: _updateUser,
                child: const Text("Update"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk membangun TextField yang lebih bersih dan konsisten
  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}

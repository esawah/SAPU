import 'package:flutter/material.dart';
import 'package:sapu/db/database_helper.dart';
import 'package:sapu/models/user_data.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String address = '';
  String education = '';
  String nis = '';
  String nisn = '';
  String plateNumber = '';
  String village = '';
  String pdb = '';
  String subDistrict = '';
  String ward = '';
  String rt = '';
  String rw = '';
  String namemother = '';
  String namefather = '';
  String nohp = '';
  String closetcontact = '';

  // Fungsi untuk menyimpan data
  void _saveUser() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      User user = User(
        name: name,
        address: address,
        education: education,
        nis: nis,
        nisn: nisn,
        plateNumber: plateNumber,
        village: village,
        pdb: pdb,
        subDistrict: subDistrict,
        ward: ward,
        rt: rt,
        rw: rw,
        namefather: namefather,
        namemother: namemother,
        nohp: nohp,
        closetcontact: closetcontact,
      );

      DatabaseHelper dbHelper = DatabaseHelper();
      await dbHelper.insertUser(user);

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: const Text('Add Data')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextField('Nama Lengkap', (value) => name = value!),
              _buildTextField('Alamat Tinggal', (value) => address = value!),
              _buildTextField(
                  'Satuan Pendidikan', (value) => education = value!),
              _buildTextField('NIS', (value) => nis = value!,
                  isNumeric: true, isRequired: false),
              _buildTextField('NISN', (value) => nisn = value!,
                  isNumeric: true, isRequired: false),
              _buildTextField('Plat Nomor', (value) => plateNumber = value!),
              _buildTextField('Tempat Tanggal Lahir', (value) => pdb = value!),
              _buildTextField('Kecamatan', (value) => subDistrict = value!),
              _buildTextField('Kota/Kabupaten', (value) => ward = value!),
              _buildTextField('Desa/Kelurahan', (value) => village = value!),
              _buildTextField('RT', (value) => rt = value!, isNumeric: true),
              _buildTextField('RW', (value) => rw = value!, isNumeric: true),
              _buildTextField('Nama Ibu', (value) => namemother = value!),
              _buildTextField('Nama Ayah', (value) => namefather = value!),
              _buildTextField('Nomor Telepon', (value) => nohp = value!,
                  isNumeric: true),
              _buildTextField(
                  'Kontak Terdekat', (value) => closetcontact = value!,
                  isNumeric: true),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(screenWidth * 0.35, screenHeight * 0.05),
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: _saveUser,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, FormFieldSetter<String> onSaved,
      {bool isNumeric = false, bool isRequired = true}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.black),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Colors.black, width: 2.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Colors.black, width: 2.0),
          ),
        ),
        onSaved: onSaved,
        validator: (value) {
          if (isRequired && (value == null || value.isEmpty)) {
            return 'Please enter $label';
          }
          if (isNumeric &&
              value != null &&
              value.isNotEmpty &&
              !RegExp(r'^[0-9]+$').hasMatch(value)) {
            return '$label Hanya nomor yang diperbolehkan';
          }
          return null;
        },
        keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
      ),
    );
  }
}

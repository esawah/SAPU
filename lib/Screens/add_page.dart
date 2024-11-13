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
              _buildTextField('NIS', (value) => nis = value!),
              _buildTextField('NISN', (value) => nisn = value!),
              _buildTextField('Plat Nomor', (value) => plateNumber = value!),
              _buildTextField('Tempat Tanggal Lahir', (value) => pdb = value!),
              _buildTextField('Kecamatan', (value) => subDistrict = value!),
              _buildTextField('Kota/Kabupaten', (value) => ward = value!),
              _buildTextField('Desa/Kelurahan', (value) => village = value!),
              _buildTextField('RT', (value) => rt = value!),
              _buildTextField('RW', (value) => rw = value!),
              _buildTextField('Nama Ibu', (value) => namemother = value!),
              _buildTextField('Nama Ayah', (value) => namefather = value!),
              _buildTextField('Nomor Telepon', (value) => nohp = value!),
              _buildTextField(
                  'Kontak Terdekat', (value) => closetcontact = value!),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveUser,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, FormFieldSetter<String> onSaved) {
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
          if (value!.isEmpty) return 'Please enter $label';
          return null;
        },
      ),
    );
  }
}

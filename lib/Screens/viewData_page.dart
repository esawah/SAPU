import 'package:flutter/material.dart';
import 'package:sapu/models/user_data.dart';

class ViewDataPage extends StatelessWidget {
  final User user;
  const ViewDataPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('View Data')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              "Personal Information",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            UserInfoField(label: 'Nama Lengkap', value: user.name),
            UserInfoField(label: 'NIS', value: user.nis),
            UserInfoField(label: 'NISN', value: user.nisn),
            UserInfoField(label: 'Satuan Pendidikan', value: user.education),
            UserInfoField(label: 'Tempat Tanggal Lahir', value: user.pdb),

            const SizedBox(height: 20),
            const Text(
              "Address Information",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            UserInfoField(label: 'Alamat Rumah', value: user.address),
            UserInfoField(label: 'Desa/Kelurahan', value: user.village),
            UserInfoField(label: 'Kota/Kabupaten', value: user.ward),
            UserInfoField(label: 'Kecamatan', value: user.subDistrict),
            UserInfoField(label: 'RT', value: user.rt),
            UserInfoField(label: 'RW', value: user.rw),

            const SizedBox(height: 20),
            const Text(
              "Family Information",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            UserInfoField(label: 'Nama Ayah', value: user.namefather),
            UserInfoField(label: 'Nama Ibu', value: user.namemother),
            UserInfoField(label: 'Nomor Telepon', value: user.nohp),
            UserInfoField(label: 'Kontak Terdekat', value: user.closetcontact),

            const SizedBox(height: 20),
            const Text(
              "Other Information",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            UserInfoField(label: 'Plat Nomor', value: user.plateNumber),
          ],
        ),
      ),
    );
  }
}

class UserInfoField extends StatelessWidget {
  final String label;
  final String value;

  const UserInfoField({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController(text: value);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        readOnly: true,
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Colors.black, width: 2.0),
          ),
          filled: false,
        ),
      ),
    );
  }
}

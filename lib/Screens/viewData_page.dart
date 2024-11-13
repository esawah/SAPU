import 'package:flutter/material.dart';
import 'package:sapu/models/user_data.dart';

class ViewDataPage extends StatelessWidget {
  final User user;
  const ViewDataPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: const Text('View Data')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            UserInfoField(label: 'Nama Lengkap', value: user.name),
            Row(
              children: [
                Expanded(
                  child: UserInfoField(label: 'NIS', value: user.nis),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: UserInfoField(label: 'NISN', value: user.nisn),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: screenWidth * 0.45,
                  child: Expanded(
                      child: UserInfoField(
                          label: 'Satuan Pendidikan', value: user.education)),
                ),
              ],
            ),
            UserInfoField(label: 'Tempat Tanggal Lahir', value: user.pdb),
            UserInfoField(label: 'Alamat Rumah', value: user.address),
            Row(
              children: [
                Expanded(
                    child: UserInfoField(
                        label: 'Desa/Kelurahan', value: user.village)),
                SizedBox(width: 8),
                Expanded(
                    child: UserInfoField(
                        label: 'Kota/Kabupaten', value: user.ward)),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: UserInfoField(
                      label: 'Kecamatan', value: user.subDistrict),
                ),
                SizedBox(width: 8),
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Expanded(
                        child: UserInfoField(label: 'RT', value: user.rt),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: UserInfoField(label: 'RW', value: user.rw),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            UserInfoField(label: 'Nama Ayah', value: user.namefather),
            UserInfoField(label: 'Nama Ibu', value: user.namemother),
            Row(
              children: [
                Expanded(
                    child: UserInfoField(
                        label: 'Nomor Telepon', value: user.nohp)),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                    child: UserInfoField(
                        label: 'Kontak Terdekat', value: user.closetcontact)),
              ],
            ),
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
          labelStyle: const TextStyle(color: Colors.black),
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

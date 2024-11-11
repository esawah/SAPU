import 'package:flutter/material.dart';
import 'package:sapu/models/user_data.dart';

class ViewDataPage extends StatelessWidget {
  final User user;

  const ViewDataPage({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('View Data')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Nama Lengkap: ${user.name}', style: TextStyle(fontSize: 18)),
            Text('NIS: ${user.nis}', style: TextStyle(fontSize: 18)),
            Text('NISN: ${user.nisn}', style: TextStyle(fontSize: 18)),
            Text('Satuan Pendidikan: ${user.education}', style: TextStyle(fontSize: 18)),
            Text('Tempat Tanggal Lahir: ${user.pdb}', style: TextStyle(fontSize: 18)),
            Text('Alamat Rumah: ${user.address}', style: TextStyle(fontSize: 18)),
            Text('Desa/ keluarahan: ${user.village}', style: TextStyle(fontSize: 18)),
            Text('Kota/ kabupaten: ${user.ward}', style: TextStyle(fontSize: 18)),
            Text('Kecamatan: ${user.subDistrict}', style: TextStyle(fontSize: 18)),
            Text('RT: ${user.rt}', style: TextStyle(fontSize: 18)),
            Text('RW : ${user.rw}', style: TextStyle(fontSize: 18)),
            Text('Nama Ayah : ${user.namefather}', style: TextStyle(fontSize: 18)),
            Text('Nama Ibu : ${user.namemother}', style: TextStyle(fontSize: 18)),
            Text('Nomor Telepon: ${user.nohp}', style: TextStyle(fontSize: 18)),
            Text('kontak Tedekat: ${user.closetcontact}', style: TextStyle(fontSize: 18)),
            Text('Plat Nomor: ${user.plateNumber}', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}

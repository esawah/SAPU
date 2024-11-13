import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';
import 'package:sapu/db/database_helper.dart';
import 'package:sapu/models/user_data.dart';

class ImportPage extends StatefulWidget {
  const ImportPage({super.key});

  @override
  State<ImportPage> createState() => _ImportPageState();
}

class _ImportPageState extends State<ImportPage> {
  String? fileName;
  File? selectedFile;

  // Fungsi untuk memilih file
  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xls', 'xlsx'], // Hanya izinkan file Excel
      );

      if (result != null) {
        PlatformFile file = result.files.first;
        setState(() {
          fileName = file.name; // Simpan nama file yang dipilih
          selectedFile = File(file.path!);
        });

        // Tambahkan kode untuk mengimpor atau memproses file yang dipilih
        print("File terpilih: ${file.name}");
      } else {
        // Jika pengguna membatalkan pemilihan file
        setState(() {
          fileName = null;
        });
      }
    } catch (e) {
      print("Error picking file: $e");
    }
  }

  Future<void> _importDatatoDatabase() async {
    if (selectedFile == null) return;
    var bytes = selectedFile!.readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);

    for (var tabel in excel.tables.keys) {
      for (var row in excel.tables[tabel]!.rows) {
        String name = row[0]?.value.toString() ?? '';
        String nis = row[1]?.value.toString() ?? '';
        String nisn = row[2]?.value.toString() ?? '';
        String education = row[3]?.value.toString() ?? '';
        String pdb = row[4]?.value.toString() ?? '';
        String address = row[5]?.value.toString() ?? '';
        String ward = row[6]?.value.toString() ?? '';
        String subDistrict = row[7]?.value.toString() ?? '';
        String village = row[8]?.value.toString() ?? '';
        String rt = row[9]?.value.toString() ?? '';
        String rw = row[10]?.value.toString() ?? '';
        String namefather = row[11]?.value.toString() ?? '';
        String namemother = row[12]?.value.toString() ?? '';
        String nohp = row[13]?.value.toString() ?? '';
        String closetcontact = row[14]?.value.toString() ?? '';
        String plateNumber = row[15]?.value.toString() ?? '';

        await DatabaseHelper().insertUser(User(
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
            namemother: namemother,
            namefather: namefather,
            nohp: nohp,
            closetcontact: closetcontact));
      }
    }
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Data Berhasil Di import'),
    ));

    Navigator.popAndPushNamed(context, '/home_page');
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(padding: const EdgeInsets.only(top: 16.0)),
            Container(
              alignment: Alignment.center,
              height: screenHeight * 0.10,
              width: screenWidth * 0.75,
              child: Text(
                "Import data file Excel Anda di sini",
                style: GoogleFonts.getFont(
                  'Inter',
                  fontSize: screenWidth * 0.045,
                  color: Colors.black,
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                // Memanggil fungsi _pickFile saat InkWell ditekan
                await _pickFile(); // Tunggu hingga file dipilih atau dibatalkan
              }, // Panggil fungsi _pickFile saat Container ditekan
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Pilih File',
                      style: TextStyle(
                        fontSize: screenWidth * 0.08,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Icon(Icons.download, size: screenWidth * 0.08),
                    if (fileName != null) // Tampilkan nama file jika ada
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          fileName!,
                          style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            color: Colors.black54,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                  ],
                ),
                height: screenHeight * 0.14,
                width: screenWidth * 0.75,
                decoration: BoxDecoration(
                    // border: Border.all(color: Colors.amber, width: 2.0),
                    // borderRadius: BorderRadius.circular(15.0),
                    ),
              ),
            ),
            InkWell(
              onTap: () async {
                await _importDatatoDatabase();
              },
              child: Container(
              alignment: Alignment.topCenter,
              child: Text(
                "GO",
                style: GoogleFonts.getFont(
                  'Inter',
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              height: screenHeight * 0.06,
              width: screenWidth * 0.50,
              decoration: BoxDecoration(
                color: Colors.black,
                // border: Border.all(color: Colors.amber, width: 2.0),
                // borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            ),
          ],
        ),
      ),
    );
  }
}

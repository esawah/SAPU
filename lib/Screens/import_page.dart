import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';

class ImportPage extends StatefulWidget {
  const ImportPage({super.key});

  @override
  State<ImportPage> createState() => _ImportPageState();
}

class _ImportPageState extends State<ImportPage> {
  String? fileName;

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
              alignment: Alignment.bottomCenter,
              height: screenHeight * 0.20,
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
            const Spacer(),
            InkWell(
              onTap: () async {
                // Memanggil fungsi _pickFile saat InkWell ditekan
                await _pickFile(); // Tunggu hingga file dipilih atau dibatalkan
              }, // Panggil fungsi _pickFile saat Container ditekan
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                  border: Border.all(color: Colors.amber, width: 2.0),
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
            ),
            const Spacer(),
            Container(
              alignment: Alignment.center,
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
                border: Border.all(color: Colors.amber, width: 2.0),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            const Spacer(),
            Container(
              height: screenHeight * 0.20,
              width: screenWidth * 0.75,
              child: Image.asset(
                "assets/images/ba2.png",
                width: 200,
                height: 200,
                fit: BoxFit.contain,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

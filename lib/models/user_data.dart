class User {
  final int? id;
  final String name;
  final String address;
  final String education;
  final String nis;
  final String nisn;
  final String plateNumber;
  final String village;
  final String pdb;
  final String subDistrict;
  final String ward;
  final String rt;
  final String rw;
  final String namefather;
  final String namemother;
  final String nohp;
  final String closetcontact;

  User({
    this.id,
    required this.name,
    required this.address,
    required this.education,
    required this.nis,
    required this.nisn,
    required this.plateNumber,
    required this.village,
    required this.pdb,
    required this.subDistrict,
    required this.ward,
    required this.rt,
    required this.rw,
    required this.namemother,
    required this.namefather,
    required this.nohp,
    required this.closetcontact,
  });

  // Mengonversi User ke dalam map (untuk menyimpan ke database)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'education': education,
      'nis': nis,
      'nisn': nisn,
      'plateNumber': plateNumber,
      'village': village,
      'pdb': pdb,
      'subDistrict': subDistrict,
      'ward': ward,
      'rt': rt,
      'rw': rw,
      'namemother': namemother,
      'namefather': namefather,
      'nohp': nohp,
      'closetcontact': closetcontact,
    };
  }

  // Membaca user dari map (dari database)
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'] ?? '',
      address: map['address'] ?? '',
      education: map['education'] ?? '',
      nis: map['nis'] ?? '',
      nisn: map['nisn'] ?? '',
      plateNumber: map['plateNumber'] ?? '',
      village: map['village'] ?? '',
      pdb: map['pdb'] ?? '',
      subDistrict: map['subDistrict'] ?? '',
      ward: map['ward'] ?? '',
      rt: map['rt'] ?? '',
      rw: map['rw'] ?? '',
      namemother: map['namemother'] ?? '',
      namefather: map['namefather'] ?? '',
      nohp: map['nohp'] ?? '',
      closetcontact: map['closetcontact'] ?? '',
    );
  }
}

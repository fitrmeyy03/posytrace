/// Satu-satunya sumber data statis anak & sesi posyandu untuk role
/// orang tua.
///
/// Selama backend belum tersambung, seluruh halaman ortu membaca dari
/// [mark] ini — bukan dari string yang di-hardcode di tiap file.
/// Mengubah satu angka (mis. BB terbaru) cukup dilakukan di sini.
class ChildMeasurement {
  final String date;
  final String age;
  final String place;
  final String bb;
  final String tb;
  final String lk;
  const ChildMeasurement({
    required this.date,
    required this.age,
    required this.place,
    required this.bb,
    required this.tb,
    required this.lk,
  });
}

class ChildProfile {
  final String name;
  final String shortName;
  final String initials;
  final String gender;
  final String age;
  final String ageShort;
  final String posyanduId;
  final String nikMasked;
  final String posyandu;
  final String posyanduShort;
  final String address;
  final String status;
  final String weight;
  final String height;
  final String head;
  final String lila;
  final String weightNum;
  final String heightNum;
  final String headNum;
  final String lilaNum;
  final String motherName;
  final String motherShort;
  final String motherEmail;
  final String motherPhone;
  final String vaccineName;
  final String vaccineDate;
  final String vaccineTime;
  final String vaccinePlace;
  final String vaccineCountdown;
  final List<ChildMeasurement> measurements;

  const ChildProfile({
    required this.name,
    required this.shortName,
    required this.initials,
    required this.gender,
    required this.age,
    required this.ageShort,
    required this.posyanduId,
    required this.nikMasked,
    required this.posyandu,
    required this.posyanduShort,
    required this.address,
    required this.status,
    required this.weight,
    required this.height,
    required this.head,
    required this.lila,
    required this.weightNum,
    required this.heightNum,
    required this.headNum,
    required this.lilaNum,
    required this.motherName,
    required this.motherShort,
    required this.motherEmail,
    required this.motherPhone,
    required this.vaccineName,
    required this.vaccineDate,
    required this.vaccineTime,
    required this.vaccinePlace,
    required this.vaccineCountdown,
    required this.measurements,
  });
}

const markProfile = ChildProfile(
  name: 'Mark Kalandra',
  shortName: 'Mark',
  initials: 'M',
  gender: 'Laki-laki',
  age: '2 tahun 5 bulan',
  ageShort: '2th 5bln',
  posyanduId: 'ID Posyandu: #MEL-2024-089',
  nikMasked: '3208••••0091',
  posyandu: 'Posyandu Melati 04',
  posyanduShort: 'Melati 04',
  address: 'Kel. Bahagia, RW 05 • Posyandu Melati 04',
  status: 'Gizi Baik',
  weight: '15.0 kg',
  height: '118 cm',
  head: '49.2 cm',
  lila: '15.6 cm',
  weightNum: '15.0',
  heightNum: '118.0',
  headNum: '49.2',
  lilaNum: '15.6',
  motherName: 'Bunda Agnes Safitri',
  motherShort: 'Ibu Agnes',
  motherEmail: 'agnes.safitri@email.com',
  motherPhone: '0812-3456-7890',
  vaccineName: 'Vaksin MMR (Campak)',
  vaccineDate: 'Rabu, 14 Mei 2026',
  vaccineTime: '08:30 - 11:30 WIB',
  vaccinePlace: 'Balai RW 05 (400m dari rumah)',
  vaccineCountdown: '3 Hari Lagi',
  measurements: [
    ChildMeasurement(
        date: '29 Apr 2026',
        age: '29 bln',
        place: 'Posyandu Melati 04',
        bb: '15.0 kg',
        tb: '118 cm',
        lk: '49.2 cm'),
    ChildMeasurement(
        date: '15 Mar 2026',
        age: '28 bln',
        place: 'Posyandu Melati 04',
        bb: '14.7 kg',
        tb: '116.8 cm',
        lk: '49.0 cm'),
    ChildMeasurement(
        date: '10 Feb 2026',
        age: '27 bln',
        place: 'Posyandu Melati 04',
        bb: '14.4 kg',
        tb: '115.5 cm',
        lk: '48.8 cm'),
    ChildMeasurement(
        date: '12 Jan 2026',
        age: '26 bln',
        place: 'Posyandu Melati 04',
        bb: '14.1 kg',
        tb: '114.2 cm',
        lk: '48.5 cm'),
    ChildMeasurement(
        date: '08 Des 2025',
        age: '25 bln',
        place: 'Posyandu Melati 04',
        bb: '13.8 kg',
        tb: '113.0 cm',
        lk: '48.3 cm'),
    ChildMeasurement(
        date: '10 Nov 2025',
        age: '24 bln',
        place: 'Posyandu Melati 04',
        bb: '13.5 kg',
        tb: '111.8 cm',
        lk: '48.0 cm'),
  ],
);

import '../models/growth_status.dart';

/// Data contoh yang dipakai seluruh mockup — angkanya sama dengan
/// spesifikasi desain supaya tiap layar konsisten saat didemokan.
class DemoData {
  DemoData._();

  // ---- Akun yang sedang masuk ----
  static const kaderName = 'Ibu Sari';
  static const kaderFullName = 'Ibu Sari Wulandari';
  static const kaderPhone = '0812 3456 7890';
  static const posyanduName = 'Posyandu Melati';
  static const posyanduAddress = 'Balai Dusun Krajan';

  static const midwifeName = 'Bidan Ratna';
  static const midwifeFullName = 'Bidan Ratna Sari';
  static const midwifePhone = '0813 2200 4411';
  static const puskesmasName = 'Puskesmas Sukorejo';

  static const parentName = 'Ibu Dewi';
  static const parentFullName = 'Ibu Dewi Lestari';

  static const today = 'Sabtu, 24 Oktober 2026';
  static const nextSchedule = 'Sabtu, 14 November 2026';

  static const children = <ChildRecord>[
    ChildRecord(
      name: 'Aisyah Putri',
      gender: 'Perempuan',
      ageMonths: 24,
      birthDate: '12 Oktober 2024',
      status: GrowthStatus.normal,
      weight: 9.8,
      height: 86.5,
      weightGain: 0.4,
      zWeightAge: -1.2,
      zHeightAge: -0.8,
      zWeightHeight: -1.5,
      parentName: 'Ibu Dewi Lestari',
      parentPhone: '0812 3456 7890',
      posyandu: 'Melati',
      lastVisit: '24 Okt 2026',
      visits: [
        Visit('24 Okt 2026', 24, 9.8, 86.5, GrowthStatus.normal),
        Visit('26 Sep 2026', 23, 9.4, 85.9, GrowthStatus.normal),
        Visit('29 Agu 2026', 22, 9.1, 85.1, GrowthStatus.normal),
        Visit('25 Jul 2026', 21, 8.7, 84.2, GrowthStatus.normal),
      ],
    ),
    ChildRecord(
      name: 'Bima Aditya',
      gender: 'Laki-laki',
      ageMonths: 30,
      birthDate: '2 April 2024',
      status: GrowthStatus.normal,
      weight: 12.4,
      height: 91.0,
      weightGain: 0.3,
      zWeightAge: -0.6,
      zHeightAge: -0.4,
      zWeightHeight: -0.9,
      parentName: 'Ibu Dewi Lestari',
      parentPhone: '0812 3456 7890',
      posyandu: 'Melati',
      lastVisit: '24 Okt 2026',
      visits: [
        Visit('24 Okt 2026', 30, 12.4, 91.0, GrowthStatus.normal),
        Visit('26 Sep 2026', 29, 12.1, 90.2, GrowthStatus.normal),
      ],
    ),
    ChildRecord(
      name: 'Sinta Maharani',
      gender: 'Perempuan',
      ageMonths: 28,
      birthDate: '8 Juni 2024',
      status: GrowthStatus.over,
      weight: 14.6,
      height: 88.2,
      weightGain: 0.8,
      zWeightAge: 1.4,
      zHeightAge: 0.2,
      zWeightHeight: 2.3,
      parentName: 'Ibu Maya Kusuma',
      parentPhone: '0821 7788 9900',
      posyandu: 'Melati',
      lastVisit: '24 Okt 2026',
      visits: [
        Visit('24 Okt 2026', 28, 14.6, 88.2, GrowthStatus.over),
        Visit('26 Sep 2026', 27, 13.8, 87.4, GrowthStatus.over),
      ],
    ),
    ChildRecord(
      name: 'Rizky Pratama',
      gender: 'Laki-laki',
      ageMonths: 18,
      birthDate: '14 April 2025',
      status: GrowthStatus.severe,
      weight: 7.4,
      height: 76.0,
      weightGain: 0.1,
      zWeightAge: -3.1,
      zHeightAge: -2.2,
      zWeightHeight: -2.4,
      parentName: 'Ibu Rina Marlina',
      parentPhone: '0857 9012 3345',
      posyandu: 'Melati',
      lastVisit: '24 Okt 2026',
      visits: [
        Visit('24 Okt 2026', 18, 7.4, 76.0, GrowthStatus.severe),
        Visit('26 Sep 2026', 17, 7.3, 75.4, GrowthStatus.severe),
      ],
    ),
    ChildRecord(
      name: 'Nadia Safitri',
      gender: 'Perempuan',
      ageMonths: 20,
      birthDate: '3 Feb 2025',
      status: GrowthStatus.under,
      weight: 8.2,
      height: 78.9,
      weightGain: 0.2,
      zWeightAge: -1.9,
      zHeightAge: -2.4,
      zWeightHeight: -1.8,
      parentName: 'Ibu Sari Wulandari',
      parentPhone: '0813 2200 4411',
      posyandu: 'Mawar',
      lastVisit: '22 Okt 2026',
      visits: [
        Visit('22 Okt 2026', 20, 8.2, 78.9, GrowthStatus.under),
        Visit('24 Sep 2026', 19, 8.0, 78.1, GrowthStatus.under),
      ],
    ),
    ChildRecord(
      name: 'Dimas Prasetyo',
      gender: 'Laki-laki',
      ageMonths: 26,
      birthDate: '11 Agu 2024',
      status: GrowthStatus.under,
      weight: 10.1,
      height: 85.0,
      weightGain: 0.2,
      zWeightAge: -1.8,
      zHeightAge: -1.6,
      zWeightHeight: -2.2,
      parentName: 'Ibu Maya Kusuma',
      parentPhone: '0821 7788 9900',
      posyandu: 'Anggrek',
      lastVisit: '21 Okt 2026',
      visits: [
        Visit('21 Okt 2026', 26, 10.1, 85.0, GrowthStatus.under),
      ],
    ),
  ];

  static List<ChildRecord> get needAttention => children
      .where((c) =>
          c.status == GrowthStatus.severe || c.status == GrowthStatus.under)
      .toList();

  static ChildRecord get aisyah => children.first;

  static List<ChildRecord> get dewiChildren =>
      children.where((c) => c.parentName == 'Ibu Dewi Lestari').toList();

  static ChildRecord byName(String name) =>
      children.firstWhere((c) => c.name == name);

  static const parents = <ParentRecord>[
    ParentRecord('Ibu Dewi Lestari', '0812 3456 7890', 2, 'Melati', true),
    ParentRecord('Ibu Sari Wulandari', '0813 2200 4411', 1, 'Melati', true),
    ParentRecord('Ibu Rina Marlina', '0857 9012 3345', 1, 'Melati', true),
    ParentRecord('Ibu Maya Kusuma', '0821 7788 9900', 3, 'Melati', true),
  ];

  static const posyandu = <PosyanduRecord>[
    PosyanduRecord('Posyandu Melati', 48, 5, 3, '24 Okt 2026'),
    PosyanduRecord('Posyandu Mawar', 42, 4, 2, '22 Okt 2026'),
    PosyanduRecord('Posyandu Anggrek', 38, 4, 1, '21 Okt 2026'),
  ];

  static const cadres = <CadreRecord>[
    CadreRecord('Ibu Sari Wulandari', 'Posyandu Melati', true),
    CadreRecord('Ibu Wati Hartini', 'Posyandu Melati', true),
    CadreRecord('Ibu Rina Marlina', 'Posyandu Mawar', true),
    CadreRecord('Ibu Tini Susanti', 'Posyandu Anggrek', false),
  ];

  static const articles = <ArticleRecord>[
    ArticleRecord(
      title: 'MP-ASI Kaya Protein untuk Cegah Stunting',
      category: 'Gizi',
      date: '20 Okt 2026',
      readMinutes: 4,
      readers: 84,
      published: true,
      excerpt:
          'Mulai usia 6 bulan, ASI saja tidak lagi mencukupi kebutuhan energi dan zat besi anak. MP-ASI yang tepat — terutama yang mengandung protein hewani — membantu mencegah stunting.',
      body:
          'Mulai usia 6 bulan, ASI saja tidak lagi mencukupi kebutuhan energi dan zat besi anak. MP-ASI yang tepat — terutama yang mengandung protein hewani — membantu mencegah stunting.\n\n'
          'Sumber protein hewani yang mudah didapat:\n'
          '• Telur ayam\n'
          '• Ikan lele & ikan kembung\n'
          '• Ayam & hati ayam\n\n'
          'Berikan MP-ASI 2–3 kali sehari plus 1–2 kali makanan selingan, dengan tekstur yang naik bertahap sesuai usia anak.',
      tips: [
        'Telur matang, dicincang sesuai kemampuan makan anak.',
        'Ikan tanpa duri, dimasak lembut dan disuwir halus.',
        'Tempe atau tahu, dipadukan dengan sayur dan sumber karbohidrat.',
      ],
      image: 'assets/images/banner/artikel/artikel-gizi.png',
      banner: 'assets/images/banner/banner-gizi-1790x840.png',
    ),
    ArticleRecord(
      title: 'Menu PMT Lokal: Murah, Bergizi, Disukai Anak',
      category: 'PMT',
      date: '28 Sep 2026',
      readMinutes: 5,
      readers: 51,
      published: true,
      excerpt:
          'Bahan lokal seperti telur, ikan lele, tempe, dan daun kelor adalah sumber gizi yang terjangkau dan mudah didapat di sekitar kita.',
      body:
          'Bahan lokal seperti telur, ikan lele, tempe, dan daun kelor adalah sumber gizi yang terjangkau dan mudah didapat di sekitar kita.\n\n'
          'Contoh menu: bubur beras dengan hati ayam dan daun kelor, atau nasi lembek dengan pepes ikan kembung. Sajikan dalam porsi kecil tapi sering, 2–3 kali sehari.',
      image: 'assets/images/banner/artikel/artikel-pmt.png',
      banner: 'assets/images/banner/banner-pmt-1790x840.png',
    ),
    ArticleRecord(
      title: 'Stimulasi Anak Usia 2 Tahun di Rumah',
      category: 'Stimulasi',
      date: 'diubah 22 Okt',
      readMinutes: 3,
      readers: 0,
      published: false,
      excerpt:
          'Aktivitas sederhana sehari-hari yang membantu perkembangan motorik dan bahasa anak usia dua tahun.',
      body:
          'Aktivitas sederhana sehari-hari yang membantu perkembangan motorik dan bahasa anak usia dua tahun.',
      image: 'assets/images/banner/artikel/artikel-stimulasi.png',
      banner: 'assets/images/banner/banner-stimulasi-1790x840.png',
    ),
    ArticleRecord(
      title: 'Jadwal Imunisasi Balita yang Perlu Diingat',
      category: 'Imunisasi',
      date: '5 Okt 2026',
      readMinutes: 4,
      readers: 37,
      published: true,
      excerpt:
          'Imunisasi dasar lengkap melindungi anak dari penyakit yang bisa dicegah. Catat tanggalnya agar tidak terlewat.',
      body:
          'Imunisasi dasar lengkap melindungi anak dari penyakit yang bisa dicegah. Catat tanggalnya agar tidak terlewat.\n\n'
          'Bawa buku KIA setiap kunjungan posyandu agar kader dapat mencatat imunisasi yang sudah diterima.',
    ),
  ];

  static const schedules = <ScheduleRecord>[
    ScheduleRecord('Penimbangan & Imunisasi', 'Sabtu, 14 Nov 2026',
        '08.00–11.00', 'Balai Dusun Krajan'),
    ScheduleRecord('Penimbangan & PMT', 'Sabtu, 12 Des 2026', '08.00–11.00',
        'Balai Dusun Krajan'),
    ScheduleRecord('Penimbangan Rutin', 'Sabtu, 9 Jan 2027', '08.00–11.00',
        'Balai Dusun Krajan'),
  ];

  static const pastSchedules = <ScheduleRecord>[
    ScheduleRecord('Penimbangan Rutin', 'Sabtu, 24 Oktober 2026',
        '08.00–11.00', 'Balai Dusun Krajan'),
    ScheduleRecord('Penimbangan Rutin', 'Sabtu, 26 September 2026',
        '08.00–11.00', 'Balai Dusun Krajan'),
  ];

  static const notifications = <NotificationRecord>[
    NotificationRecord('Hasil kunjungan Aisyah', 'Status Gizi Baik · 24 Okt 2026',
        isNew: true, kind: NotificationKind.result),
    NotificationRecord(
        'Artikel baru dari Bidan Ratna',
        'MP-ASI Kaya Protein untuk Cegah Stunting',
        isNew: true,
        kind: NotificationKind.article),
    NotificationRecord('Pengingat posyandu',
        'Sabtu, 14 Nov 2026 · Balai Dusun Krajan',
        isNew: true, kind: NotificationKind.schedule),
    NotificationRecord('Hasil kunjungan Aisyah', 'Status Normal · 26 Sep 2026',
        isNew: false, kind: NotificationKind.result),
    NotificationRecord('Pengingat posyandu',
        'Sabtu, 26 Sep 2026 · Balai Dusun Krajan',
        isNew: false, kind: NotificationKind.schedule),
  ];
}

// ============================================================
// MODEL
// ============================================================

class Visit {
  const Visit(this.date, this.ageMonths, this.weight, this.height, this.status);
  final String date;
  final int ageMonths;
  final double weight;
  final double height;
  final GrowthStatus status;
}

class ChildRecord {
  const ChildRecord({
    required this.name,
    required this.gender,
    required this.ageMonths,
    required this.birthDate,
    required this.status,
    required this.weight,
    required this.height,
    required this.zWeightAge,
    required this.zHeightAge,
    required this.zWeightHeight,
    required this.parentName,
    required this.parentPhone,
    required this.posyandu,
    required this.lastVisit,
    this.weightGain = 0,
    this.visits = const [],
  });

  final String name;
  final String gender;
  final int ageMonths;
  final String birthDate;
  final GrowthStatus status;
  final double weight;
  final double height;
  final double weightGain;
  final double zWeightAge;
  final double zHeightAge;
  final double zWeightHeight;
  final String parentName;
  final String parentPhone;
  final String posyandu;
  final String lastVisit;
  final List<Visit> visits;

  String get initial => name.substring(0, 1).toUpperCase();
  String get genderShort => gender == 'Perempuan' ? 'P' : 'L';
  String get ageLabel => '$ageMonths bulan';
  String get parentInitial => parentName
      .replaceFirst('Ibu ', '')
      .substring(0, 1)
      .toUpperCase();
}

class ParentRecord {
  const ParentRecord(
      this.name, this.phone, this.childCount, this.posyandu, this.active);
  final String name;
  final String phone;
  final int childCount;
  final String posyandu;
  final bool active;

  String get initial =>
      name.replaceFirst('Ibu ', '').substring(0, 1).toUpperCase();
}

class PosyanduRecord {
  const PosyanduRecord(
      this.name, this.children, this.cadres, this.needAttention, this.lastVisit);
  final String name;
  final int children;
  final int cadres;
  final int needAttention;
  final String lastVisit;
}

class CadreRecord {
  const CadreRecord(this.name, this.posyandu, this.active);
  final String name;
  final String posyandu;
  final bool active;

  String get initial =>
      name.replaceFirst('Ibu ', '').substring(0, 1).toUpperCase();
}

class ArticleRecord {
  const ArticleRecord({
    required this.title,
    required this.category,
    required this.date,
    required this.readMinutes,
    required this.readers,
    required this.published,
    required this.excerpt,
    required this.body,
    this.tips = const [],
    this.image,
    this.banner,
  });
  final String title;
  final String category;
  final String date;
  final int readMinutes;
  final int readers;
  final bool published;
  final String excerpt;
  final String body;
  final List<String> tips;
  final String? image;
  final String? banner;
}

class ScheduleRecord {
  const ScheduleRecord(this.title, this.date, this.time, this.place);
  final String title;
  final String date;
  final String time;
  final String place;
}

enum NotificationKind { result, article, schedule }

class NotificationRecord {
  const NotificationRecord(this.title, this.body,
      {required this.isNew, required this.kind});
  final String title;
  final String body;
  final bool isNew;
  final NotificationKind kind;
}

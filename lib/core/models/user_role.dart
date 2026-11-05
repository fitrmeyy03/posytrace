import '../data/demo_data.dart';

/// Peran yang masuk — menentukan isi profil & rute beranda.
enum UserRole {
  kader('Kader', DemoData.kaderFullName, DemoData.kaderPhone,
      DemoData.posyanduName),
  bidan('Bidan', DemoData.midwifeFullName, DemoData.midwifePhone,
      DemoData.puskesmasName),
  parent('Orang Tua', DemoData.parentFullName, '0812 3456 7890',
      DemoData.posyanduName);

  const UserRole(this.label, this.fullName, this.phone, this.unit);

  final String label;
  final String fullName;
  final String phone;
  final String unit;

  String get firstName => switch (this) {
        UserRole.kader => 'Ibu Sari',
        UserRole.bidan => 'Bidan Ratna',
        UserRole.parent => 'Ibu Dewi',
      };

  String get initial => switch (this) {
        UserRole.kader => 'S',
        UserRole.bidan => 'R',
        UserRole.parent => 'D',
      };

  String get unitLabel => switch (this) {
        UserRole.kader => 'Kader · ${DemoData.posyanduName}',
        UserRole.bidan => 'Bidan · ${DemoData.puskesmasName}',
        UserRole.parent => 'Orang Tua · ${DemoData.posyanduName}',
      };
}

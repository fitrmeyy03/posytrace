# Struktur Kode

Dokumen ini menjelaskan pembagian folder di `lib/` dan aturan penempatan kode baru.
Tujuannya satu: saat menambah layar atau data baru, tidak perlu menebak file-nya
diletakkan di mana.

## Pohon direktori

```
lib/
├── main.dart
├── core/
│   ├── constants/
│   │   └── app_colors.dart
│   ├── data/
│   │   └── demo_data.dart
│   ├── models/
│   │   ├── child_profile.dart
│   │   ├── growth_status.dart
│   │   └── user_role.dart
│   ├── theme/
│   │   ├── app_theme.dart
│   │   ├── app_spacing.dart
│   │   └── app_layout.dart
│   └── widgets/
│       ├── app_widgets.dart
│       ├── app_mascot.dart
│       └── brand_logo.dart
└── features/
    ├── auth/presentation/pages/
    ├── onboarding/presentation/pages/
    ├── parent/presentation/pages/
    ├── kader/presentation/pages/
    ├── midwife/presentation/pages/
    └── shared/presentation/pages/
```

## Aturan penempatan

**`core/` tidak berisi halaman.** Isinya hanya hal yang dipakai lebih dari satu fitur:
model, tema, konstanta, widget, dan data sementara. `core/` juga tidak boleh mengimpor
apa pun dari `features/`.

**`features/<nama>/` adalah satu domain atau satu peran.** Saat ini semua fitur masih
satu lapis, yaitu `presentation/pages/`. Lapis lain (`data/`, `domain/`) baru dibuat
ketika memang ada isinya — jangan bikin folder kosong untuk mengantisipasi masa depan.

**`features/shared/` untuk halaman yang dipakai lebih dari satu peran.** Contoh:
profil, notifikasi, grafik pertumbuhan, detail anak, dan ganti kata sandi dipakai oleh
orang tua, kader, maupun bidan. Halaman yang hanya dipakai satu peran tetap di dalam
folder peran tersebut.

**Model selalu di `core/models/`.** Kalau suatu model hanya dipakai satu fitur dan
ukurannya besar, model itu boleh pindah ke `features/<nama>/domain/models/`. Untuk
kondisi sekarang, semua model masih dipakai lintas peran sehingga berada di `core/`.

## Konvensi penamaan

| Objek | Pola | Contoh |
| --- | --- | --- |
| Halaman | `<nama>_page.dart` | `record_visit_page.dart` |
| Widget yang dipakai ulang | `<nama>.dart` di `core/widgets/` | `app_mascot.dart` |
| Model | `<nama>.dart`, kelas tanpa akhiran | `growth_status.dart` |
| Shell navigasi | `<peran>_main_shell.dart` | `kader_main_shell.dart` |

Impor antar folder memakai jalur relatif, mengikuti gaya yang sudah ada di kode.

## Yang sengaja belum ada

Struktur ini tidak memakai `repository`, `usecase`, `bloc`, atau `provider`, karena
aplikasi belum memiliki backend dan seluruh data masih statis. Lapis-lapis itu baru
layak ditambahkan saat sumber data nyata sudah ada, supaya tidak menjadi lapisan kosong
yang hanya menambah file.

## Data sementara

`core/data/demo_data.dart` dan konstanta profil anak di `core/models/child_profile.dart`
adalah pengganti backend. Saat integrasi API dimulai, keduanya digantikan oleh lapis data
per fitur, dan halaman tidak lagi mengimpor `demo_data.dart` secara langsung.

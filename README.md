# PosyTrace

Aplikasi pemantauan tumbuh kembang anak dan kegiatan Posyandu, dikembangkan sebagai
skripsi. Satu aplikasi dengan tiga peran pengguna:

| Peran | Fokus layar |
| --- | --- |
| Orang tua | Dashboard anak, riwayat pengukuran, grafik pertumbuhan, jadwal posyandu, artikel edukasi |
| Kader | Data orang tua dan anak, pencatatan kunjungan, jadwal posyandu |
| Bidan | Dashboard pemantauan, surveilans status gizi, kelola kader, kelola Posyandu, artikel |

## Status

Masih tahap pengembangan. Seluruh data masih berasal dari data dummy di
`lib/core/data/demo_data.dart` dan `lib/core/models/child_profile.dart`; belum ada
backend, autentikasi nyata, maupun penyimpanan lokal.

## Menjalankan

Prasyarat: Flutter 3.38.3 (Dart 3.10.1) atau lebih baru.

```bash
flutter pub get
flutter run
```

## Pengujian

```bash
flutter analyze
flutter test
```

## Struktur proyek

```
lib/
├── main.dart                 # entry point + daftar route
├── core/                     # dipakai lintas fitur, tanpa halaman
│   ├── constants/            # konstanta (warna, dsb.)
│   ├── data/                 # data dummy (sementara)
│   ├── models/               # model data
│   ├── theme/                # tema, spacing, layout
│   └── widgets/              # widget yang dipakai ulang
└── features/                 # per fitur / per peran
    ├── auth/
    ├── onboarding/
    ├── parent/
    ├── kader/
    ├── midwife/
    └── shared/               # halaman lintas peran (profil, notifikasi, grafik)
        └── presentation/pages/
```

Penjelasan lengkap dan aturan penempatan kode ada di [docs/architecture.md](docs/architecture.md).

## Alur kerja Git

- `main` selalu dalam kondisi lulus `analyze` dan `test`.
- Pekerjaan dilakukan di branch `feat/...` atau `fix/...`, lalu digabung lewat pull request.
- Penanda rilis memakai tag `vX.Y.Z`, bukan branch terpisah.
- Riwayat perubahan dicatat di [CHANGELOG.md](CHANGELOG.md).

## Dokumen pendukung

Diagram alur dan ERD tersimpan di root repositori dalam format Mermaid (`.mmd`):

- `posytrace_flowchart.mmd`, `posytrace_erd.mmd` — alur umum dan rancangan basis data
- `flowchart_*.mmd` — alur per fitur (login, jadwal, pengukuran, notifikasi, artikel, grafik)
- `posytrace_activity*.mmd` — activity diagram

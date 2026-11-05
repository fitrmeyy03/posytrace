# Changelog

Semua perubahan penting pada proyek ini dicatat di file ini.
Format mengikuti [Keep a Changelog](https://keepachangelog.com/id/1.1.0/).

## [Unreleased]

### Ditambahkan

- Peran kader: pengelolaan data orang tua, pencatatan kunjungan, dan jadwal posyandu
- Halaman surveilans status gizi dan pengelolaan Posyandu untuk bidan
- Halaman detail anak, grafik pertumbuhan, dan ganti kata sandi
- Dokumen alur (flowchart), activity diagram, dan ERD dalam format Mermaid
- Workflow CI untuk `flutter analyze` dan `flutter test`

### Diubah

- Halaman lintas peran dipindah dari `core/shared/pages/` ke
  `features/shared/presentation/pages/`
- Model `ChildProfile` dipindah ke `core/models/`

### Dihapus

- Halaman pendaftaran dan lupa kata sandi
- Beberapa pengujian lama yang sudah tidak relevan

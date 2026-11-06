# Alur Kerja Git

Repositori ini memakai tiga branch tetap yang tidak pernah dihapus, ditambah branch
sementara untuk pekerjaan harian.

## Branch tetap

| Branch | Peran | Proteksi |
| --- | --- | --- |
| `main` | **Production.** Kode yang stabil dan siap didemokan atau disidangkan. | PR wajib, CI wajib hijau, force-push dilarang, aturan berlaku juga untuk admin |
| `staging` | **Pra-rilis.** Tempat mengecek perubahan sebelum masuk `main`. | PR wajib, CI wajib hijau, force-push dilarang, admin boleh bypass |
| `develop` | **Integrasi harian.** Tempat kerja sehari-hari. | Tanpa proteksi, push langsung diperbolehkan |

Branch tetap **sengaja tidak dihapus** setelah di-merge, supaya jejak tiap tahap tetap
bisa dilihat.

## Branch sementara

Branch untuk satu pekerjaan, dibuat dari `develop`, lalu dihapus setelah merge.

| Awalan | Untuk |
| --- | --- |
| `feat/` | Fitur baru, mis. `feat/surveilans-gizi` |
| `fix/` | Perbaikan bug, mis. `fix/validasi-login` |
| `docs/` | Dokumentasi |
| `chore/` | Perapian struktur, konfigurasi, dependensi |

## Alur

```
feat/...  ──PR──>  develop  ──PR──>  staging  ──PR──>  main  ──tag──>  v1.0.0
 (sementara)        (tetap)          (tetap)         (tetap)
```

Aturan praktisnya:

- **Kerja harian** di `feat/...`, PR ke `develop`. PR ke `develop` tetap menjalankan CI.
- **Siap dites menyeluruh** → PR `develop` ke `staging`.
- **Siap final / mau sidang** → PR `staging` ke `main`, lalu beri tag `vX.Y.Z`.
- Perbaikan darurat boleh PR langsung ke `staging` atau `main` tanpa lewat `develop`.

## Perintah

Mulai pekerjaan baru:

```bash
git switch develop
git pull
git switch -c feat/nama-fitur
```

Setelah selesai:

```bash
git add -A
git commit -m "feat: ..."
git push -u origin feat/nama-fitur
gh pr create --base develop --fill
gh pr checks --watch
gh pr merge --squash --delete-branch
```

Menaikkan tahap:

```bash
gh pr create --base staging --head develop --title "Rilis ke staging"
gh pr merge --squash        # tanpa --delete-branch, branch tetap
```

## Catatan

Tiga branch tetap berarti tiga tempat merge. Untuk proyek yang dikerjakan sendiri, ini
menambah langkah, jadi pakai seperlunya: kalau `staging` tidak dipakai, cukup lompat
`develop` → `main`. Yang penting konsisten, bukan lengkap.

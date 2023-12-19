# Proyek Akhir Semester - Kindle Kids 📝
## Kelompok D06 👨‍👨‍👧‍👧
![staging](https://github.com/D06-PBP-2023-2024/tugas-uas/actions/workflows/staging.yml/badge.svg)
![pre-release](https://github.com/D06-PBP-2023-2024/tugas-uas/actions/workflows/pre-release.yml/badge.svg)
![release](https://github.com/D06-PBP-2023-2024/tugas-uas/actions/workflows/release.yml/badge.svg)
[![Build status](https://build.appcenter.ms/v0.1/apps/aa20e829-3f86-4f93-8bb9-8d55dc5d1592/branches/main/badge)](https://appcenter.ms)
- 2206081521 - Juan Dharmananda Khusuma
- 2206081673 - Rachel Mathilda
- 2206081660 - Rifda Aulia Nurbahri
- 2206083205 - Syifa Mahira Rahmah Dharmawan
- 2206818953 - Eudora Vanya Lindsay
- 2206829206 - Dwiky Ahmad Megananta

---

## Aplikasi 🌐
KindleKids 📖

---

## Fungsi Aplikasi ℹ️
KindleKids sebagai aplikasi mobile memberikan akses yang lebih mudah pada perpustakaan buku anak online. Integrasi KindleKids web menjadi aplikasi mobile memberikan akses lebih fleksibel karena penggunaan perangkat mobile yang lebih umum digunakan oleh anak-anak. KindleKids dibuat dengan harapan dapat membiasakan anak-anak membaca sejak dini, mendorong imajinasi dan kreativitas anak, serta memberikan akses gratis dan fleksibel ke buku berkualitas. Selain membaca, aplikasi KindleKids juga menjadi sarana belajar tambahan, seperti memperkaya kosakata dan pengetahuan anak-anak. Dengan adanya KindleKids, diharapkan dapat membantu masyarakat dalam memenuhi kebutuhan literasi dan pendidikan anak-anak.

---

## Daftar Modul ✍️
1. **Authentication (Rifda Aulia Nurbahri)**
> Authentication berupa halaman login untuk pengguna yang sudah memiliki akun, halaman register untuk membuat akun pengguna, serta fitur logout untuk keluar dari sesi aplikasi.
2. **Home and book's detail page (Juan Dharmananda Khusuma)**
> Halaman depan menampilkan daftar semua judul buku dan page untuk keterangan dari masing-masing buku seperti cover, judul buku, tags, author, dll.
3. **Like, comment, and reading list (Rachel Mathilda)**
> Pada setiap buku, terdapat fitur untuk memberikan like dan comment, serta buku yang ingin dibaca dapat dimasukkan pada reading list
4. **User information page (Eudora Vanya Lindsay)**
> Halaman yang menampilkan informasi pengguna, reading list pengguna, serta buku yang pernah di-like dan comment-comment yang pernah ditulis pengguna pada setiap buku
5. **Reading forum (Syifa Mahira Rahmah Dharmawan)**
> Forum merupakan fitur untuk berdiskusi dengan pengguna-pengguna lain seputar buku secara umum maupun untuk buku tertentu
6. **Tags, title search, and group by tags (Dwiky Ahmad Megananta)**
> Tags berupa label untuk setiap buku yang dapat merepresentasikan karakteristik maupun topik buku. Fitur tags dilengkapi dengan fitur group by tags yang dapat mengelompokkan buku berdasarkan tag yang sama sehingga memudahkan organisasi atau pencarian buku. Fitur terakhir yaitu title search untuk melakukan pencarian buku berdasarkan judul buku yang tersedia.

---

### Roles 👷‍♂️
> 1. **Admin**
> Admin adalah pengguna aplikasi yang sudah melakukan register dan login sebagai admin. Admin dapat menambahkan tags pada buku serta menghapus buku. Admin dapat menulis pada forum serta comment dan akan terdapat tag pada username bahwa penulis merupakan admin.
> 2. **User**
> User adalah pengguna yang sudah melakukan login sebagai user biasa dan dapat membaca isi buku, memberikan like dan comment pada setiap buku, menulis pada forum, serta menggunakan reading list yaitu fitur yang dibuat untuk menyimpan buku-buku yang ingin dibaca.
> 3. **Anon**
> Anonymous merupakan pengguna yang belum melakukan login pada aplikasi sehingga hanya dapat membaca buku, melihat like dan comment, dan membaca forum. Anonymous tidak dapat memberi like dan comment maupun menulis forum.

---

### Alur Integrasi
- Memodifikasi modul-modul pada tugas PTS agar mengimplementasikan REST API yang mengembalikan JSON menggunakan ```JsonResponse``` dan ```serializers``` sehingga data-data pada server Django dapat diakses pada endpoint ```http://https://kindle-kids-d06-tk.pbp.cs.ui.ac.id/[path]/json```.
- Menggunakan library Dart ```pbp_django_auth``` untuk pengimplementasi cookie-based authentication.
- Membuat tampilan menggunakan widget Flutter yang terintegrasi dengan API Django menggunakan asynchronous programming dan event handling untuk memberikan interaktivitas dan pengalaman pengguna yang baik.
---


## Berita Acara D06
https://docs.google.com/spreadsheets/d/141Iftnyai4CwM-EX4dQcJGiJMPbzJ-zCG5D0IwtABtE/edit?usp=sharing

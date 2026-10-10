import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/favorit_model.dart';
import '../navigation/app_routes.dart';

class HalamanLayanan extends StatelessWidget {
  const HalamanLayanan({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          const Material(
            child: TabBar(
              isScrollable: true,
              tabs: [
                Tab(icon: Icon(Icons.description_outlined), text: 'Perizinan'),
                Tab(
                  icon: Icon(Icons.local_hospital_outlined),
                  text: 'Kesehatan',
                ),
                Tab(
                  icon: Icon(Icons.directions_bus_outlined),
                  text: 'Transportasi',
                ),
              ],
            ),
          ),

          Expanded(
            child: TabBarView(
              children: [
                // =========================
                // TAB PERIZINAN
                // =========================
                _buatDaftarLayanan(context, [
                  {
                    'nama': 'Izin Usaha',
                    'dinas': 'Dinas Penanaman Modal',
                    'jam': '08.00 - 15.00',
                    'keterangan': 'Layanan pengajuan izin usaha bagi warga.',
                  },
                  {
                    'nama': 'Izin Bangunan',
                    'dinas': 'Dinas Pekerjaan Umum',
                    'jam': '08.00 - 15.00',
                    'keterangan':
                        'Layanan pengurusan izin pembangunan bangunan.',
                  },
                  {
                    'nama': 'Izin Reklame',
                    'dinas': 'Dinas Perizinan Kota',
                    'jam': '08.00 - 14.00',
                    'keterangan': 'Layanan pengajuan izin pemasangan reklame.',
                  },
                ]),

                // =========================
                // TAB KESEHATAN
                // =========================
                _buatDaftarLayanan(context, [
                  {
                    'nama': 'Pendaftaran Puskesmas',
                    'dinas': 'Dinas Kesehatan',
                    'jam': '07.00 - 14.00',
                    'keterangan': 'Pendaftaran layanan kesehatan di puskesmas.',
                  },
                  {
                    'nama': 'Jadwal Dokter',
                    'dinas': 'Dinas Kesehatan',
                    'jam': '08.00 - 16.00',
                    'keterangan':
                        'Informasi jadwal dokter dan tenaga kesehatan.',
                  },
                  {
                    'nama': 'Layanan Ambulans',
                    'dinas': 'Dinas Kesehatan',
                    'jam': '24 Jam',
                    'keterangan': 'Informasi dan permintaan layanan ambulans.',
                  },
                ]),

                // =========================
                // TAB TRANSPORTASI
                // =========================
                _buatDaftarLayanan(context, [
                  {
                    'nama': 'Kartu Transportasi',
                    'dinas': 'Dinas Perhubungan',
                    'jam': '08.00 - 15.00',
                    'keterangan':
                        'Pengajuan dan informasi kartu transportasi warga.',
                  },
                  {
                    'nama': 'Informasi Bus',
                    'dinas': 'Dinas Perhubungan',
                    'jam': '06.00 - 21.00',
                    'keterangan': 'Informasi rute dan jadwal bus kota.',
                  },
                  {
                    'nama': 'Pengaduan Transportasi',
                    'dinas': 'Dinas Perhubungan',
                    'jam': '24 Jam',
                    'keterangan':
                        'Layanan pengaduan terkait transportasi kota.',
                  },
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buatDaftarLayanan(
    BuildContext context,
    List<Map<String, String>> daftar,
  ) {
    // Mendengarkan perubahan data favorit.
    // Jika favorit berubah, bagian daftar layanan akan diperbarui.
    final favoritModel = context.watch<FavoritModel>();

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: daftar.length,
      separatorBuilder: (context, index) {
        return const SizedBox(height: 10);
      },
      itemBuilder: (context, index) {
        final layanan = daftar[index];
        final namaLayanan = layanan['nama']!;

        // Mengecek apakah layanan ini sudah menjadi favorit.
        final isFavorit = favoritModel.favorit.contains(namaLayanan);

        return Card(
          child: ListTile(
            leading: const CircleAvatar(
              child: Icon(Icons.miscellaneous_services),
            ),

            title: Text(
              namaLayanan,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),

            subtitle: Text(layanan['dinas']!),

            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // =========================
                // TOMBOL FAVORIT
                // =========================
                IconButton(
                  tooltip: isFavorit
                      ? 'Hapus dari favorit'
                      : 'Tambahkan ke favorit',
                  onPressed: () {
                    // context.read() digunakan untuk
                    // menjalankan operasi tanpa ikut
                    // mendengarkan perubahan.
                    final model = context.read<FavoritModel>();

                    if (isFavorit) {
                      model.batalTandai(namaLayanan);
                    } else {
                      model.tandai(namaLayanan);
                    }
                  },
                  icon: Icon(
                    isFavorit ? Icons.star : Icons.star_border,
                    color: isFavorit ? Colors.amber : null,
                  ),
                ),

                // =========================
                // ICON DETAIL
                // =========================
                const Icon(Icons.chevron_right),
              ],
            ),

            // =========================
            // BUKA DETAIL LAYANAN
            // =========================
            onTap: () async {
              final hasil = await Navigator.pushNamed(
                context,
                AppRoutes.detailLayanan,
                arguments: layanan,
              );

              if (!context.mounted) {
                return;
              }

              if (hasil is String) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(hasil),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }
}

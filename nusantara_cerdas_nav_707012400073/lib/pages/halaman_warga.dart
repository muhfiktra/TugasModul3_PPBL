import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/favorit_model.dart';

class HalamanWarga extends StatelessWidget {
  const HalamanWarga({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Warga')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // =========================
          // INFORMASI WARGA
          // =========================
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 28,
                    child: Icon(Icons.person, size: 30),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Warga Nusantara',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        const Text('Akses layanan publik dengan lebih mudah.'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // =========================
          // LAYANAN FAVORIT
          // =========================
          Consumer<FavoritModel>(
            builder: (context, favoritModel, child) {
              final daftarFavorit = favoritModel.favorit.toList();

              // Jika belum ada layanan favorit
              if (daftarFavorit.isEmpty) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.star_outline,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Layanan Favorit',
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Column(
                              children: [
                                Icon(Icons.star_border, size: 48),
                                SizedBox(height: 8),
                                Text('Belum ada layanan favorit.'),
                                SizedBox(height: 4),
                                Text(
                                  'Tandai layanan dengan ikon bintang '
                                  'pada halaman Layanan.',
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              // Jika sudah ada layanan favorit
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Layanan Favorit',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      Text(
                        '${daftarFavorit.length} layanan ditandai sebagai favorit',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),

                      const SizedBox(height: 12),

                      const Divider(),

                      // Menampilkan semua layanan favorit
                      ...daftarFavorit.map((namaLayanan) {
                        return ListTile(
                          contentPadding: EdgeInsets.zero,

                          leading: CircleAvatar(
                            child: Icon(
                              Icons.star,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),

                          title: Text(
                            namaLayanan,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),

                          subtitle: const Text('Layanan publik favorit'),

                          trailing: IconButton(
                            tooltip: 'Hapus dari favorit',
                            icon: const Icon(Icons.star),
                            onPressed: () {
                              context.read<FavoritModel>().batalTandai(
                                namaLayanan,
                              );
                            },
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 16),

          // =========================
          // INFORMASI
          // =========================
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Informasi',
                    style: Theme.of(context).textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  const ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.info_outline),
                    title: Text('Layanan Publik'),
                    subtitle: Text(
                      'Temukan berbagai layanan yang tersedia '
                      'untuk warga.',
                    ),
                  ),
                  const ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.notifications_none),
                    title: Text('Informasi Warga'),
                    subtitle: Text('Dapatkan informasi terkait layanan kota.'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

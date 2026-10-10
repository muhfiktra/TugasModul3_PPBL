import 'package:flutter/material.dart';

class HalamanBeranda extends StatelessWidget {
  const HalamanBeranda({super.key});

  final List<Map<String, dynamic>> pilar = const [
    {
      'nama': 'Smart Governance',
      'icon': Icons.account_balance,
      'deskripsi': 'Tata kelola pemerintahan yang cerdas dan transparan.',
    },
    {
      'nama': 'Smart Branding',
      'icon': Icons.campaign,
      'deskripsi': 'Meningkatkan citra dan daya tarik kota.',
    },
    {
      'nama': 'Smart Economy',
      'icon': Icons.trending_up,
      'deskripsi': 'Mendukung pertumbuhan ekonomi masyarakat.',
    },
    {
      'nama': 'Smart Living',
      'icon': Icons.home,
      'deskripsi': 'Meningkatkan kualitas hidup masyarakat.',
    },
    {
      'nama': 'Smart Society',
      'icon': Icons.groups,
      'deskripsi': 'Membangun masyarakat yang aktif dan inklusif.',
    },
    {
      'nama': 'Smart Environment',
      'icon': Icons.eco,
      'deskripsi': 'Mewujudkan lingkungan kota yang berkelanjutan.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.location_city, size: 55),
                const SizedBox(height: 12),
                Text(
                  'Nusantara Cerdas Mobile',
                  style: Theme.of(context).textTheme.headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Aplikasi layanan warga untuk mendukung pelayanan '
                  'publik dalam konsep Smart City.',
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 20),

        Text(
          'Enam Pilar Smart City',
          style: Theme.of(context).textTheme.titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 12),

        ...pilar.map(
          (item) => Card(
            child: ListTile(
              leading: CircleAvatar(child: Icon(item['icon'])),
              title: Text(
                item['nama'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(item['deskripsi']),
            ),
          ),
        ),
      ],
    );
  }
}

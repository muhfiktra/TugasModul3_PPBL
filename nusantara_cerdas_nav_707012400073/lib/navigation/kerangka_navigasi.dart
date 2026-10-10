import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/pengajuan_model.dart';
import '../pages/halaman_beranda.dart';
import '../pages/halaman_layanan.dart';
import '../pages/halaman_warga.dart';
import 'app_routes.dart';

class KerangkaNavigasi extends StatefulWidget {
  const KerangkaNavigasi({super.key});

  @override
  State<KerangkaNavigasi> createState() => _KerangkaNavigasiState();
}

class _KerangkaNavigasiState extends State<KerangkaNavigasi> {
  int _indeksTerpilih = 0;

  final List<Widget> _halaman = const [
    HalamanBeranda(),
    HalamanLayanan(),
    HalamanWarga(),
  ];

  final List<String> _judul = const ['Beranda', 'Layanan', 'Warga'];

  void _pilihTujuan(int indeks) {
    setState(() {
      _indeksTerpilih = indeks;
    });
  }

  @override
  Widget build(BuildContext context) {
    final lebarLayar = MediaQuery.of(context).size.width;
    final layarLebar = lebarLayar >= 600;

    return Scaffold(
      appBar: AppBar(title: Text(_judul[_indeksTerpilih])),

      drawer: _buatDrawer(),

      body: layarLebar ? _tataLetakLebar() : _halaman[_indeksTerpilih],

      bottomNavigationBar: layarLebar ? null : _buatBilahBawah(),
    );
  }

  Widget _buatBilahBawah() {
    return NavigationBar(
      selectedIndex: _indeksTerpilih,
      onDestinationSelected: _pilihTujuan,
      destinations: [
        const NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: 'Beranda',
        ),
        const NavigationDestination(
          icon: Icon(Icons.miscellaneous_services_outlined),
          selectedIcon: Icon(Icons.miscellaneous_services),
          label: 'Layanan',
        ),

        // Warga dengan badge jumlah pengajuan
        NavigationDestination(
          icon: const BadgePengajuan(icon: Icons.person_outline),
          selectedIcon: const BadgePengajuan(icon: Icons.person),
          label: 'Warga',
        ),
      ],
    );
  }

  Widget _tataLetakLebar() {
    return Row(
      children: [
        NavigationRail(
          selectedIndex: _indeksTerpilih,
          onDestinationSelected: _pilihTujuan,
          extended: true,
          destinations: [
            const NavigationRailDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: Text('Beranda'),
            ),
            const NavigationRailDestination(
              icon: Icon(Icons.miscellaneous_services_outlined),
              selectedIcon: Icon(Icons.miscellaneous_services),
              label: Text('Layanan'),
            ),

            // Warga dengan badge jumlah pengajuan
            const NavigationRailDestination(
              icon: BadgePengajuan(icon: Icons.person_outline),
              selectedIcon: BadgePengajuan(icon: Icons.person),
              label: Text('Warga'),
            ),
          ],
        ),

        const VerticalDivider(width: 1),

        Expanded(child: _halaman[_indeksTerpilih]),
      ],
    );
  }

  NavigationDrawer _buatDrawer() {
    return NavigationDrawer(
      selectedIndex: _indeksTerpilih,
      onDestinationSelected: (indeks) {
        if (indeks < 3) {
          setState(() {
            _indeksTerpilih = indeks;
          });

          Navigator.pop(context);
        }
      },
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(28, 24, 16, 12),
          child: Text(
            'Nusantara Cerdas',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),

        const NavigationDrawerDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: Text('Beranda'),
        ),

        const NavigationDrawerDestination(
          icon: Icon(Icons.miscellaneous_services_outlined),
          selectedIcon: Icon(Icons.miscellaneous_services),
          label: Text('Layanan'),
        ),

        const NavigationDrawerDestination(
          icon: Icon(Icons.person_outline),
          selectedIcon: Icon(Icons.person),
          label: Text('Warga'),
        ),

        const Padding(
          padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
          child: Divider(),
        ),

        ListTile(
          leading: const Icon(Icons.settings_outlined),
          title: const Text('Pengaturan Kota'),
          onTap: () {
            Navigator.pop(context);

            Navigator.pushNamed(context, AppRoutes.pengaturanKota);
          },
        ),

        ListTile(
          leading: const Icon(Icons.info_outline),
          title: const Text('Tentang Aplikasi'),
          onTap: () {
            Navigator.pop(context);

            Navigator.pushNamed(context, AppRoutes.tentang);
          },
        ),

        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Keluar'),
          onTap: () {
            Navigator.pop(context);

            Navigator.pushNamed(context, AppRoutes.keluar);
          },
        ),
      ],
    );
  }
}

// ======================================================
// BADGE JUMLAH PENGAJUAN
// ======================================================

class BadgePengajuan extends StatelessWidget {
  const BadgePengajuan({super.key, required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final totalPengajuan = context.select<PengajuanModel, int>(
      (model) => model.totalPengajuan,
    );

    return Badge(
      isLabelVisible: totalPengajuan > 0,
      label: Text('$totalPengajuan'),
      child: Icon(icon),
    );
  }
}

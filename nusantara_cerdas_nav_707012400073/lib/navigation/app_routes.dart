import 'package:flutter/material.dart';

import '../pages/halaman_detail_layanan.dart';
import '../pages/halaman_riwayat_laporan.dart';
import '../pages/halaman_pengaturan_kota.dart';
import '../pages/halaman_tentang.dart';
import '../pages/halaman_route_tidak_dikenal.dart';
import 'kerangka_navigasi.dart';

class AppRoutes {
  static const String beranda = '/';
  static const String detailLayanan = '/detail-layanan';
  static const String riwayatLaporan = '/riwayat-laporan';
  static const String pengaturanKota = '/pengaturan-kota';
  static const String tentang = '/tentang';
  static const String keluar = '/keluar';

  static Map<String, WidgetBuilder> daftarRoute() {
    return {
      beranda: (context) => const KerangkaNavigasi(),
      riwayatLaporan: (context) => const HalamanRiwayatLaporan(),
      pengaturanKota: (context) => const HalamanPengaturanKota(),
      tentang: (context) => const HalamanTentang(),
    };
  }

  static Route<dynamic>? bentukRoute(RouteSettings settings) {
    if (settings.name == detailLayanan) {
      return MaterialPageRoute(
        builder: (context) => const HalamanDetailLayanan(),
        settings: settings,
      );
    }

    if (settings.name == keluar) {
      return MaterialPageRoute(builder: (context) => const HalamanKeluar());
    }

    return null;
  }

  static Route<dynamic> routeTidakDikenal(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) =>
          HalamanRouteTidakDikenal(namaRoute: settings.name ?? 'null'),
    );
  }
}

class HalamanKeluar extends StatelessWidget {
  const HalamanKeluar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Keluar')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.logout, size: 80),
              const SizedBox(height: 20),
              const Text(
                'Keluar dari Nusantara Cerdas?',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              const Text(
                'Ini merupakan purwarupa aplikasi layanan warga.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              FilledButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Kembali ke Aplikasi'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

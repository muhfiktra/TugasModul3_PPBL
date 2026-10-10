import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/pengajuan_model.dart';

class HalamanDetailLayanan extends StatefulWidget {
  const HalamanDetailLayanan({super.key});

  @override
  State<HalamanDetailLayanan> createState() => _HalamanDetailLayananState();
}

class _HalamanDetailLayananState extends State<HalamanDetailLayanan> {
  bool _isSubmitting = false;

  Future<void> _ajukanPermohonan(
    BuildContext context,
    Map<String, String> layanan,
  ) async {
    setState(() {
      _isSubmitting = true;
    });

    // Simulasi proses pengiriman
    await Future.delayed(const Duration(seconds: 10));

    if (!mounted) return;

    // Simpan ke PengajuanModel
    context.read<PengajuanModel>().tambahPengajuan(layanan['nama']!);

    // Kembalikan nilai ke HalamanLayanan
    Navigator.pop(context, 'Permohonan ${layanan['nama']} berhasil diajukan.');
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;

    if (arguments is! Map<String, String>) {
      return Scaffold(
        appBar: AppBar(title: const Text('Detail Layanan')),
        body: const Center(child: Text('Data layanan tidak ditemukan.')),
      );
    }

    final layanan = arguments;
    final namaLayanan = layanan['nama'] ?? 'Layanan';
    final dinas = layanan['dinas'] ?? '-';
    final jam = layanan['jam'] ?? '-';
    final keterangan = layanan['keterangan'] ?? '-';

    return Scaffold(
      appBar: AppBar(title: const Text('Detail Layanan')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 32,
                    child: Icon(Icons.miscellaneous_services, size: 32),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    namaLayanan,
                    style: Theme.of(context).textTheme.headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 16),

                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.business),
                    title: const Text('Dinas'),
                    subtitle: Text(dinas),
                  ),

                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.access_time),
                    title: const Text('Jam Layanan'),
                    subtitle: Text(jam),
                  ),

                  const Divider(),

                  const SizedBox(height: 8),

                  Text(
                    'Keterangan',
                    style: Theme.of(context).textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),

                  Text(keterangan),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: _isSubmitting
                  ? null
                  : () => _ajukanPermohonan(context, layanan),
              icon: _isSubmitting
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.send),
              label: Text(_isSubmitting ? 'Mengirim...' : 'Ajukan Permohonan'),
            ),
          ),
        ],
      ),
    );
  }
}

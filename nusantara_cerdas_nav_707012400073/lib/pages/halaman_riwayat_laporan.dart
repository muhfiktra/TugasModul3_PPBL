import 'package:flutter/material.dart';

class HalamanRiwayatLaporan extends StatelessWidget {
  const HalamanRiwayatLaporan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Riwayat Laporan')),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Card(
            child: ListTile(
              leading: CircleAvatar(child: Icon(Icons.report_problem_outlined)),
              title: Text('Lampu Jalan Rusak'),
              subtitle: Text('Status: Sedang Diproses'),
              trailing: Icon(Icons.chevron_right),
            ),
          ),

          Card(
            child: ListTile(
              leading: CircleAvatar(child: Icon(Icons.delete_outline)),
              title: Text('Sampah Menumpuk'),
              subtitle: Text('Status: Selesai'),
              trailing: Icon(Icons.chevron_right),
            ),
          ),

          Card(
            child: ListTile(
              leading: CircleAvatar(child: Icon(Icons.traffic)),
              title: Text('Rambu Jalan Rusak'),
              subtitle: Text('Status: Menunggu'),
              trailing: Icon(Icons.chevron_right),
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Membuat laporan baru')));
        },
        child: const Icon(Icons.add),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Mencari laporan')),
                );
              },
              icon: const Icon(Icons.search),
            ),

            IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Memfilter laporan')),
                );
              },
              icon: const Icon(Icons.filter_list),
            ),

            const SizedBox(width: 40),

            IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Mengurutkan laporan')),
                );
              },
              icon: const Icon(Icons.sort),
            ),

            IconButton(
              onPressed: () {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Menu laporan')));
              },
              icon: const Icon(Icons.more_vert),
            ),
          ],
        ),
      ),
    );
  }
}

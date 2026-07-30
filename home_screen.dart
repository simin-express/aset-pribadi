import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/asset.dart';
import 'add_asset_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Asset> _daftarAsset = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _muatAsset();
  }

  Future<void> _muatAsset() async {
    setState(() => _loading = true);
    final data = await DatabaseHelper.instance.ambilSemuaAsset();
    setState(() {
      _daftarAsset = data;
      _loading = false;
    });
  }

  IconData _iconKategori(String kategori) {
    switch (kategori) {
      case 'Kendaraan':
        return Icons.directions_car;
      case 'Elektronik':
        return Icons.tv;
      case 'Dokumen':
        return Icons.description;
      case 'Perabotan':
        return Icons.chair;
      default:
        return Icons.inventory_2;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Aset Saya')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _daftarAsset.isEmpty
              ? const Center(child: Text('Belum ada aset. Tambahkan yuk!'))
              : ListView.builder(
                  itemCount: _daftarAsset.length,
                  itemBuilder: (context, index) {
                    final asset = _daftarAsset[index];
                    return ListTile(
                      leading: Icon(_iconKategori(asset.kategori)),
                      title: Text(asset.nama),
                      subtitle: Text(
                        '${asset.kategori} • Dibeli ${asset.tanggalBeli.day}/${asset.tanggalBeli.month}/${asset.tanggalBeli.year}',
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final berhasil = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddAssetScreen()),
          );
          if (berhasil == true) {
            _muatAsset();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/asset.dart';

class AddAssetScreen extends StatefulWidget {
  const AddAssetScreen({super.key});

  @override
  State<AddAssetScreen> createState() => _AddAssetScreenState();
}

class _AddAssetScreenState extends State<AddAssetScreen> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _nomorController = TextEditingController();
  final _catatanController = TextEditingController();

  String _kategori = 'Kendaraan';
  DateTime _tanggalBeli = DateTime.now();

  final List<String> _daftarKategori = [
    'Kendaraan',
    'Elektronik',
    'Dokumen',
    'Perabotan',
    'Lainnya',
  ];

  Future<void> _pilihTanggal() async {
    final tanggal = await showDatePicker(
      context: context,
      initialDate: _tanggalBeli,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (tanggal != null) {
      setState(() => _tanggalBeli = tanggal);
    }
  }

  Future<void> _simpanAsset() async {
    if (_formKey.currentState!.validate()) {
      final asset = Asset(
        nama: _namaController.text,
        kategori: _kategori,
        nomorIdentitas: _nomorController.text,
        tanggalBeli: _tanggalBeli,
        catatan: _catatanController.text,
      );

      await DatabaseHelper.instance.tambahAsset(asset);

      if (mounted) {
        Navigator.pop(context, true); // true = beri tanda "berhasil"
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Aset')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(labelText: 'Nama Aset'),
                validator: (value) => (value == null || value.isEmpty)
                    ? 'Nama wajib diisi'
                    : null,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: _kategori,
                decoration: const InputDecoration(labelText: 'Kategori'),
                items: _daftarKategori
                    .map((k) => DropdownMenuItem(value: k, child: Text(k)))
                    .toList(),
                onChanged: (value) => setState(() => _kategori = value!),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _nomorController,
                decoration: const InputDecoration(
                  labelText: 'Nomor (plat/seri) - opsional',
                ),
              ),
              const SizedBox(height: 12),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'Tanggal Beli: ${_tanggalBeli.day}/${_tanggalBeli.month}/${_tanggalBeli.year}',
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: _pilihTanggal,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _catatanController,
                decoration:
                    const InputDecoration(labelText: 'Catatan - opsional'),
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _simpanAsset,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text('Simpan Aset'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

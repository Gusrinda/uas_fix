import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uas/addDataFootballClub.dart';
import 'package:http/http.dart' as http;
import 'package:uas/model/klub.dart';

class footballClub extends StatefulWidget {
  const footballClub({super.key});

  @override
  State<footballClub> createState() => _footballClubState();
}

class _footballClubState extends State<footballClub> {
  final TextEditingController _searchController = TextEditingController();

  List<Club> _data = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text("Form Football Club",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          backgroundColor: const Color.fromARGB(255, 0, 43, 78)),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        fetchData();
                      },
                    ),
                    prefixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });

                        searchClub(_searchController.text);
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: _data.length ?? 0,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: ((context, index) {
                        Club dataClub = _data[index];

                        return Card(
                          elevation: 10,
                          child: ListTile(
                              onTap: () {
                                _showDialog(context, dataClub);
                              },
                              leading: Icon(Icons.account_circle),
                              title: Text(dataClub.namaKlub),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GestureDetector(
                                      onTap: () async {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  addDataFootballClub(
                                                    dataClub: dataClub,
                                                  )),
                                        ).then((value) => {fetchData()});
                                      },
                                      child: Icon(Icons.edit)),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  GestureDetector(
                                      onTap: () async {
                                        _showConfirmationDialog(
                                            context,
                                            dataClub
                                                .id); // Ganti dengan ID yang sesuai
                                      },
                                      child: Icon(Icons.delete))
                                ],
                              )),
                        );
                      }),
                    ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => addDataFootballClub(
                        dataClub: null,
                      )),
            ).then((value) => {fetchData()});
          },
          child: Icon(
            Icons.add,
          )),
    );
  }

  //Dialog konfirmasi hapus
  void _showConfirmationDialog(BuildContext context, String idToDelete) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Konfirmasi Hapus"),
          content: Text("Apakah Anda yakin ingin menghapus data ini?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: Text("Batal"),
            ),
            TextButton(
              onPressed: () {
                deleteKlub(idToDelete);
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: Text("Hapus"),
            ),
          ],
        );
      },
    );
  }

  //Function Untuk get data dari Mysql
  Future<void> fetchData() async {
    final response = await http
        .get(Uri.parse('http://192.168.0.110/uas/lib/php/read_klub.php'));

    if (response.statusCode == 200) {
      setState(() {
        List<dynamic> jsonList = json.decode(response.body);

        print("DATA RESPONSE => ${jsonList}");

        setState(() {
          _data = jsonList.map((json) => Club.fromJson(json)).toList();

          isLoading = false;
        });
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  //Function untuk delete data
  void deleteKlub(String idToDelete) async {
    final response = await http.post(
      Uri.parse('http://192.168.0.110/uas/lib/php/delete_klub.php'),
      body: {
        'idToDelete': idToDelete,
      },
    );

    if (response.statusCode == 200) {
      print('Berhasil menghapus data klub: ${response.body}');

      fetchData();
    } else {
      print('Gagal menghapus data klub');
    }
  }

  //Function untuk search by nama supporter
  void searchClub(String nama) async {
    final response = await http.post(
      Uri.parse('http://192.168.0.110/uas/lib/php/search_klub.php'),
      body: {'nama': nama},
    );

    if (response.statusCode == 200) {
      // Mendapatkan hasil pencarian dari server
      List<dynamic> hasilPencarian = json.decode(response.body);

      print('Hasil Pencarian:');
      for (var club in hasilPencarian) {
        setState(() {
          _data = hasilPencarian.map((json) => Club.fromJson(json)).toList();

          isLoading = false;
        });
      }
    } else {
      print('Gagal melakukan pencarian supporter');
      isLoading = false;
    }
  }

  //Function Untuk View Detail tanpa edit
  Future<void> _showDialog(BuildContext context, Club dataClub) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Data Supporter'),
          content: Container(
            width: double.maxFinite,
            child: Column(
              children: [
                ListTile(
                  leading: Text("Nama"),
                  title: Text(dataClub.namaKlub),
                ),
                ListTile(
                  leading: Text("Kondisi"),
                  title: Text(dataClub.kondisiKlub == '0'
                      ? 'Baik'
                      : dataClub.kondisiKlub == '1'
                          ? 'Tidak Baik'
                          : 'Bangkrut'),
                ),
                ListTile(
                  leading: Text("Kota"),
                  title: Text(dataClub.namaKlub),
                ),
                ListTile(
                  leading: Text("Tanggal Berdiri"),
                  title: Text(dataClub.tglBerdiri),
                ),
                ListTile(
                  leading: Text("Peringkat"),
                  title: Text(dataClub.peringkat),
                ),
                ListTile(
                  leading: Text("Harga"),
                  title: Text(
                      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ')
                          .format(int.tryParse(dataClub.hargaKlub) ?? 0)),
                ),
                SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  //Function Update
  // Future<void> _updateSupporter() async {
  //   // Membuat request HTTP
  //   var request = http.MultipartRequest(
  //     'POST',
  //     Uri.parse('http://192.168.0.110/uas/lib/php/update_supporter.php'),
  //   );

  //   // Menambahkan data ke dalam request
  //   request.fields['id'] = widget.dataSupporter?.id;
  //   request.fields['nama'] = nameController.text;
  //   request.fields['alamat'] = addressController.text;
  //   request.fields['tgl_daftar'] =
  //       DateFormat('yyyy-MM-dd').format(selectDate).toString();
  //   request.fields['no_telpon'] = phoneController.text;

  //   if (image != null) {
  //     print(" PATH IMAGE : ${image?.path}");

  //     var pic = await http.MultipartFile.fromPath('image', image!.path);

  //     print("PIC GAMBAR ${pic.filename}");

  //     request.files.add(pic);
  //   }

  //   // Mengirim request dan menanggapi hasil
  //   try {
  //     var response = await request.send();
  //     if (response.statusCode == 200) {
  //       print(
  //           'Berhasil update data supporter: ${await response.stream.bytesToString()}');
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('Berhasil update data.'),
  //           duration: Duration(seconds: 2), // Durasi tampilan Snackbar
  //         ),
  //       );
  //       Navigator.pop(context);
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('Gagal update data.'),
  //           duration: Duration(seconds: 2), // Durasi tampilan Snackbar
  //         ),
  //       );
  //       print('Gagal update data supporter');
  //     }
  //   } catch (error) {
  //     print('Error: $error');
  //   }
  // }
}

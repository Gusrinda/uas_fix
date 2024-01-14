import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mysql1/mysql1.dart';
import 'package:uas/addDataSupporter.dart';
import 'package:uas/base_url.dart';
import 'package:uas/model/supporter.dart';
import 'package:uas/mysql.dart';

class supporter extends StatefulWidget {
  const supporter({super.key});

  @override
  State<supporter> createState() => _supporterState();
}

class _supporterState extends State<supporter> {
  final TextEditingController _searchController = TextEditingController();

  List<Supporter> _data = [];
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
        title: Text("Form Supporter",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color.fromARGB(255, 0, 43, 78),
      ),
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

                        searchSupporter(_searchController.text);
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
                        Supporter dataSupporter = _data[index];

                        return Card(
                          elevation: 10,
                          child: ListTile(
                              leading: Icon(Icons.account_circle),
                              title: Text(dataSupporter.nama),
                              onTap: () {
                                _showDialog(context, dataSupporter);
                              },
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  addDataSupporter(
                                                    dataSupporter:
                                                        dataSupporter,
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
                                            dataSupporter.id
                                                .toString()); // Ganti dengan ID yang sesuai
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
                  builder: (context) => addDataSupporter(
                        dataSupporter: null,
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
                deleteSupporter(idToDelete);
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
        .get(Uri.parse('${baseUrl}read_supporter.php'));

    if (response.statusCode == 200) {
      setState(() {
        List<dynamic> jsonList = json.decode(response.body);

        print("DATA RESPONSE => ${jsonList}");

        setState(() {
          _data = jsonList.map((json) => Supporter.fromJson(json)).toList();

          isLoading = false;
        });
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  //Function untuk delete data
  void deleteSupporter(String idToDelete) async {
    final response = await http.post(
      Uri.parse('${baseUrl}delete_support.php'),
      body: {
        'idToDelete': idToDelete,
      },
    );

    if (response.statusCode == 200) {
      print('Berhasil menghapus data supporter: ${response.body}');

      fetchData();
    } else {
      print('Gagal menghapus data supporter');
    }
  }

  //Function untuk search by nama supporter
  void searchSupporter(String nama) async {
    final response = await http.post(
      Uri.parse('${baseUrl}search_support.php'),
      body: {'nama': nama},
    );

    if (response.statusCode == 200) {
      // Mendapatkan hasil pencarian dari server
      List<dynamic> hasilPencarian = json.decode(response.body);
      // List<Map<String, dynamic>> hasilPencarian = json.decode(response.body);

      // Menampilkan hasil pencarian
      print('Hasil Pencarian:');
      for (var supporter in hasilPencarian) {
        setState(() {
          _data =
              hasilPencarian.map((json) => Supporter.fromJson(json)).toList();

          isLoading = false;
        });
      }
    } else {
      print('Gagal melakukan pencarian supporter');
      isLoading = false;
    }
  }

  //Function Untuk View Detail tanpa edit
  Future<void> _showDialog(
      BuildContext context, Supporter dataSupporter) async {
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
                  title: Text(dataSupporter.nama),
                ),
                ListTile(
                  leading: Text("Alamat"),
                  title: Text(dataSupporter.alamat),
                ),
                ListTile(
                  leading: Text("Telepon"),
                  title: Text(dataSupporter.noTelpon),
                ),
                ListTile(
                  leading: Text("Tanggal Terdaftar"),
                  title: Text(dataSupporter.tglDaftar),
                ),
                SizedBox(
                  height: 12,
                ),
                Text("Foto Supporter"),
                SizedBox(
                  height: 6,
                ),
                Image.network(dataSupporter.foto != ''
                    ? "http://192.168.0.110/uas/uploads/${dataSupporter.foto}"
                    : 'https://dpglaw.co.uk/wp-content/uploads/2016/03/DPGexpertise_Football-supporters.jpg')
              ],
            ),
          ),
        );
      },
    );
  }

}

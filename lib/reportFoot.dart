import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:uas/base_url.dart';
import 'package:uas/model/klub.dart';

class reportFoot extends StatefulWidget {
  const reportFoot({super.key});

  @override
  State<reportFoot> createState() => _reportFootState();
}

class _reportFootState extends State<reportFoot> {
  List<Club> _daftarClub = [];
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
          title: Text("Tabel Report Football Club",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          backgroundColor: const Color.fromARGB(255, 0, 43, 78)),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('Club Name')),
                    DataColumn(label: Text('Date')),
                    DataColumn(label: Text('Club Conditions')),
                    DataColumn(label: Text('Club City')),
                    DataColumn(label: Text('Ranking')),
                    DataColumn(label: Text('Club Price')),
                  ],
                  rows: _daftarClub.map((e) {
                    return DataRow(cells: [
                      DataCell(Text(e.namaKlub)),
                      DataCell(Text(e.tglBerdiri)),
                      DataCell(Text(e.kondisiKlub == '0'
                          ? 'Baik'
                          : e.kondisiKlub == '1'
                              ? 'Tidak Baik'
                              : 'Bangkrut')),
                      DataCell(Text(e.kotaKlub)),
                      DataCell(Text(e.peringkat)),
                      DataCell(Text(
                          NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ')
                              .format(int.tryParse(e.hargaKlub) ?? 0))),
                    ]);
                  }).toList(),
                ),
              ),
            ),
    );
  }

  //Function Untuk get data dari Mysql
  Future<void> fetchData() async {
    final response = await http
        .get(Uri.parse('${baseUrl}read_klub.php'));

    if (response.statusCode == 200) {
      setState(() {
        List<dynamic> jsonList = json.decode(response.body);

        print("DATA RESPONSE => ${jsonList}");

        setState(() {
          _daftarClub = jsonList.map((json) => Club.fromJson(json)).toList();
          isLoading = false;
        });
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  //Randomize nama kota
  String getNamaKota(int index) {
    switch (index) {
      case 0:
        return 'Surabaya';
      case 1:
        return 'Malang';
      case 2:
        return 'Sidoarjo';
      case 3:
        return 'Mojokerto';
      case 4:
        return 'Pasuruan';
      case 5:
        return 'Probolinggo';
      default:
        return 'Tidak Diketahui';
    }
  }
}

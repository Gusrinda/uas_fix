import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uas/base_url.dart';
import 'package:uas/model/supporter.dart';

class reportSupp extends StatefulWidget {
  const reportSupp({super.key});

  @override
  State<reportSupp> createState() => _reportSuppState();
}

class _reportSuppState extends State<reportSupp> {
  //Buat menampung daftar supporter !
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
          title: Text("Table Report Supporter",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          backgroundColor: const Color.fromARGB(255, 0, 43, 78)),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.height,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: [
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Text('Address')),
                      DataColumn(label: Text('Date')),
                      DataColumn(label: Text('No Telepon')),
                    ],
                    rows: _data.map((e) {
                      return DataRow(cells: [
                        DataCell(Text(e.nama)),
                        DataCell(Text(e.alamat)),
                        DataCell(Text(e.tglDaftar)),
                        DataCell(Text(e.noTelpon)),
                      ]);
                    }).toList(),
                  ),
                ),
              ),
            ),
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

}

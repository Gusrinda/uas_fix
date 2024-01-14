import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:uas/base_url.dart';
import 'package:uas/model/klub.dart';

class addDataFootballClub extends StatefulWidget {
  const addDataFootballClub({Key? key, required this.dataClub})
      : super(key: key);

  final Club? dataClub;

  @override
  State<addDataFootballClub> createState() => _addDataFootballClubState();
}

class _addDataFootballClubState extends State<addDataFootballClub> {
  TextEditingController nameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  DateTime selectDate = DateTime.now();
  String groupValue = "Baik";

  List<String> items1 = ['1-3', '4-6', '7-15', '16-18'];
  String selectedItem1 = '1-3';

  @override
  void initState() {
    if (widget.dataClub != null) {
      nameController.text = widget.dataClub?.namaKlub ?? '';
      cityController.text = widget.dataClub?.kotaKlub ?? '';
      priceController.text = widget.dataClub?.hargaKlub ?? '';

      print("KONDISI KLUB ${widget.dataClub?.kondisiKlub}");

      if (widget.dataClub?.kondisiKlub == '0') {
        groupValue = 'Baik';
      } else if (widget.dataClub?.kondisiKlub == '1') {
        groupValue = 'Tidak Baik';
      } else if (widget.dataClub?.kondisiKlub == '2') {
        groupValue = 'Bangkrut';
      }

      print("GROUP VALUE ${groupValue}");

      if (widget.dataClub!.peringkat.toString().length > 2) {
        selectedItem1 = widget.dataClub?.peringkat ?? '';
      } else {
        selectedItem1 = '1-3';
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text("Add Data Football Club",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          backgroundColor: const Color.fromARGB(255, 0, 43, 78)),
      body: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Club Name",
              ),
            ),
            TextField(
              controller: cityController,
              decoration: InputDecoration(
                labelText: "Club City",
              ),
            ),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Club Prices",
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              children: [
                Expanded(
                  child: Text(DateFormat('yyyy-MM-dd').format(selectDate)),
                ),
                SizedBox(width: 10.0),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(20, 35), // Adjust the button size
                  ),
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                      initialDate: selectDate,
                    ).then((value) {
                      setState(() {
                        selectDate = value!;
                      });
                    });
                  },
                  icon: Icon(Icons.calendar_today),
                  label: Text("Date"),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Club Conditions",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Radio(
                    value: "Baik",
                    groupValue: groupValue,
                    onChanged: ((value) {
                      setState(() {
                        groupValue = value!;
                      });
                    })),
                Text("Baik"),
                Radio(
                    value: "Tidak Baik",
                    groupValue: groupValue,
                    onChanged: ((value) {
                      setState(() {
                        groupValue = value!;
                      });
                    })),
                Text("Tidak Baik"),
                Radio(
                    value: "Bangkrut",
                    groupValue: groupValue,
                    onChanged: ((value) {
                      setState(() {
                        groupValue = value!;
                      });
                    })),
                Text("Bangkrut"),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Club Ranking",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            DropdownButton(
              value: selectedItem1,
              onChanged: (newValue) {
                setState(() {
                  selectedItem1 = newValue.toString();
                });
              },
              items: items1.map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: (() async {
                  if (nameController.text.isEmpty ||
                      cityController.text.isEmpty ||
                      priceController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Data belum lengkap.'),
                        duration:
                            Duration(seconds: 2), // Durasi tampilan Snackbar
                      ),
                    );
                    return;
                  }
                  if (widget.dataClub != null) {
                    await updateClub();
                  } else {
                    await _addClub();
                  }
                }),
                child: Text(
                    widget.dataClub != null ? 'Update Data' : "Save Data")),
          ],
        ),
      )),
    );
  }

  //Function Create
  Future<void> _addClub() async {
    int kondisiKlub = 0;

    switch (groupValue) {
      case 'Baik':
        kondisiKlub = 0;
        break;
      case 'Tidak Baik':
        kondisiKlub = 1;
        break;
      case 'Bangkrut':
        kondisiKlub = 2;
        break;
      default:
        kondisiKlub = 0;
        break;
    }

    print("Kondisi klub : ${cityController.text}");

    final response = await http.post(
      Uri.parse('${baseUrl}create_klub.php'),
      body: {
        'nama_klub': nameController.text,
        'tgl_berdiri': DateFormat('yyyy-MM-dd').format(selectDate).toString(),
        'kondisi_klub': kondisiKlub.toString(),
        'kota_klub': cityController.text,
        'peringkat': selectedItem1,
        'harga_klub': priceController.text,
      },
    );

    if (response.statusCode == 200) {
      print('Berhasil menambahkan data klub: ${response.body}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Berhasil Upload Data.'),
          duration: Duration(seconds: 2), // Durasi tampilan Snackbar
        ),
      );
      Navigator.pop(context);
    } else {
      print('Gagal menambahkan data klub');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal Create Data.'),
          duration: Duration(seconds: 2), // Durasi tampilan Snackbar
        ),
      );
      return;
    }
  }

  Future<void> updateClub() async {
    int kondisiKlub = 0;

    switch (groupValue) {
      case 'Baik':
        kondisiKlub = 0;
        break;
      case 'Tidak Baik':
        kondisiKlub = 1;
        break;
      case 'Bangkrut':
        kondisiKlub = 2;
        break;
      default:
        kondisiKlub = 0;
        break;
    }

    print("Kondisi klub : ${cityController.text}");

    final response = await http.post(
      Uri.parse('${baseUrl}update_klub.php'),
      body: {
        'id': widget.dataClub?.id.toString(),
        'nama_klub': nameController.text,
        'tgl_berdiri': DateFormat('yyyy-MM-dd').format(selectDate).toString(),
        'kondisi_klub': kondisiKlub.toString(),
        'kota_klub': cityController.text,
        'peringkat': selectedItem1,
        'harga_klub': priceController.text,
      },
    );
    if (response.statusCode == 200) {
      print('Berhasil menambahkan data klub: ${response.body}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Berhasil Update Data.'),
          duration: Duration(seconds: 2), // Durasi tampilan Snackbar
        ),
      );
      Navigator.pop(context);
    } else {
      print('Gagal menambahkan data klub');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal Update Data.'),
          duration: Duration(seconds: 2), // Durasi tampilan Snackbar
        ),
      );
      return;
    }
  }
}

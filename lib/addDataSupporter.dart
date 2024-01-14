import 'dart:io';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mysql1/mysql1.dart';
import 'package:uas/base_url.dart';
import 'package:uas/model/supporter.dart';
import 'package:uas/mysql.dart';

class addDataSupporter extends StatefulWidget {
  const addDataSupporter({super.key, required this.dataSupporter});

  final Supporter? dataSupporter;

  @override
  State<addDataSupporter> createState() => _addDataSupporterState();
}

class _addDataSupporterState extends State<addDataSupporter> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  DateTime selectDate = DateTime.now();
  String? imageUrl;
  late String fileNameWithExtension;
  late String fileName;
  late String extension;
  List<int>? imageBytes;

  //Function Create
  Future<void> _showMessageBox() async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${baseUrl}create_supp.php'),
    );

    request.fields['nama'] = nameController.text;
    request.fields['alamat'] = addressController.text;
    request.fields['tgl_daftar'] =
        DateFormat('yyyy-MM-dd').format(selectDate).toString();
    request.fields['no_telpon'] = phoneController.text;

    if (image != null) {
      print(" PATH IMAGE : ${image?.path}");

      var pic = await http.MultipartFile.fromPath('image', image!.path);

      print("PIC GAMBAR ${pic.filename}");

      request.files.add(pic);
    }

    var response = await request.send();

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Berhasil upload data.'),
          duration: Duration(seconds: 2), // Durasi tampilan Snackbar
        ),
      );
      Navigator.pop(context);
    } else {
      // Gagal terhubung ke PHP
      print('Gagal terhubung ke PHP');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error upload data.'),
          duration: Duration(seconds: 2), // Durasi tampilan Snackbar
        ),
      );
      return;
    }
  }

  //Function Update
  Future<void> _updateSupporter() async {
    // Membuat request HTTP
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${baseUrl}update_supporter.php'),
    );

    // Menambahkan data ke dalam request
    request.fields['id'] = widget.dataSupporter?.id;
    request.fields['nama'] = nameController.text;
    request.fields['alamat'] = addressController.text;
    request.fields['tgl_daftar'] =
        DateFormat('yyyy-MM-dd').format(selectDate).toString();
    request.fields['no_telpon'] = phoneController.text;

    if (image != null) {
      print(" PATH IMAGE : ${image?.path}");

      var pic = await http.MultipartFile.fromPath('image', image!.path);

      print("PIC GAMBAR ${pic.filename}");

      request.files.add(pic);
    }

    // Mengirim request dan menanggapi hasil
    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        print(
            'Berhasil update data supporter: ${await response.stream.bytesToString()}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Berhasil update data.'),
            duration: Duration(seconds: 2), // Durasi tampilan Snackbar
          ),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal update data.'),
            duration: Duration(seconds: 2), // Durasi tampilan Snackbar
          ),
        );
        print('Gagal update data supporter');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.dataSupporter != null) {
        nameController.text = widget.dataSupporter?.nama ?? 'Nama';
        addressController.text = widget.dataSupporter?.alamat ?? 'Alamat';
        phoneController.text = widget.dataSupporter?.noTelpon ?? '081xxx';
        selectDate =
            DateTime.parse(widget.dataSupporter?.tglDaftar ?? '2024-01-01');
      }
    });
  }

  @override
  File? image;
  String? imageName;

  Future getImage() async {
    final ImagePicker picker = ImagePicker();

    final XFile? imagePicked =
        await picker.pickImage(source: ImageSource.gallery);

    final bytes = await imagePicked!.readAsBytes();
    setState(() {
      image = File(imagePicked.path);
      imageName = imagePicked.name;
      imageUrl = imagePicked.path;
      imageBytes = bytes;
      fileNameWithExtension = imagePicked.path.split('/').last;
      fileName = fileNameWithExtension.split('.').first;
      extension = fileNameWithExtension.split('.').last;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text("Add Data Supporter",
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
                labelText: "Nama",
              ),
            ),
            TextField(
              controller: addressController,
              decoration: InputDecoration(
                labelText: "Alamat",
              ),
            ),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                labelText: "No. Telepon",
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
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(20, 35), // Adjust the button size
              ),
              onPressed: () async {
                await getImage();
              },
              icon: Icon(Icons.image),
              label: Text("Pick Image"),
            ),
            image != null
                ? Column(
                    children: [
                      Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        child: Image.file(
                          image!,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        'Image Name: $imageName',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  )
                : Container(),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  if (nameController.text.isEmpty ||
                      phoneController.text.isEmpty ||
                      addressController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Data tidak lengkap'),
                        duration:
                            Duration(seconds: 2), // Durasi tampilan Snackbar
                      ),
                    );
                    return;
                  }

                  if (image == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Gambar belum dipilih'),
                        duration:
                            Duration(seconds: 2), // Durasi tampilan Snackbar
                      ),
                    );
                    return;
                  }

                  if (widget.dataSupporter != null) {
                    await _updateSupporter();
                  } else {
                    await _showMessageBox();
                  }
                },
                child: Text(widget.dataSupporter != null ? "Update" : "Add"))
          ],
        ),
      )),
    );
  }
}

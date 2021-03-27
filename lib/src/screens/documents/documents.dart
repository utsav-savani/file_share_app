// framework
import 'dart:async';
import 'dart:io';
import 'package:ext_storage/ext_storage.dart';
import 'package:file_sharing_appp/src/Widgets/custom_button_design.dart';
import 'package:flutter/material.dart';

// packages
import 'package:flutter_file_manager/flutter_file_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:simple_permissions/simple_permissions.dart';


@immutable
class MyDocsList extends StatefulWidget {
  @override
  _MyDocsListState createState() => _MyDocsListState();
}

class _MyDocsListState extends State<MyDocsList> {
  @override
  List<bool> _isChecked;
  Future future;
  @override
  void initState() {
    future = _files();
    super.initState();

  }
  Widget build(BuildContext context) {
    //SimplePermissions.requestPermission(Permission.ReadExternalStorage);
    SimplePermissions.requestPermission(Permission.WriteExternalStorage);
    return new MaterialApp(
      home: SafeArea(
        child: Scaffold(

            body: FutureBuilder(
              future: future, // a previously-obtained Future<String> or null
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Text('Press button to start.');
                  case ConnectionState.active:
                  case ConnectionState.waiting:
                    return Text('Awaiting result...');
                  case ConnectionState.done:
                    if (snapshot.hasError)
                      return Text('Error: ${snapshot.error}');
                    return snapshot.data != null
                        ?

                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  for(int i=0; i < _isChecked.length;i++)
                                  {
                                    setState(() {
                                      _isChecked[i] = true;
                                    });
                                  }
                                },
                                child: CustomTextReg(
                                  size: MediaQuery.of(context).size * 0.6,
                                  text: "Select All",

                                  color: Colors.yellow,
                                ),
                              ),
                              CustomTextReg(
                                size: MediaQuery.of(context).size * 0.6,
                                text: "Selected",


                              ),
                              CustomTextReg(
                                size: MediaQuery.of(context).size * 0.6,
                                text: "Cancel",

                                color: Colors.yellow,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height*0.9,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) => Card(
                                  child: CheckboxListTile(

                                    title:

                                    Row(
                                      children: [
                                        SvgPicture.asset("assets/icons/documents.svg",height: 40,),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                            snapshot.data[index],style: TextStyle(
                                          fontSize: 12.0
                                        ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                    value: _isChecked[index],
                                    onChanged: (val) {
                                      setState(
                                            () {
                                          _isChecked[index] = val;
                                        },
                                      );
                                    },



                                  ))),
                        ),
                      ],
                    )
                        : Center(
                      child: Text("Nothing!"),
                    );
                }
                return null; // unreachable
              },
            )),
      ),
    );
  }

  _files() async {

    // var path = await ExtStorage.getExternalStorageDirectory();
    var path = await ExtStorage.getExternalStoragePublicDirectory(ExtStorage.DIRECTORY_DOWNLOADS);
    var path0 = await ExtStorage.getExternalStorageDirectory();

    print(path);  // /storage/emulated/0/Pictures
    FileManager fm = new FileManager(
        root: Directory(path)
    );
    var files = await fm.filesTree(
        extensions: ["doc","pdf"]
    );
    var data;
    List<String> datag = [];
    print("data is  ${files[0].absolute}");
    for(var i = 0;i<files.length;i++) {
      data = files[i].toString().split('/');
      datag.add(data.last);
    }
    _isChecked = List<bool>.filled(datag.length, false);
    return datag;
  }
}
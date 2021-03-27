// framework
import 'dart:async';
import 'dart:io';
import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/material.dart';

// packages
import 'package:flutter_file_manager/flutter_file_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:simple_permissions/simple_permissions.dart';



class MyMessangerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //SimplePermissions.requestPermission(Permission.ReadExternalStorage);
    SimplePermissions.requestPermission(Permission.WriteExternalStorage);
    return new MaterialApp(
      home: Scaffold(

          body: FutureBuilder(
            future: _files(), // a previously-obtained Future<String> or null
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Text('Press button to start.');
                case ConnectionState.active:
                case ConnectionState.waiting:
                  return Text('Awaiting result...');
                case ConnectionState.done:
                  if (snapshot.hasError)
                    return Text('Error: Loading data no such directory');
                    return Text('Error: Loading data no such directory');
                  return snapshot.data != null
                      ? ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) => Card(
                          child: ListTile(
                            leading: SvgPicture.asset("assets/icons/messanger_icon.svg",height: 40,),
                            title:

                            Text(
                                snapshot.data[index]),




                          )))
                      : Center(
                    child: Text("Nothing!"),
                  );
              }
              return null; // unreachable
            },
          )),
    );
  }


  _files() async {

    // var path = await ExtStorage.getExternalStorageDirectory();
    var path = await ExtStorage.getExternalStoragePublicDirectory(ExtStorage.DIRECTORY_MUSIC);
    var path0 = await ExtStorage.getExternalStorageDirectory();

    print(path);  // /storage/emulated/0/Pictures
    FileManager fm = new FileManager(
        root: Directory(path0 +"/Messanger/")
    );
    var files = await fm.filesTree(

    );
    var data;
    List<String> datag = [];
    print("data is  ${files[0].absolute}");
    for(var i = 0;i<files.length;i++) {
      data = files[i].toString().split('/');
      datag.add(data.last);
    }
    return datag;
  }

}
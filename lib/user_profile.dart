import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key,}) : super(key: key);


  @override
  State<UserProfile> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<UserProfile> {

  final int _selectedIndex = 0;
  File? image;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imgTemporary = File(image.path);
      setState(() {
        this.image = imgTemporary;
      });
    } on PlatformException catch (e){
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF4DD0E1),
                  Color(0xFF80DEEA),
                  Color(0xFFB2EBF2),
                  Color(0xFFE0F7FA),
                ])),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text('User Profile',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {},
            ),
            toolbarHeight: 50,
            elevation: 0.5,
            backgroundColor: const Color(0xFF00ACC1),
            shadowColor: const Color(0xFF00838F),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50)
                )
            ),
          ),
          body: Container(
            padding: const EdgeInsets.only(left: 15, top: 20, right:15),
            child: ListView(
              children: [
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.cyanAccent,
                        child: ClipOval(
                          child: SizedBox(
                            width: 130.0,
                            height: 130.0,
                            child: image != null ? ClipOval(
                                child: Image.file(image!,
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.cover,))
                                : const Image(image: AssetImage('asset/avatar.png'), height: 200, width: 200,),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                 Column(
                    children: const [
                      ListTile(
                        tileColor: Color(0xFFB2EBF2),
                        leading: Icon(Icons.person, size: 35,),
                        title: Text('Name',
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
                        subtitle: Text('Cardo Dalisay',
                            style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14)),
                        shape: BeveledRectangleBorder(
                            side: BorderSide(color: Color(0xFF0097A7), width: 2.0),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.elliptical(25, 50)
                            )
                        ),
                        contentPadding: EdgeInsets.only(left: 30),
                      ),
                      SizedBox(height: 20),
                      ListTile(
                        tileColor: Color(0xFFB2EBF2),
                          leading: Icon(Icons.mail, size: 35,),
                          title: Text('Email',
                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
                          subtitle: Text('123123@gmail.com',
                              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14)),
                          shape: BeveledRectangleBorder(
                              side: BorderSide(color: Color(0xFF0097A7), width: 2.0),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.elliptical(25, 50)
                              )
                          ),
                        contentPadding: EdgeInsets.only(left: 30),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.camera_alt),
                label: 'Camera',
              ),
              BottomNavigationBarItem(icon: Icon(Icons.image), label: 'Gallery', ),
            ],
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white,
            onTap: (int index) async {
              if(index == _selectedIndex) {
                PermissionStatus cameraStatus = await Permission.camera.request();
                if (cameraStatus == PermissionStatus.granted) {
                  pickImage(ImageSource.camera);
                } else if (cameraStatus == PermissionStatus.denied) {
                  return;
                }
              }else{
                PermissionStatus galleryStatus = await Permission.storage.request();
                if (galleryStatus == PermissionStatus.granted) {
                  pickImage(ImageSource.gallery);
                } else if (galleryStatus == PermissionStatus.denied) {
                  return;
                }
              }
            },
              backgroundColor: const Color(0xFF00ACC1),),
        )
    );
  }
}
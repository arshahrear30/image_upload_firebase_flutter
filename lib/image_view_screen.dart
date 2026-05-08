import 'package:firebase_storage/firebase_storage.dart'; // Firebase Storage ব্যবহার করার জন্য প্যাকেজ
import 'package:flutter/material.dart'; // Flutter UI ডিজাইন করার জন্য প্যাকেজ

class ImageScreen extends StatefulWidget {
  const ImageScreen({Key? key}) : super(key: key);

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {

  // Firebase Storage এর instance তৈরি করা হয়েছে
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  // ইমেজ URL গুলো রাখার জন্য List
  List<String> storageReference = [];

  // Firebase Storage থেকে সব ইমেজ আনার function
  Future getImages() async {

    // 'images' folder থেকে সব file list করা হচ্ছে
    await firebaseStorage.ref('images').listAll().then((value) async {

      // প্রতিটি image এর উপর loop চালানো হচ্ছে
      for (var valu in value.items) {

        // প্রতিটি image এর download URL নেওয়া হচ্ছে
        String url = await valu.getDownloadURL();

        // URL list এ add করা হচ্ছে এবং UI update হচ্ছে
        setState(() {
          storageReference.add(url.toString());
        });

        // UI refresh করার জন্য setState
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    super.initState();

    // Screen load হওয়ার সাথে সাথে image fetch হবে
    getImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('Image Screen'),
      ),

      // সব image URL List আকারে দেখানো হচ্ছে
      body: ListView.builder(

        // List এর মোট item সংখ্যা
        itemCount: storageReference.length,

        // প্রতিটি item build করা হচ্ছে
        itemBuilder: (context, index) {
          return ListTile(

            // List item এ click করলে নতুন page এ image open হবে
            onTap: () async {

              // final url = await storageReference[index].getDownloadURL();

              Navigator.push(
                context,

                // নতুন page এ navigate করা হচ্ছে
                MaterialPageRoute(
                  builder: (context) =>
                      ImageViewer(url: storageReference[index]),
                ),
              );
            },

            // URL text হিসেবে show হচ্ছে
            title: Text(storageReference[index]),
          );
        },
      ),
    );
  }
}

// নির্দিষ্ট image দেখানোর widget
class ImageViewer extends StatelessWidget {

  // image URL receive করার variable
  final String url;

  const ImageViewer({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // Network থেকে image show করা হচ্ছে
    return Image.network(url);
  }
}
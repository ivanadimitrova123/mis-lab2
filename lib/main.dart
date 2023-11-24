import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Clothes {
  String name;

  Clothes(this.name);
}

class ClothesList {
  List<Clothes> _clothesList = [];

  List<Clothes> get clothesList => _clothesList;

  void addClothes(Clothes clothes) {
    _clothesList.add(clothes);
  }

  void removeClothes(int index) {
    _clothesList.removeAt(index);
  }

  void editClothes(int index, Clothes clothes) {
    _clothesList[index] = clothes;
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ClothesApp(),
    );
  }
}

class ClothesApp extends StatefulWidget {
  @override
  _ClothesAppState createState() => _ClothesAppState();
}

class _ClothesAppState extends State<ClothesApp> {
  final ClothesList clothesList = ClothesList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text(
          'Clothes List',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ClothesListWidget(clothesList: clothesList),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showDialog(context);
        },
        backgroundColor: Colors.green,
        child: const Text(
          'Add',
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  void _showDialog(BuildContext context) {
    String clothesName = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:const Text('Add Clothes', style: TextStyle(color: Colors.blue)),
          content: TextField(
            onChanged: (value) {
              clothesName = value;
            },
            decoration: const InputDecoration(labelText: 'Clothes Name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue,
              ),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  clothesList.addClothes(Clothes(clothesName));
                });
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue,
              ),
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}

class ClothesListWidget extends StatefulWidget {
  final ClothesList clothesList;

  ClothesListWidget({required this.clothesList});

  @override
  _ClothesListWidgetState createState() => _ClothesListWidgetState();
}

class _ClothesListWidgetState extends State<ClothesListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.clothesList.clothesList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(widget.clothesList.clothesList[index].name),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
            Container(margin: const EdgeInsets.only(right: 8.0), // Adjust the margin as needed
              child: TextButton(
                onPressed: () {
                  _showEditDialog(context, index);
                  },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: const Text(
                  'Edit',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
              TextButton(
                onPressed: () {
                  setState(() {
                    widget.clothesList.removeClothes(index);
                  });
                  },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child:const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showEditDialog(BuildContext context, int index) {
    String clothesName = widget.clothesList.clothesList[index].name;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:const Text('Edit Clothes', style: TextStyle(color: Colors.blue)),
          content: TextField(
            onChanged: (value) {
              clothesName = value;
            },
            decoration:const InputDecoration(labelText: 'Clothes Name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue,
              ),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  widget.clothesList.editClothes(index, Clothes(clothesName));
                });
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue,
              ),
              child:const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}

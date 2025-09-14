import 'package:flutter/material.dart';
import 'package:flutter_app/util/drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _showClassOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext ctx) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.add),
              title: Text('Create Class'),
              onTap: () {
                Navigator.pop(ctx); // Close the bottom sheet
                Navigator.pushNamed(context, '/create');
              },
            ),
            ListTile(
              leading: Icon(Icons.group_add),
              title: Text('Join Class'),
              onTap: () {
                Navigator.pop(ctx); // Close the bottom sheet
                Navigator.pushNamed(context, '/join');
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text("Home screen"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showClassOptions(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
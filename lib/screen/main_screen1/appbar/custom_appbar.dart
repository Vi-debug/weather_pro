import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String city;
  CustomAppBar({this.city});
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding:const  EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              color: Colors.white,
              icon: const Icon(Icons.add),
              iconSize: 24,
              onPressed: () {
                //todo: add new city
              },
            ),
            Text(
              city == null ? 'Location' : city,
              style: Theme.of(context).textTheme.headline2,
            ),
            PopupMenuButton(
              elevation: 10,
              onSelected: handleSelected,
              icon:const Icon(
                Icons.more_vert_rounded,
                color: Colors.white,
              ),
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    child:const Text('Cài đặt'),
                    value: 'Cài đặt',
                  ),
                  const PopupMenuItem(child:const Text('Chia sẻ'), value: 'Chia sẻ'),
                ];
              },
            ) 
          ],
        ),
      ),
    );
  }

  void handleSelected(String value) {
    switch (value) {
      case 'Cài đặt':
        //todo: open setting screen
        return;
      case 'Chia sẻ':
        // todo: open share screen
        return;
      default:
        return;
    }
  }
}

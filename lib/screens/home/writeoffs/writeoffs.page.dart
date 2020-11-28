import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ziin/logic/writeoffs.dart';
import 'package:ziin/screens/home/writeoffs/writeoff.tile.dart';
import 'package:ziin/ui/z_button/z_button.dart';

class WriteOffsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final writeoffsProvider = Provider.of<WriteOffsProvider>(context);
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ZButton(
              onPressed: () {},
              value: 'Добавить',
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: writeoffsProvider.testList.length,
              itemBuilder: (BuildContext context, int index) {
                return WriteOffTile(
                  writeOff: writeoffsProvider.testList[index],
                  onTap: () => Navigator.of(context).pushNamed('/writeoff',
                      arguments: writeoffsProvider.testList[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

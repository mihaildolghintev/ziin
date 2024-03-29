import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ziin/logic/writeoffs.dart';
import 'package:ziin/models/write_off.model.dart';
import 'package:ziin/screens/home/writeoffs/writeoff.tile.dart';
import 'package:ziin/ui/z_alert_dialog/z_confirm_dialog.dart';
import 'package:ziin/ui/z_button/z_button.dart';
import 'package:ziin/ui/z_drawer/z_drawer.dart';

final _writeOffProvider = Provider((ref) => WriteOffsProvider());

class WriteOffsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final writeoffsProvider = watch(_writeOffProvider);
    return Scaffold(
      drawer: ZDrawer(),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Списания',
          style: TextStyle(color: Colors.black),
        ),
      ),
      floatingActionButton: Hero(
        tag: 'button',
        child: SizedBox(
          height: 80,
          width: 80,
          child: ZButton(
            onPressed: () => Navigator.of(context).pushNamed('/writeoff'),
            icon: Icons.add,
            value: '',
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<WriteOff>>(
                  stream: writeoffsProvider.writeoffs,
                  initialData: [],
                  builder: (context, snapshot) {
                    print(snapshot);
                    return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Dismissible(
                          key: UniqueKey(),
                          confirmDismiss: (_) async {
                            return await showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (_) => ZConfirmDialog(
                                onOK: () {
                                  writeoffsProvider.removeWriteOFf(
                                    snapshot.data[index],
                                  );
                                  Navigator.of(context).pop();
                                },
                                title: 'Подтвердите',
                              ),
                            );
                          },
                          child: WriteOffTile(
                            writeOff: snapshot.data[index],
                            onTap: () => Navigator.of(context).pushNamed(
                                '/writeoff',
                                arguments: snapshot.data[index]),
                          ),
                        );
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

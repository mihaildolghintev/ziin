import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ziin/logic/writeoffs.dart';
import 'package:ziin/models/write_off.model.dart';
import 'package:ziin/screens/home/writeoffs/writeoff.tile.dart';
import 'package:ziin/ui/z_alert_dialog/z_confirm_dialog.dart';
import 'package:ziin/ui/z_button/z_button.dart';

final _writeOffProvider = Provider((ref) => WriteOffsProvider());

class WriteOffsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final writeoffsProvider = watch(_writeOffProvider);
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ZButton(
              onPressed: () => Navigator.of(context).pushNamed('/writeoff'),
              value: 'Добавить',
            ),
          ),
          Expanded(
            child: StreamBuilder<List<WriteOff>>(
                stream: writeoffsProvider.writeoffs,
                initialData: [],
                builder: (context, snapshot) {
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
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:stringvault/const/colors.dart';
import 'package:stringvault/utils/snackbar.dart';

import '../providers/data_provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController plainTextEditingController =
      TextEditingController();

  @override
  void dispose() {
    super.dispose();
    plainTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('String Vault'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: plainTextEditingController,
              autofocus: false,
              cursorColor: ConstColors.tealPrimary,
              decoration: const InputDecoration(
                labelText: 'Enter text to encrypt',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (plainTextEditingController.text.isNotEmpty) {
                  Provider.of<DataProvider>(context, listen: false)
                      .encryptAndSave(plainTextEditingController.text);
                  plainTextEditingController.clear();
                  FocusScope.of(context).unfocus();
                  showSnackBar("Text is encrypted and saved", context);
                } else {
                  showSnackBar(
                      "Please enter a text to encrypt and save", context);
                }
              },
              child: const Text('Encrypt and Save'),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Consumer<DataProvider>(
                builder: (context, dataProvider, _) {
                  return dataProvider.dataList.isEmpty
                      ? const Center(
                          child: Text("No Data Found"),
                        )
                      : ListView.builder(
                          itemCount: dataProvider.dataList.length,
                          itemBuilder: (context, index) {
                            var data = dataProvider.dataList[index];
                            return Container(
                              margin: const EdgeInsets.only(top: 5, bottom: 5),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: ConstColors.tealAccent,
                                  width: 0.5,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: ListTile(
                                title: Text('Encrypted Data ${data.id}'),
                                subtitle: const Text('Tap to Decrypt'),
                                onTap: () {
                                  //decrypt and show the data to user
                                  dataProvider
                                      .decryptAndDisplay(data.id)
                                      .then((value) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Decrypted Value'),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          content: Text(value!),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Clipboard.setData(ClipboardData(
                                                        text: value))
                                                    .whenComplete(() {
                                                  showSnackBar(
                                                      "Decrypted value copied to clipboard",
                                                      context);
                                                });
                                                Navigator.pop(context);
                                              },
                                              child: const Text('Copy'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  });
                                },
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.copy),
                                      onPressed: () {
                                        //copy the encrypted data
                                        dataProvider
                                            .getEncryptedValue(data.id)
                                            .then((value) {
                                          Clipboard.setData(
                                                  ClipboardData(text: value!))
                                              .whenComplete(() {
                                            showSnackBar(
                                                "Encrypted value copied to clipboard",
                                                context);
                                          });
                                        });
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () {
                                        dataProvider.deleteData(data.id);
                                        showSnackBar(
                                            "Encrypted Data ${data.id} deleted",
                                            context);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

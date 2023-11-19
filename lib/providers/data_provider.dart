// providers/data_provider.dart
import 'package:flutter/material.dart';
import 'package:stringvault/models/encrypted_data_model.dart';
import 'package:stringvault/services/database_services.dart';

class DataProvider extends ChangeNotifier {
  final DatabaseService _databaseService;

  DataProvider(this._databaseService) {
    fetchData();
  }

  List<EncryptedData> _dataList = [];

  List<EncryptedData> get dataList => _dataList;

  Future<void> fetchData() async {
    _dataList = await _databaseService.fetchData();
    notifyListeners();
  }

  Future<void> encryptAndSave(String dataToEncrypt) async {
    await _databaseService.encryptAndSave(dataToEncrypt);
    await fetchData(); // Refresh data after saving
  }

  Future<String?> decryptAndDisplay(int id) async {
    final data = await _databaseService.decryptAndDisplay(id);
    return data;
  }

  Future<String?> getEncryptedValue(int id) async {
    final data = await _databaseService.getEncryptedValue(id);
    return data;
  }

  Future<void> deleteData(int id) async {
    await _databaseService.deleteData(id);
    await fetchData(); // Refresh data after deletion
  }
}

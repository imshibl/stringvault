// services/database_service.dart
import 'package:sqflite/sqflite.dart';
import 'package:encrypt/encrypt.dart';
import 'package:stringvault/models/encrypted_data_model.dart';

class DatabaseService {
  late Database _database;
  late final String _databasePath;

  DatabaseService(String databasePath) : _databasePath = databasePath;

  final code = r'E4x*$TwbkJC-xK4KGC4zJF9j*Rh&WLgR';

  Future<void> initializeDatabase() async {
    _database = await openDatabase(_databasePath, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE encrypted_data (id INTEGER PRIMARY KEY, data TEXT)');
    });
  }

  Future<List<EncryptedData>> fetchData() async {
    List<Map<String, dynamic>> rows =
        await _database.rawQuery('SELECT * FROM encrypted_data');
    return rows
        .map((row) => EncryptedData(id: row['id'], data: row['data']))
        .toList();
  }

  Future<void> encryptAndSave(String dataToEncrypt) async {
    final key = Key.fromUtf8(code);
    final iv = IV.allZerosOfLength(16);
    final encrypter = Encrypter(AES(key));
    final encryptedData = encrypter.encrypt(dataToEncrypt, iv: iv).base64;

    await _database.rawInsert(
        'INSERT INTO encrypted_data (data) VALUES(?)', [encryptedData]);
  }

  Future<String?> decryptAndDisplay(int id) async {
    List<Map<String, dynamic>> rows = await _database
        .rawQuery('SELECT * FROM encrypted_data WHERE id = ?', [id]);
    if (rows.isNotEmpty) {
      String encryptedData = rows.first['data'];

      final key = Key.fromUtf8(code);
      final iv = IV.allZerosOfLength(16);
      final encrypter = Encrypter(AES(key));
      final encrypted = Encrypted.fromBase64(encryptedData);

      final decryptedData = encrypter.decrypt(encrypted, iv: iv);
      return decryptedData;
    }
    return null;
  }

  Future<String?> getEncryptedValue(int id) async {
    List<Map<String, dynamic>> rows = await _database
        .rawQuery('SELECT * FROM encrypted_data WHERE id = ?', [id]);
    if (rows.isNotEmpty) {
      String encryptedData = rows.first['data'];
      return encryptedData;
    }
    return null;
  }

  Future<void> deleteData(int id) async {
    await _database.rawDelete('DELETE FROM encrypted_data WHERE id = ?', [id]);
  }
}

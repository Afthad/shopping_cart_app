import 'package:konnect_app/models/products.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseManager {
  static const _databaseName = 'products.db';
  static const _productsTable = 'products_table';
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _init();
    return _database!;
  }

  _init() async {
    String path = join(await getDatabasesPath(), _databaseName);

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE $_productsTable('
        'prodId INTEGER PRIMARY KEY AUTOINCREMENT, prodName STRING, prodImage STRING, prodCode STRING, prodMrp STRING, prodRkPrice STRING'
        ')');
  }

  Future<int> addProducts(Product product) async {
    Database? db = DatabaseManager._database;
    return await db!.insert(_productsTable, {
      "prodImage": product.prodImage,
      "prodCode": product.prodCode,
      "prodName": product.prodName,
      "prodMrp": product.prodMrp,
      "prodRkPrice": product.prodRkPrice,
      "prodId": product.prodId,
    });
  }

  Future<List<Map<String, dynamic>>> getAllProducts() async {
    Database? db = DatabaseManager._database;
    return await db!.query(_productsTable);
  }

  Future<int> deleteAllProducts() async {
    Database? db = DatabaseManager._database;
    return await db!.delete(_productsTable);
  }
}

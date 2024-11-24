class User {
  String name;
  int age;
  late List<Product> products;
  Role? role;

  User(this.name, this.age, this.role) {
    products = [];
  }
}

// Kelas untuk menampung kategori produk
class Kategori {
  List<Product> elektronik = [];
  List<Product> makanan = [];

  void tambahProduk(Product product) {
    if (product.jenisProduk == JenisProduk.Elektronik) {
      elektronik.add(product);
    } else if (product.jenisProduk == JenisProduk.Makanan) {
      makanan.add(product);
    }
  }

  void tampilkanProdukKategori() {
    print('\n=== Daftar Produk Elektronik ===');
    for (var product in elektronik) {
      print('${product.productName} - Rp${product.price} - ${product.inStock ? "Tersedia" : "Habis"}');
    }

    print('\n=== Daftar Produk Makanan ===');
    for (var product in makanan) {
      print('${product.productName} - Rp${product.price} - ${product.inStock ? "Tersedia" : "Habis"}');
    }
  }
}

enum JenisProduk { Elektronik, Makanan }

class Product {
  String productName;
  double price;
  bool inStock;
  JenisProduk jenisProduk;

  Product(this.productName, this.price, this.inStock, this.jenisProduk);
}

enum Role { Admin, Customer }

class AdminUser extends User {
  AdminUser(String name, int age) : super(name, age, Role.Admin);

  void tambahProduk(Product product, Kategori kategori) {
    if (product.inStock) {
      products.add(product);
      kategori.tambahProduk(product);
      print("\n===== INFO LAPORAN TAMBAH PRODUK =====");
      print('${product.productName} berhasil ditambahkan ke daftar produk.');
    } else {
      print(
          '${product.productName} tidak tersedia dalam stok dan tidak dapat ditambahkan.');
    }
  }

  void hapusProduk(Product product) {
    products.remove(product);
    print("\n===== INFO LAPORAN HAPUS PRODUK =====");
    print('${product.productName} berhasil dihapus dari daftar produk.');
  }
}

class CustomerUser extends User {
  CustomerUser(String name, int age) : super(name, age, Role.Customer);

  void lihatProduk() {
    print('\nDaftar Produk Tersedia:');
    for (var product in products) {
      print('${product.productName} - Rp${product.price} - ${product.inStock ? "Tersedia" : "Habis"}');
    }
  }
}

Future<void> fetchProductDetails() async {
  print('Mengambil detail produk...');
  await Future.delayed(Duration(seconds: 2));
  print('Detail produk berhasil diambil.');
}

void main() {
  // Membuat objek AdminUser, CustomerUser, dan Kategori
  AdminUser admin = AdminUser('Array', 25);
  CustomerUser customer = CustomerUser('Alfi', 21);
  Kategori kategori = Kategori();

  // Membuat produk-produk contoh dengan kategori yang berbeda
  Product product1 = Product('Laptop Lenovo', 15000000.0, true, JenisProduk.Elektronik);
  Product product2 = Product('Paket KFC', 50000.0, true, JenisProduk.Makanan);
  Product product3 = Product('Handphone Samsung', 7000000.0, true, JenisProduk.Elektronik);
  Product product4 = Product('Nasi Goreng', 25000.0, true, JenisProduk.Makanan);

  // Menambahkan produk ke dalam daftar produk admin dan kategori
  try {
    admin.tambahProduk(product1, kategori);
    admin.tambahProduk(product2, kategori);
    admin.tambahProduk(product3, kategori);
    admin.tambahProduk(product4, kategori);
  } on Exception catch (e) {
    print('Kesalahan: $e');
  }

  // Memastikan produk yang tersedia ditampilkan pada pengguna CustomerUser
  customer.products = admin.products;
  customer.lihatProduk();

  // Menampilkan produk berdasarkan kategori
  kategori.tampilkanProdukKategori();

  // Pengambilan data produk secara asinkron
  fetchProductDetails();
}

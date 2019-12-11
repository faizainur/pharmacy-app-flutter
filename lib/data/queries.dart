import 'package:pharmacy_app/models/product.dart';

class Queries {
  static String fetchAll() {
    String str = """
  query MyQuery {
    produk {
      serial_id
      nama_produk
      stocks {
        stock
      }
      harga
      exp
      rak_produks {
        rak
      }
    }
  }
  """;

  return str;
  }

  static String searchData = """
query Search(\$keyString: String!, \$keyInt:bigint!) {
  produk(
    where: {
      _or: [
        {nama_produk: {_ilike: \$keyString}},
        {serial_id: {_eq: \$keyInt}}
      ]
    }
  ) {
    harga
    nama_produk
    rak_produks {
      rak
    }
    serial_id
    stocks {
      stock
    }
    exp
  }
}
  """;

  static String updateData = """
  mutation MyMutation(\$oldSerialId: bigint!, \$newSerialId: bigint!, \$namaProduk: String!, \$harga: Int!, \$rak: Int!, \$stock: Int!, \$exp: date!) {
  __typename
  update_produk(where: {serial_id: {_eq: \$oldSerialId}}, _set: {serial_id: \$newSerialId, nama_produk: \$namaProduk, harga: \$harga, exp: \$exp}) {
    returning {
      serial_id
    }
  }
  update_stock(where: {serial_id: {_eq: \$oldSerialId}}, _set: {stock: \$stock}) {
    returning {
      stock
    }
  }
  update_rak_produk(where: {serial_id: {_eq: \$oldSerialId}}, _set: {rak: \$rak}) {
    returning {
      rak
    }
  }
}
  """;
  
  static String insertData = """
  mutation insertData(\$serialId:bigint!,\$harga:Int!,\$exp:date!,\$stock:Int!,\$rak:Int!,\$namaProduk:String!) {
    __typename
    insert_produk(objects: {serial_id: \$serialId, nama_produk:\$namaProduk, harga: \$harga, exp: \$exp, stocks: {data: {stock: \$stock}}, rak_produks: {data: {rak: \$rak}}}) {
      returning {
        nama_produk
        serial_id
      }
    }
  }
  """;

  static String deleteData = """
  mutation deleteData(\$serialId: bigint!) {
    __typename
    delete_stock(where: {serial_id: {_eq: \$serialId}}) {
      returning {
        stock
      }
    }
    delete_rak_produk(where: {serial_id: {_eq: \$serialId}}) {
      returning {
        rak
      }
    }
    delete_produk(where: {serial_id: {_eq: \$serialId}}) {
      returning {
        serial_id
        nama_produk
      }
    }
  }
  """;

  static String addTransaction = """
mutation newTransaction(\$jam:time!,\$tanggal:date!,\$soldProduct:_int8!,\$totalHarga:Int!) {
  __typename
  insert_transaksi(objects: {jam: \$jam, tanggal: \$tanggal, sold_product: \$soldProduct, total_harga: \$totalHarga}) {
    returning {
      transaksi_id
      total_harga
      sold_product
      tanggal
      jam
    }
  }
}

  """;
}
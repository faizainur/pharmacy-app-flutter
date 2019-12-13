import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:pharmacy_app/data/queries.dart';
import 'package:pharmacy_app/models/product.dart';
import 'package:pharmacy_app/models/transaction.dart';
import 'history_item.dart';
import 'models/trasactions_perday_bundle.dart';
import 'package:sticky_headers/sticky_headers.dart';

class HistoryPage extends StatefulWidget {
  // Test SSH

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  Transaction transaction1;
  Transaction transaction2;

  // Product obatBatuk = new Product('OB1', 'Obat Batuk', 20000, 5, 'Meredakan batuk');
  // Product paracetamol = new Product('PR1', 'Paracetamol', 15000, 25, 'Meredakan Demam');
  // Product diapet = new Product('OB1', 'Diapet', 20000, 5, 'Meredakan batuk');
  // Product diataps = new Product('PR1', 'Diataps', 15000, 25, 'Meredakan Demam');
  // Product promag = new Product('OB1', 'Promag', 20000, 5, 'Meredakan batuk');
  // Product imbost = new Product('PR1', 'Imbost', 15000, 25, 'Meredakan Demam');
  // Product betadine = new Product('OB1', 'betadine', 20000, 5, 'Meredakan batuk');
  // Product handsaplast = new Product('PR1', 'Handsaplast', 15000, 25, 'Meredakan Demam');
  // Transaction List Dummy Data
  List<Transaction> listTransaction1;
  List<Transaction> listTransaction2;

  List<Product> listProductSold1;
  List<Product> listProductSold2;

  TransactionBundle bundle1;
  TransactionBundle bundle2;

  List<TransactionBundle> bundleList = new List<TransactionBundle>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    /* Test Dummy Datas */
    // listProductSold1 = [obatBatuk, obatBatuk, paracetamol,obatBatuk, obatBatuk, paracetamol,obatBatuk, obatBatuk, paracetamol];

    // listProductSold2 = [paracetamol, paracetamol, obatBatuk, obatBatuk
    // , diapet, promag, imbost, betadine, handsaplast];

    // transaction1 = new Transaction(
    //     21533, '25 November 2019', '12.00', listProductSold1, 'Tunai', 24000, 'Wisnu');
    // transaction2 = new Transaction(
    //     35, '28 November 2019', '12.50', listProductSold2, 'OVO', 120000, 'Wisnu');

    listTransaction1 = [
      transaction1,
      transaction2,
      transaction1,
      transaction2,
      transaction1,
      transaction2,
      transaction1,
      transaction2,
      transaction2,
      transaction1,
      transaction2,
      transaction2,
      transaction1,
      transaction2,
    ];

    listTransaction2 = [
      transaction1,
      transaction2,
      transaction1,
      transaction2,
      transaction1,
      transaction2,
    ];

    bundle1 = TransactionBundle("12 November 2019", listTransaction2);
    bundle2 = TransactionBundle("15 Desember 2019", listTransaction1);

    bundleList.add(bundle1);
    bundleList.add(bundle2);

    /* End of section */
  }

  List<Product> getListSoldProduct(List<int> listId) {
    // return Query(
    //   options: QueryOptions(document: Queries.getListTransaksi),
    //   builder: (QueryResult result, {VoidCallback refetch}) {
    //     List<Transaction> transaksi;
    //     return transaksi;
    //   },
    // );
    List<Product> soldProducts = List<Product>();
    Query(
      options: QueryOptions(
        document: Queries.getSoldProduct,
        variables: {'listProduct': listId},
      ),
      builder: (QueryResult result,
          {VoidCallback refetch, FetchMore fetchMore}) {
        if (result.errors != null) {
          return Text(result.errors.toString());
        }
        if (result.loading) {
          return Text("Loading...");
        }
        List<dynamic> fetchedProduk = result.data['produk'];
        fetchedProduk.forEach(
          (itemProduk) {
            soldProducts.add(Product(
                itemProduk['serial_id'],
                itemProduk['nama_produk'],
                itemProduk['harga'],
                itemProduk['stocks'][0]['stock'],
                DateTime.parse(itemProduk['exp']),
                itemProduk['rak_produks'][0]['rak']));
          },
        );
        return Text("Success");
      },
    );

    return soldProducts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.white,
        backgroundColor: const Color(0xff1f83fe),
        elevation: 0,
        leading: BackButton(
          color: Colors.white,
        ),
        title: Text(
          "Transaction History",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        child: Center(
            child: Query(
          options: QueryOptions(
            document: Queries.getTotalPenjualanPerBulan,
          ),
          builder: (QueryResult resultPerBulan,
              {VoidCallback refetch, FetchMore fetchMore}) {
            if (resultPerBulan.errors != null) {
              return Text(resultPerBulan.errors.toString());
            }
            if (resultPerBulan.loading) {
              return Center(
                child: Loading(
                  indicator: BallPulseIndicator(),
                  size: 50,
                  color: Colors.grey,
                ),
              );
            }
            List<dynamic> resultPerBulanList =
                resultPerBulan.data['total_penjualan_per_bulan'];
            return ListView.builder(
              itemCount: resultPerBulanList.length,
              itemBuilder: (BuildContext context, int index) {
                // List<Widget> listTiles = List<Widget>();

                // bundleList[index].transactionList.forEach(
                //   (v) {
                //     listTiles.add(HistoryItem(v));
                //   },
                // );
                dynamic responseData = resultPerBulanList[index];
                return StickyHeader(
                  header: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: 50,
                    color: Colors.grey[200],
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            flex: 1,
                            child: Text(
                              DateFormat.yMMMMd("en_US").format(
                                  DateTime.parse(responseData['tanggal'])),
                              style:
                                  TextStyle(fontSize: 15, color: Colors.grey),
                            )
                            // resultPerBulan['total_penjualan_per_bulan'],

                            ),
                        Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Rp. " +
                                  responseData['total_harga_per_bulan']
                                      .toString(),
                              style: TextStyle(
                                  color: Colors.blue[800],
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  content: Query(
                    options: QueryOptions(
                      document: Queries.getListTransaksiPerBulan,
                      variables: {'tanggal': responseData['tanggal']},
                    ),
                    builder: (QueryResult transaksiItem,
                        {VoidCallback refetch, FetchMore fetchMore}) {
                      if (transaksiItem.errors != null) {
                        return Text(transaksiItem.errors.toString());
                      }
                      if (transaksiItem.loading) {
                        return Center(
                          child: Loading(
                            indicator: BallPulseIndicator(),
                            size: 30,
                            color: Colors.grey,
                          ),
                        );
                      }
                      List<dynamic> fetchedTransaksi =
                          transaksiItem.data['transaksi'];

                      // fetchedTransaksi.forEach(
                      //   (v) {

                      //   },
                      // );

                      List<HistoryItem> listTiles = List<HistoryItem>();

                      fetchedTransaksi.forEach(
                        (transaksi) {
                          List<int> soldProductId = List<int>();
                          List<int> soldProductQty = List<int>();
                          List<dynamic> soldProductList =
                              transaksi['sold_product'];
                          soldProductList.forEach(
                            (soldProduct) {
                              soldProductId.add(soldProduct[0]);
                              soldProductQty.add(soldProduct[1]);
                            },
                          );
                          listTiles.add(
                            HistoryItem(
                              Transaction(
                                  transaksi['transaksi_id'],
                                  DateFormat.yMMMMd("en_US").format(
                                      DateTime.parse(transaksi['tanggal'])),
                                  transaksi['jam'].substring(0, 5),
                                  soldProductId,
                                  soldProductQty,
                                  transaksi['total_harga']),
                            ),
                          );
                        },
                      );
                      return Wrap(
                        children: listTiles,
                      );
                    },
                  ),
                );
              },
            );
          },
        )),
      ),
    );
  }
}

class ProductItem {
  ProductItem({
    this.id,
    this.title,
    this.barcodes = const [],
    this.cash = "0",
    this.plu = "0",
    this.isWeight = false,
  });
  final String id;
  final String title;
  final List<String> barcodes;
  final String cash;
  final String plu;
  final bool isWeight;

  factory ProductItem.fromJson(Map<String, dynamic> json) {
    return ProductItem(
      id: json['ID'],
      title: json['Title'],
      barcodes: ((json['Barcodes']) as List<dynamic>)
          .map((barcode) => barcode.toString())
          .toList(),
      cash: json['Cash'],
      plu: json['Plu'],
      isWeight: json['IsWeight'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Title': title,
      'Barcodes': barcodes,
      'Cash': cash,
      'Plu': plu,
      'IsWeight': isWeight,
    };
  }
}

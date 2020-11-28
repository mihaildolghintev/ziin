class ProductItem {
  ProductItem({
    this.id,
    this.title,
    this.barcodes = const [],
    this.cash = 0,
    this.plu = 0,
    this.weight,
    this.isWeight = false,
  });
  final String id;
  final String title;
  final List<String> barcodes;
  final int cash;
  final int plu;
  final double weight;
  final bool isWeight;

  factory ProductItem.fromJson(Map<String, dynamic> json) {
    return ProductItem(
      id: json['id'],
      title: json['title'],
      barcodes: ((json['barcode']) as List)
          .map((barcode) => barcode.toString())
          .toList(),
      cash: json['cash'],
      plu: json['plu'],
      weight: json['weight'],
      isWeight: json['isWeight'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'barcode': barcodes,
      'cash': cash,
      'plu': plu,
      'weight': weight,
      'isWeight': isWeight,
    };
  }
}

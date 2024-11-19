class FakeDataApi {
  final List<String> _subCategs = ["الكل"];
  final List<String> _subCategsApi = [
    "الكترونيات",
    "لابتوبات",
    "شنط نسائية",
    "باريس",
    "الكترونيات",
    "لابتوبات",
    "شنط",
    "باريس",
    "الكترونيات",
    "لابتوبات",
    "شنط نسائية",
    "باريس",
    "الكترونيات",
    "لابتوبات",
    "شنط",
    "باريس",
  ];

  // Getter
  List<String> get subCategs => [..._subCategs, ..._subCategsApi];
}

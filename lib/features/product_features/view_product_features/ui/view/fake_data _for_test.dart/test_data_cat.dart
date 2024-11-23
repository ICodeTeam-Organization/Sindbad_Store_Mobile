class FakeDataApi {
  final List<String> subCategsAll = ["الكل"];
  final List<String> subCat = [
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
    "باريس"
  ];
  // Getter
  List<String> get subCategories => [...subCategsAll, ...subCat];
  // ==================================================================================
  static final List<Map<String, dynamic>> allProductsData = [
    {
      'name': 'Mobile A1',
      'id': '1',
      'price': '1200',
      'imageUrl': 'https://via.placeholder.com/100',
    },
    {
      'name': 'Laptop B2',
      'id': '2',
      'price': '2500',
      'imageUrl': 'https://via.placeholder.com/100',
    },
    {
      'name': 'Headphones C3',
      'id': '3',
      'price': '300',
      'imageUrl': 'https://via.placeholder.com/100',
    },
    {
      'name': 'Tablet D4',
      'id': '4',
      'price': '1600',
      'imageUrl': 'https://via.placeholder.com/100',
    },
    {
      'name': 'Smartwatch E5',
      'id': '5',
      'price': '500',
      'imageUrl': 'https://via.placeholder.com/100',
    },
    {
      'name': 'Smartphone F6',
      'id': '6',
      'price': '2000',
      'imageUrl': 'https://via.placeholder.com/100',
    },
    {
      'name': 'Camera G7',
      'id': '7',
      'price': '1500',
      'imageUrl': 'https://via.placeholder.com/100',
    },
    {
      'name': 'Wireless Mouse H8',
      'id': '8',
      'price': '150',
      'imageUrl': 'https://via.placeholder.com/100',
    },
    {
      'name': 'Keyboard I9',
      'id': '9',
      'price': '120',
      'imageUrl': 'https://via.placeholder.com/100',
    },
    {
      'name': 'Speakers J10',
      'id': '10',
      'price': '400',
      'imageUrl': 'https://via.placeholder.com/100',
    },
    // {
    //   'name': 'Bluetooth Earbuds K11',
    //   'id': '11',
    //   'price': '350',
    //   'imageUrl': 'https://via.placeholder.com/100',
    // },
    // {
    //   'name': 'Smart TV L12',
    //   'id': '12',
    //   'price': '3000',
    //   'imageUrl': 'https://via.placeholder.com/100',
    // },
    // {
    //   'name': 'Gaming Console M13',
    //   'id': '13',
    //   'price': '4000',
    //   'imageUrl': 'https://via.placeholder.com/100',
    // },
    // {
    //   'name': 'Portable Charger N14',
    //   'id': '14',
    //   'price': '100',
    //   'imageUrl': 'https://via.placeholder.com/100',
    // },
    // {
    //   'name': 'Electric Kettle O15',
    //   'id': '15',
    //   'price': '80',
    //   'imageUrl': 'https://via.placeholder.com/100',
    // },
    // {
    //   'name': 'Washing Machine P16',
    //   'id': '16',
    //   'price': '2500',
    //   'imageUrl': 'https://via.placeholder.com/100',
    // },
    // {
    //   'name': 'Microwave Oven Q17',
    //   'id': '17',
    //   'price': '800',
    //   'imageUrl': 'https://via.placeholder.com/100',
    // },
    // {
    //   'name': 'Refrigerator R18',
    //   'id': '18',
    //   'price': '5000',
    //   'imageUrl': 'https://via.placeholder.com/100',
    // },
    // {
    //   'name': 'Air Conditioner S19',
    //   'id': '19',
    //   'price': '3500',
    //   'imageUrl': 'https://via.placeholder.com/100',
    // },
    // {
    //   'name': 'Electric Fan T20',
    //   'id': '20',
    //   'price': '150',
    //   'imageUrl': 'https://via.placeholder.com/100',
    // },
    // {
    //   'name': 'Juicer U21',
    //   'id': '21',
    //   'price': '200',
    //   'imageUrl': 'https://via.placeholder.com/100',
    // },
    // {
    //   'name': 'Coffee Machine V22',
    //   'id': '22',
    //   'price': '600',
    //   'imageUrl': 'https://via.placeholder.com/100',
    // },
    // {
    //   'name': 'Food Processor W23',
    //   'id': '23',
    //   'price': '700',
    //   'imageUrl': 'https://via.placeholder.com/100',
    // },
    // {
    //   'name': 'Vacuum Cleaner X24',
    //   'id': '24',
    //   'price': '1000',
    //   'imageUrl': 'https://via.placeholder.com/100',
    // },
    // {
    //   'name': 'Iron Y25',
    //   'id': '25',
    //   'price': '50',
    //   'imageUrl': 'https://via.placeholder.com/100',
    // },
    // {
    //   'name': 'Blender Z26',
    //   'id': '26',
    //   'price': '150',
    //   'imageUrl': 'https://via.placeholder.com/100',
    // },
    // {
    //   'name': 'Toaster AA27',
    //   'id': '27',
    //   'price': '60',
    //   'imageUrl': 'https://via.placeholder.com/100',
    // },
    // {
    //   'name': 'Rice Cooker BB28',
    //   'id': '28',
    //   'price': '120',
    //   'imageUrl': 'https://via.placeholder.com/100',
    // },
    // {
    //   'name': 'Electric Shaver CC29',
    //   'id': '29',
    //   'price': '70',
    //   'imageUrl': 'https://via.placeholder.com/100',
    // },
  ];

  static final List<Map<String, dynamic>> offerProductsData = [
    {
      'name': 'Toyota Camry',
      'id': '1',
      'price': '25000',
      'imageUrl': 'https://via.placeholder.com/100',
    },
    {
      'name': 'Honda Accord',
      'id': '2',
      'price': '27000',
      'imageUrl': 'https://via.placeholder.com/100',
    },
    {
      'name': 'Nissan Altima',
      'id': '3',
      'price': '24000',
      'imageUrl': 'https://via.placeholder.com/100',
    },
    {
      'name': 'Ford Mustang',
      'id': '4',
      'price': '35000',
      'imageUrl': 'https://via.placeholder.com/100',
    },
    {
      'name': 'Chevrolet Malibu',
      'id': '5',
      'price': '23000',
      'imageUrl': 'https://via.placeholder.com/100',
    },
    {
      'name': 'BMW 3 Series',
      'id': '6',
      'price': '42000',
      'imageUrl': 'https://via.placeholder.com/100',
    },
    {
      'name': 'Audi A4',
      'id': '7',
      'price': '44000',
      'imageUrl': 'https://via.placeholder.com/100',
    },
    {
      'name': 'Mercedes-Benz C-Class',
      'id': '8',
      'price': '48000',
      'imageUrl': 'https://via.placeholder.com/100',
    },
    {
      'name': 'Volkswagen Passat',
      'id': '9',
      'price': '26000',
      'imageUrl': 'https://via.placeholder.com/100',
    },
    {
      'name': 'Tesla Model 3',
      'id': '10',
      'price': '39000',
      'imageUrl': 'https://via.placeholder.com/100',
    },
  ];

  static final List<Map<String, dynamic>> disableProductsData = [
    {
      'name': 'Lionel Messi',
      'id': '1',
      'price': 'Paris Saint-Germain',
      'imageUrl': 'https://via.placeholder.com/100',
    },
    {
      'name': 'Cristiano Ronaldo',
      'id': '2',
      'price': 'Al Nassr',
      'imageUrl': 'https://via.placeholder.com/100',
    },
    {
      'name': 'Neymar Jr.',
      'id': '3',
      'price': 'Paris Saint-Germain',
      'imageUrl': 'https://via.placeholder.com/100',
    },
    {
      'name': 'Kevin De Bruyne',
      'id': '4',
      'price': 'Manchester City',
      'imageUrl': 'https://via.placeholder.com/100',
    },
    {
      'name': 'Kylian Mbappe',
      'id': '5',
      'price': 'Paris Saint-Germain',
      'imageUrl': 'https://via.placeholder.com/100',
    },
    {
      'name': 'Lionel Messi',
      'id': '6',
      'price': 'Paris Saint-Germain',
      'imageUrl': 'https://via.placeholder.com/100',
    },
    {
      'name': 'Cristiano Ronaldo',
      'id': '7',
      'price': 'Al Nassr',
      'imageUrl': 'https://via.placeholder.com/100',
    },
    {
      'name': 'Neymar Jr.',
      'id': '8',
      'price': 'Paris Saint-Germain',
      'imageUrl': 'https://via.placeholder.com/100',
    },
    {
      'name': 'Kevin De Bruyne',
      'id': '9',
      'price': 'Manchester City',
      'imageUrl': 'https://via.placeholder.com/100',
    },
    {
      'name': 'Kylian Mbappe',
      'id': '10',
      'price': 'Paris Saint-Germain',
      'imageUrl': 'https://via.placeholder.com/100',
    },
  ];

  // final List<String> _subCategs = ["الكل"];
  // final List<String> _subCategsApi = [
  //   "الكترونيات",
  //   "لابتوبات",
  //   "شنط نسائية",
  //   "باريس",
  //   "الكترونيات",
  //   "لابتوبات",
  //   "شنط",
  //   "باريس",
  //   "الكترونيات",
  //   "لابتوبات",
  //   "شنط نسائية",
  //   "باريس",
  //   "الكترونيات",
  //   "لابتوبات",
  //   "شنط",
  //   "باريس",
  // ];

  // // Getter
  // List<String> get subCategs => [..._subCategs, ..._subCategsApi];
}

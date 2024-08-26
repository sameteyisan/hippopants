import 'package:hippopants/models/address/address_model.dart';
import 'package:hippopants/models/address/city_model.dart';
import 'package:hippopants/models/address/county_model.dart';
import 'package:hippopants/models/category_model.dart';
import 'package:hippopants/models/order_model.dart';
import 'package:hippopants/models/product/mini_product_model.dart';
import 'package:hippopants/models/product/product_model.dart';
import 'package:hippopants/models/profile_model.dart';
import 'package:hippopants/models/promotion_model.dart';

enum OrderStatus {
  Pending,
  Preparing,
  OnTheWay,
  Delivered,
  Cancelled,
}

class Const {
  static const LOGO = "assets/logo.png";
  static const ICON = "assets/icon.png";

  static const BANNER1 = "assets/images/banner/2023_slider-erkek-1-scaled.jpg";
  static const BANNER2 = "assets/images/banner/2023_slider-kadin-1-scaled.jpg";
  static const BANNER3 = "assets/images/banner/220410_slider-hippopets2-scaled.jpg";
  static const BANNER4 = "assets/images/banner/coffee-time-banner-2024-scaled.jpg";
  static const BANNER5 = "assets/images/banner/Munchies-couple-banner-2024-scaled.jpg";
  static const BANNER6 = "assets/images/banner/p-squad-2024-scaled.jpg";

  static const CATEGORY1 = "assets/images/category/2022_corap-banner-scaled.jpg";
  static const CATEGORY2 = "assets/images/category/2022_erkek-banner-scaled.jpg";
  static const CATEGORY3 = "assets/images/category/2022_kadin-banner-scaled.jpg";
  static const CATEGORY4 = "assets/images/category/2022_pet-banner-scaled.jpg";

  static const PROMOTION1 = "assets/images/promotion/credit-card-icon-1.png";
  static const PROMOTION2 = "assets/images/promotion/love-icon.png";
  static const PROMOTION3 = "assets/images/promotion/smile-icon.png";
  static const PROMOTION4 = "assets/images/promotion/truck-icon-2.png";

  static const PRODUCT1 = "assets/images/product/11_.jpg";
  static const PRODUCT2 = "assets/images/product/f_karakalem.jpg";
  static const PRODUCT3 = "assets/images/product/1_.jpg";
  static const PRODUCT4 = "assets/images/product/f_siyah.jpg";
  static const PRODUCT5 = "assets/images/product/28_.jpg";
  static const PRODUCT6 = "assets/images/product/karakalem_bxr_3-1200x1200.jpg";
  static const PRODUCT7 = "assets/images/product/karakalem_bxr_4-1200x1200.jpg";

  static const WOMEN1 = "assets/images/women/toucan-tanga-1-2048x2048.png";
  static const WOMEN2 = "assets/images/women/DSCF0397_2-2048x2048.png";
  static const WOMEN3 = "assets/images/women/DSCF0019-1920x1920.png";
  static const WOMEN4 = "assets/images/women/DSCF0765-2048x2048.png";
  static const WOMEN5 = "assets/images/women/DSCF0014-2048x2048.png";
  static const WOMEN6 = "assets/images/women/DSCF0523_2-2048x2048.png";
  static const WOMEN7 = "assets/images/women/DSCF3166-kopya-2048x2048.png";
  static const WOMEN8 = "assets/images/women/DSCF9436-2048x2048.png";

  static List<String> BANNERS = <String>[
    BANNER1,
    BANNER2,
    BANNER3,
    BANNER4,
    BANNER5,
    BANNER6,
  ];

  static List<String> CATEGORIES = <String>[
    CATEGORY1,
    CATEGORY2,
    CATEGORY3,
    CATEGORY4,
  ];

  static List<PromotionModel> PROMOTIONS = <PromotionModel>[
    PromotionModel(image: PROMOTION1, text: "promotion_1"),
    PromotionModel(image: PROMOTION2, text: "promotion_2"),
    PromotionModel(image: PROMOTION3, text: "promotion_3"),
    PromotionModel(image: PROMOTION4, text: "promotion_4"),
  ];

  static List<ProductModel> PRODUCTS = <ProductModel>[
    ProductModel(
      name: "Sketchy Dreams Bamboo",
      images: [PRODUCT1, PRODUCT2],
      sizes: ["36-40", "40-44"],
      price: 249.0,
      availableSizes: ["36-40", "40-44"],
      quantity: 25,
    ),
    ProductModel(
      name: "Dark Matter",
      images: [PRODUCT3, PRODUCT4],
      sizes: ["36-40", "40-44"],
      price: 149.0,
      availableSizes: ["36-40", "40-44"],
      quantity: 76,
    ),
    ProductModel(
      name: "Sketchy Dreams",
      images: [PRODUCT5, PRODUCT6, PRODUCT7],
      sizes: ["S", "M", "L", "XL"],
      price: 549.0,
      availableSizes: ["S", "L", "XL"],
      quantity: 4,
    ),
  ];

  static List<OrderModel> ORDERS = <OrderModel>[
    OrderModel(
      number: 111111,
      date: DateTime.now(),
      status: OrderStatus.Pending,
      count: PRODUCTS.length,
      price: PRODUCTS.fold(0.0, (a, b) => a + b.price),
      products: PRODUCTS,
    ),
    OrderModel(
      number: 123456,
      date: DateTime.now().add(const Duration(days: -2)),
      status: OrderStatus.Delivered,
      count: PRODUCTS.length,
      price: PRODUCTS.fold(0.0, (a, b) => a + b.price),
      products: PRODUCTS,
    ),
  ];

  static ProfileModel USER = ProfileModel(
    id: 1,
    name: "Samet",
    surname: "Eyisan",
    username: "sameteyisan",
    email: "sameteyisannn@gmail.com",
    password: "123456",
    electronicMessages: true,
  );

  static List<AddressModel> ADDRESSES = <AddressModel>[
    AddressModel(
      id: 0,
      name: "Samet",
      surname: "Eyisan",
      city: CityModel(id: 34, name: "İSTANBUL"),
      county: CountyModel(id: 2015, cityID: 34, name: "TUZLA"),
      address: "Bilmemne mahallesi Dahabaşka sokak No: 3, Daire: 2",
      postcode: "34953",
      phone: "05419403812",
      byDefault: true,
    ),
  ];

  static List<MiniProductModel> WOMEN_PRODUCTS = <MiniProductModel>[
    MiniProductModel(
      name: "Toco Toucan",
      images: [WOMEN1, WOMEN2],
      price: 449,
    ),
    MiniProductModel(
      name: "Lazy Panda",
      images: [WOMEN3, WOMEN4],
      price: 449,
    ),
    MiniProductModel(
      name: "Hippotify",
      images: [WOMEN5, WOMEN6],
      price: 449,
    ),
    MiniProductModel(
      name: "Friendly Cactus",
      images: [WOMEN7, WOMEN8],
      price: 449,
    ),
  ];

  static List<CategoryModel> DRAWER_CATEGORIES = <CategoryModel>[
    CategoryModel(
      name: "Kadın",
      subCategories: [
        CategoryModel(name: "İç Çamaşırı", subCategories: [
          CategoryModel(name: "Cheeky"),
          CategoryModel(name: "Hipster"),
          CategoryModel(name: "Tanga"),
        ]),
        CategoryModel(
          name: "Çorap",
          subCategories: [
            CategoryModel(name: "Bambu"),
            CategoryModel(name: "Pamuk"),
          ],
        ),
      ],
    ),
    CategoryModel(
      name: "Erkek",
      subCategories: [
        CategoryModel(name: "Bambu"),
        CategoryModel(name: "Çorap"),
        CategoryModel(
          name: "Çorap",
          subCategories: [
            CategoryModel(name: "Pamuk"),
          ],
        ),
      ],
    ),
    CategoryModel(name: "Couple packs"),
    CategoryModel(name: "hippopacks"),
    CategoryModel(name: "Beden Ölçüleri"),
    CategoryModel(name: "hippopets"),
    CategoryModel(
      name: "Hakkımızda",
      subCategories: [
        CategoryModel(name: "Biz Kimiz?"),
        CategoryModel(name: "SSS"),
        CategoryModel(name: "Bize Ulaşın"),
      ],
    ),
  ];
}

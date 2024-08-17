import 'package:hippopants/models/promotion_model.dart';

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
}

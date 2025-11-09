# Flutter eCommerce Application - เอกสารภาษาไทย

## 📱 รายละเอียดโครงการ

แอปพลิเคชัน Flutter eCommerce เป็นแอปร้านค้าออนไลน์ที่พัฒนาด้วย Flutter โดยมีการออกแบบที่ทันสมัยและรองรับภาษาไทย

### ✨ คุณสมบัติหลัก
- 🛍️ ระบบจัดการสินค้าและตะกร้า
- 🎨 ธีมสีชมพู-ม่วงสวยงาม
- 🔄 แบนเนอร์โปรโมชั่นเลื่อนอัตโนมัติ
- 📱 รองรับทุกแพลตฟอร์ม (iOS, Android, Web)
- 🇹🇭 รองรับฟอนต์ภาษาไทย (Kanit)

## 🏗️ โครงสร้างโค้ดและ Widgets

### 📄 ไฟล์หลัก (main.dart)

```dart
void main() {
  runApp(const MyApp());
}
```

**คำอธิบาย:**
- `MyApp` เป็น root widget ของแอปพลิเคชัน
- ใช้ `MultiProvider` สำหรับจัดการ state ทั่วทั้งแอป
- กำหนดธีมสีและฟอนต์ Kanit

**Widgets ที่ใช้:**
- `MaterialApp`: Widget หลักของ Material Design
- `MultiProvider`: จัดการ state providers หลายตัว
- `ChangeNotifierProvider`: ให้ state management pattern

### 🏠 หน้าหลัก (HomeScreen)

**ตำแหน่ง:** `lib/screens/home/home_screen.dart`

```dart
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(...),
      body: SingleChildScrollView(...),
      bottomNavigationBar: BottomNavigationBar(...),
    );
  }
}
```

**Widgets หลักที่ใช้:**

#### 1. AppBar แบบ Gradient
```dart
AppBar(
  flexibleSpace: Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.pink.shade300, Colors.purple.shade400],
      ),
    ),
  ),
)
```
- สร้างแถบด้านบนที่มีสีไล่โทน
- ใช้ `LinearGradient` สำหรับเอฟเฟกต์สีไล่

#### 2. BottomNavigationBar
```dart
BottomNavigationBar(
  type: BottomNavigationBarType.fixed,
  selectedItemColor: Colors.pink.shade400,
  items: [...],
)
```
- แถบนำทางด้านล่างที่มี 4 เมนู
- เปลี่ยนสีเมื่อเลือกแท็บ

### 🛍️ หน้าสินค้า (ProductScreen)

**ตำแหน่ง:** `lib/screens/product/product_screen.dart`

#### 1. Auto-Slide Banner
```dart
class _ProductScreenState extends State<ProductScreen> {
  PageController _pageController = PageController();
  Timer? _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(Duration(seconds: 4), (timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }
}
```

**คำอธิบาย:**
- `PageController`: ควบคุมการเลื่อนของ PageView
- `Timer.periodic`: ตั้งเวลาเลื่อนอัตโนมัติทุก 4 วินาที
- `animateToPage`: สร้างแอนิเมชั่นเลื่อนหน้า

#### 2. Banner Container
```dart
Container(
  height: 180,
  margin: EdgeInsets.all(16),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.black26,
        blurRadius: 8,
        offset: Offset(0, 4),
      ),
    ],
  ),
  child: PageView(
    controller: _pageController,
    children: [
      _buildBannerItem("🎉 ลดราคาพิเศษ 50%", Colors.orange.shade400),
      _buildBannerItem("🚚 ส่งฟรีทั่วประเทศ", Colors.green.shade400),
      _buildBannerItem("💰 แลกคะแนนรับของรางวัล", Colors.blue.shade400),
    ],
  ),
),
```

**Widgets ที่ใช้:**
- `Container`: กำหนดขนาดและการตกแต่ง
- `BoxDecoration`: เพิ่มเงาและขอบมน
- `PageView`: สร้างหน้าเลื่อนได้
- `BorderRadius.circular()`: ทำขอบมน

#### 3. Page Indicators
```dart
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: List.generate(3, (index) {
    return Container(
      width: 8,
      height: 8,
      margin: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == index 
          ? Colors.pink.shade300 
          : Colors.grey.shade300,
      ),
    );
  }),
),
```

**คำอธิบาย:**
- แสดงจุดบอกตำแหน่งแบนเนอร์ปัจจุบัน
- ใช้ `List.generate()` สร้างจุดตามจำนวนแบนเนอร์
- เปลี่ยนสีตามหน้าที่แสดงอยู่

### 🛒 การ์ดสินค้า (ProductCard)

**ตำแหน่ง:** `lib/widgets/product_card.dart`

```dart
class ProductCard extends StatelessWidget {
  final Product product;
  
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(...),
    );
  }
}
```

#### 1. Hero Animation
```dart
Hero(
  tag: 'product-${product.id}',
  child: Container(
    height: 120,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      image: DecorationImage(
        image: AssetImage(product.imageUrl),
        fit: BoxFit.cover,
      ),
    ),
  ),
),
```

**คำอธิบาย:**
- `Hero`: สร้างแอนิเมชั่นเชื่อมต่อระหว่างหน้า
- `tag`: ระบุ widget ที่จะเชื่อมต่อกัน
- `DecorationImage`: แสดงภาพสินค้า

#### 2. Gradient Button
```dart
Material(
  color: Colors.transparent,
  child: InkWell(
    borderRadius: BorderRadius.circular(20),
    onTap: () {
      Provider.of<CartProvider>(context, listen: false)
          .addItem(product);
      _showSnackBar(context, product.name);
    },
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.pink.shade300, Colors.purple.shade400],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        'เพิ่มลงตะกร้า',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    ),
  ),
),
```

**Widgets ที่ใช้:**
- `Material` + `InkWell`: สร้างเอฟเฟกต์กด (ripple effect)
- `LinearGradient`: สีไล่โทนชมพู-ม่วง
- `Provider.of<CartProvider>()`: เข้าถึง state ตะกร้า

### 🛒 หน้าตะกร้า (CartScreen)

**ตำแหน่ง:** `lib/screens/cart/cart_screen.dart`

#### 1. Quantity Controls
```dart
Row(
  children: [
    _buildQuantityButton(
      icon: Icons.remove,
      onPressed: () => cartProvider.removeItem(item.product.id),
    ),
    Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '${item.quantity}',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    ),
    _buildQuantityButton(
      icon: Icons.add,
      onPressed: () => cartProvider.addItem(item.product),
    ),
  ],
),

Widget _buildQuantityButton({
  required IconData icon,
  required VoidCallback onPressed,
}) {
  return Material(
    color: Colors.transparent,
    child: InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onPressed,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pink.shade300, Colors.purple.shade400],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    ),
  );
}
```

**คำอธิบาย:**
- ปุ่มเพิ่ม/ลดจำนวนสินค้าแบบ gradient
- ใช้ `InkWell` เพื่อเอฟเฟกต์เมื่อกด
- แสดงจำนวนสินค้าในช่องกลาง

#### 2. Checkout Button
```dart
Container(
  width: double.infinity,
  height: 50,
  margin: EdgeInsets.all(16),
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [Colors.pink.shade400, Colors.purple.shade500],
    ),
    borderRadius: BorderRadius.circular(25),
    boxShadow: [
      BoxShadow(
        color: Colors.pink.shade200,
        blurRadius: 8,
        offset: Offset(0, 4),
      ),
    ],
  ),
  child: Material(
    color: Colors.transparent,
    child: InkWell(
      borderRadius: BorderRadius.circular(25),
      onTap: () {
        // ไปหน้าชำระเงิน
      },
      child: Center(
        child: Text(
          'ชำระเงิน (฿${totalPrice.toStringAsFixed(2)})',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  ),
),
```

### 👤 หน้าเข้าสู่ระบบ (LoginScreen)

**ตำแหน่ง:** `lib/screens/auth/login_screen.dart`

#### 1. Gradient Background
```dart
Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Colors.pink.shade300,
        Colors.purple.shade400,
        Colors.indigo.shade500,
      ],
    ),
  ),
),
```

#### 2. Login Form
```dart
Container(
  margin: EdgeInsets.symmetric(horizontal: 32),
  padding: EdgeInsets.all(24),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: Colors.black26,
        blurRadius: 10,
        offset: Offset(0, 5),
      ),
    ],
  ),
  child: Column(
    children: [
      _buildTextField('อีเมล', Icons.email),
      SizedBox(height: 16),
      _buildTextField('รหัสผ่าน', Icons.lock, isPassword: true),
      SizedBox(height: 24),
      _buildLoginButton(),
    ],
  ),
),
```

## 🔧 State Management

### 1. AuthProvider
```dart
class AuthProvider with ChangeNotifier {
  User? _user;
  bool _isLoading = false;
  
  User? get user => _user;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _user != null;
  
  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    
    // จำลองการเข้าสู่ระบบ
    await Future.delayed(Duration(seconds: 2));
    
    _user = User(
      id: '1',
      name: 'ผู้ใช้ทดสอบ',
      email: email,
    );
    
    _isLoading = false;
    notifyListeners();
  }
}
```

### 2. CartProvider
```dart
class CartProvider with ChangeNotifier {
  List<CartItem> _items = [];
  
  List<CartItem> get items => _items;
  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);
  double get totalPrice => _items.fold(0, (sum, item) => sum + (item.product.price * item.quantity));
  
  void addItem(Product product) {
    int existingIndex = _items.indexWhere((item) => item.product.id == product.id);
    
    if (existingIndex >= 0) {
      _items[existingIndex].quantity++;
    } else {
      _items.add(CartItem(product: product, quantity: 1));
    }
    
    notifyListeners();
  }
}
```

### 3. ProductProvider
```dart
class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  String _selectedCategory = 'ทั้งหมด';
  
  List<Product> get products {
    if (_selectedCategory == 'ทั้งหมด') {
      return _products;
    }
    return _products.where((product) => product.category == _selectedCategory).toList();
  }
  
  void filterByCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }
}
```

## 🎨 การใช้งาน Themes และ Colors

### Material 3 Color Scheme
```dart
MaterialApp(
  theme: ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.pink,
      brightness: Brightness.light,
    ),
    fontFamily: 'Kanit',
  ),
)
```

### Gradient Colors
```dart
// Pink-Purple Gradient
LinearGradient(
  colors: [Colors.pink.shade300, Colors.purple.shade400],
)

// Extended Gradient
LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Colors.pink.shade300,
    Colors.purple.shade400,
    Colors.indigo.shade500,
  ],
)
```

## 📱 การใช้งาน Animations

### 1. Hero Animations
```dart
// ใน ProductCard
Hero(
  tag: 'product-${product.id}',
  child: Image.asset(product.imageUrl),
)

// ในหน้ารายละเอียดสินค้า
Hero(
  tag: 'product-${product.id}',
  child: Image.asset(product.imageUrl),
)
```

### 2. Page Transitions
```dart
PageController _pageController = PageController();

_pageController.animateToPage(
  _currentPage,
  duration: Duration(milliseconds: 300),
  curve: Curves.easeInOut,
);
```

## 🔧 วิธีการติดตั้งและใช้งาน

### 1. ติดตั้ง Dependencies
```bash
flutter pub get
```

### 2. รันแอปพลิเคชัน
```bash
flutter run
```

### 3. Build สำหรับ Production
```bash
# Android
flutter build apk --release

# iOS
flutter build ios --release

# Web
flutter build web --release
```

## 📚 แหล่งข้อมูลเพิ่มเติม

- [Flutter Documentation](https://docs.flutter.dev/)
- [Material Design 3](https://m3.material.io/)
- [Provider Package](https://pub.dev/packages/provider)
- [Kanit Font](https://fonts.google.com/specimen/Kanit)

## 🤝 การพัฒนาต่อ

### แนวทางการเพิ่มฟีเจอร์:
1. **ระบบการชำระเงิน**: เชื่อมต่อ Payment Gateway
2. **ระบบรีวิว**: เพิ่มการให้คะแนนและรีวิวสินค้า
3. **ระบบแจ้งเตือน**: Push Notifications
4. **ฐานข้อมูล**: เชื่อมต่อ Firebase หรือ API
5. **การค้นหา**: ระบบค้นหาสินค้าขั้นสูง

---

📝 **หมายเหตุ:** เอกสารนี้อธิบายการใช้งาน widgets และ patterns หลักในแอปพลิเคชัน Flutter eCommerce นี้ สำหรับรายละเอียดเพิ่มเติม กรุณาดูที่โค้ดในแต่ละไฟล์
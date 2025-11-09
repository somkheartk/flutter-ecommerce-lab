# Widget Usage Guide - คู่มือการใช้งาน Widgets

## 📋 สารบัญ
1. [Layout Widgets](#layout-widgets)
2. [Input Widgets](#input-widgets)
3. [Display Widgets](#display-widgets)
4. [Interactive Widgets](#interactive-widgets)
5. [Animation Widgets](#animation-widgets)
6. [Custom Widgets](#custom-widgets)

---

## 🏗️ Layout Widgets

### 1. Container
**การใช้งาน:** สร้างกล่องที่สามารถกำหนดขนาด สี และการตกแต่งได้

```dart
Container(
  width: 200,           // ความกว้าง
  height: 100,          // ความสูง
  padding: EdgeInsets.all(16),     // ระยะห่างด้านใน
  margin: EdgeInsets.all(8),       // ระยะห่างด้านนอก
  decoration: BoxDecoration(
    color: Colors.blue,            // สีพื้นหลัง
    borderRadius: BorderRadius.circular(12), // ขอบมน
    boxShadow: [                   // เงา
      BoxShadow(
        color: Colors.black26,
        blurRadius: 8,
        offset: Offset(0, 4),
      ),
    ],
  ),
  child: Text('เนื้อหา'),
)
```

**ตัวอย่างการใช้งานในแอป:**
- การสร้างการ์ดสินค้า
- พื้นหลังของฟอร์ม
- ปุ่มที่มีการตกแต่งพิเศษ

### 2. Row และ Column
**การใช้งาน:** จัดเรียง widgets ในแนวนอน (Row) และแนวตั้ง (Column)

```dart
// Row - จัดเรียงแนวนอน
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween, // การจัดแนวหลัก
  crossAxisAlignment: CrossAxisAlignment.center,     // การจัดแนวไขว้
  children: [
    Icon(Icons.star),
    Text('4.5'),
    Text('รีวิว 120 ครั้ง'),
  ],
)

// Column - จัดเรียงแนวตั้ง
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text('ชื่อสินค้า', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    SizedBox(height: 8),
    Text('รายละเอียดสินค้า'),
    SizedBox(height: 16),
    Text('฿299', style: TextStyle(color: Colors.red, fontSize: 16)),
  ],
)
```

### 3. Stack
**การใช้งาน:** วาง widgets ทับซ้อนกัน

```dart
Stack(
  children: [
    // พื้นหลัง
    Container(
      width: 200,
      height: 150,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/product.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    ),
    // ป้ายลด
    Positioned(
      top: 8,
      right: 8,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text('ลด 50%', style: TextStyle(color: Colors.white)),
      ),
    ),
  ],
)
```

### 4. Expanded และ Flexible
**การใช้งาน:** ควบคุมการขยายของ widgets ใน Row/Column

```dart
Row(
  children: [
    Container(
      width: 60,
      height: 60,
      child: Image.asset('product.jpg'),
    ),
    SizedBox(width: 12),
    Expanded(           // ขยายเต็มพื้นที่ที่เหลือ
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('ชื่อสินค้า'),
          Text('รายละเอียด'),
        ],
      ),
    ),
    Text('฿299'),      // ขนาดคงที่
  ],
)
```

---

## 📝 Input Widgets

### 1. TextField
**การใช้งาน:** รับข้อมูลที่ผู้ใช้พิมพ์

```dart
TextField(
  controller: _emailController,    // ควบคุมข้อความ
  keyboardType: TextInputType.emailAddress, // ประเภทคีย์บอร์ด
  decoration: InputDecoration(
    labelText: 'อีเมล',           // ข้อความบอกใบ
    hintText: 'กรอกอีเมลของคุณ',   // ข้อความแนะนำ
    prefixIcon: Icon(Icons.email), // ไอคอนด้านหน้า
    border: OutlineInputBorder(    // เส้นขอบ
      borderRadius: BorderRadius.circular(12),
    ),
    filled: true,                  // พื้นหลังสี
    fillColor: Colors.grey.shade100,
  ),
  validator: (value) {             // ตรวจสอบข้อมูล
    if (value == null || value.isEmpty) {
      return 'กรุณากรอกอีเมล';
    }
    return null;
  },
)
```

### 2. DropdownButton
**การใช้งาน:** เลือกจากรายการตัวเลือก

```dart
DropdownButton<String>(
  value: _selectedCategory,
  hint: Text('เลือกหมวดหมู่'),
  items: ['ทั้งหมด', 'เสื้อผ้า', 'กระเป๋า', 'รองเท้า']
      .map((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    );
  }).toList(),
  onChanged: (String? newValue) {
    setState(() {
      _selectedCategory = newValue!;
    });
  },
)
```

### 3. Checkbox และ Switch
**การใช้งาน:** เลือกตัวเลือกแบบ true/false

```dart
// Checkbox
CheckboxListTile(
  title: Text('จดจำการเข้าสู่ระบบ'),
  value: _rememberMe,
  onChanged: (bool? value) {
    setState(() {
      _rememberMe = value ?? false;
    });
  },
  controlAffinity: ListTileControlAffinity.leading, // ตำแหน่งของ checkbox
)

// Switch
SwitchListTile(
  title: Text('การแจ้งเตือน'),
  value: _notifications,
  onChanged: (bool value) {
    setState(() {
      _notifications = value;
    });
  },
)
```

---

## 🖼️ Display Widgets

### 1. Text และ RichText
**การใช้งาน:** แสดงข้อความ

```dart
// Text ธรรมดา
Text(
  'ชื่อสินค้า',
  style: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
    fontFamily: 'Kanit',
  ),
)

// RichText - ข้อความหลายสไตล์
RichText(
  text: TextSpan(
    style: TextStyle(color: Colors.black),
    children: [
      TextSpan(text: 'ราคา: '),
      TextSpan(
        text: '฿299',
        style: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      TextSpan(text: ' '),
      TextSpan(
        text: '฿399',
        style: TextStyle(
          decoration: TextDecoration.lineThrough,
          color: Colors.grey,
        ),
      ),
    ],
  ),
)
```

### 2. Image
**การใช้งาน:** แสดงรูปภาพ

```dart
// รูปจาก Assets
Image.asset(
  'assets/images/product.jpg',
  width: 150,
  height: 150,
  fit: BoxFit.cover,        // การปรับขนาด
)

// รูปจากเครือข่าย
Image.network(
  'https://example.com/image.jpg',
  loadingBuilder: (context, child, loadingProgress) {
    if (loadingProgress == null) return child;
    return CircularProgressIndicator();  // แสดงตอนโหลด
  },
  errorBuilder: (context, error, stackTrace) {
    return Icon(Icons.error);           // แสดงตอนเกิดข้อผิดพลาด
  },
)

// รูปแบบ Circular
CircleAvatar(
  radius: 30,
  backgroundImage: AssetImage('assets/images/avatar.jpg'),
  child: Text('A'),  // ข้อความเมื่อไม่มีรูป
)
```

### 3. Icon
**การใช้งาน:** แสดงไอคอน

```dart
// ไอคอน Material
Icon(
  Icons.shopping_cart,
  color: Colors.pink,
  size: 24,
)

// ไอคอนพร้อม Badge
Stack(
  children: [
    Icon(Icons.shopping_cart, size: 30),
    Positioned(
      right: 0,
      top: 0,
      child: Container(
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          '3',
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
    ),
  ],
)
```

---

## 🖱️ Interactive Widgets

### 1. ElevatedButton และ TextButton
**การใช้งาน:** ปุ่มกด

```dart
// ปุ่มยกระดับ
ElevatedButton(
  onPressed: () {
    // การทำงานเมื่อกด
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.pink,    // สีพื้นหลัง
    foregroundColor: Colors.white,   // สีข้อความ
    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
  child: Text('เพิ่มลงตะกร้า'),
)

// ปุ่มข้อความ
TextButton(
  onPressed: () {},
  child: Text('ยกเลิก'),
)

// ปุ่ม Gradient แบบกำหนดเอง
Material(
  color: Colors.transparent,
  child: InkWell(
    borderRadius: BorderRadius.circular(25),
    onTap: () {},
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.pink.shade300, Colors.purple.shade400],
        ),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Text(
        'ชำระเงิน',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    ),
  ),
)
```

### 2. InkWell และ GestureDetector
**การใช้งาน:** จัดการการสัมผัส

```dart
// InkWell - มี ripple effect
InkWell(
  borderRadius: BorderRadius.circular(12),
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProductDetailScreen()),
    );
  },
  child: Container(
    padding: EdgeInsets.all(16),
    child: Text('คลิกเพื่อดูรายละเอียด'),
  ),
)

// GestureDetector - การสัมผัสแบบละเอียด
GestureDetector(
  onTap: () {},                    // คลิกเดียว
  onDoubleTap: () {},              // คลิกคู่
  onLongPress: () {},              // กดค้าง
  onPanUpdate: (details) {},       // ลาก
  child: Container(
    width: 100,
    height: 100,
    color: Colors.blue,
    child: Center(child: Text('สัมผัสได้')),
  ),
)
```

### 3. ListTile
**การใช้งาน:** รายการแบบมาตรฐาน

```dart
ListTile(
  leading: CircleAvatar(           // ไอคอนด้านหน้า
    child: Icon(Icons.person),
  ),
  title: Text('ชื่อผู้ใช้'),          // หัวข้อหลัก
  subtitle: Text('อีเมล: user@example.com'), // หัวข้อรอง
  trailing: Icon(Icons.arrow_forward_ios),   // ไอคอนท้าย
  onTap: () {
    // ทำงานเมื่อคลิก
  },
)
```

---

## 🎬 Animation Widgets

### 1. Hero
**การใช้งาน:** แอนิเมชั่นระหว่างหน้า

```dart
// หน้าแรก
Hero(
  tag: 'product-image-${product.id}',
  child: Image.asset(
    product.imageUrl,
    width: 100,
    height: 100,
  ),
)

// หน้าปลายทาง
Hero(
  tag: 'product-image-${product.id}',  // tag เดียวกัน
  child: Image.asset(
    product.imageUrl,
    width: 300,
    height: 300,
  ),
)
```

### 2. AnimatedContainer
**การใช้งาน:** แอนิเมชั่นการเปลี่ยนแปลง

```dart
AnimatedContainer(
  duration: Duration(milliseconds: 300),
  width: _isExpanded ? 200 : 100,
  height: _isExpanded ? 200 : 100,
  decoration: BoxDecoration(
    color: _isExpanded ? Colors.blue : Colors.red,
    borderRadius: BorderRadius.circular(_isExpanded ? 20 : 10),
  ),
  child: Center(child: Text('แอนิเมชั่น')),
)
```

### 3. FadeTransition
**การใช้งาน:** แอนิเมชั่นจางหาย

```dart
class FadeExample extends StatefulWidget {
  @override
  _FadeExampleState createState() => _FadeExampleState();
}

class _FadeExampleState extends State<FadeExample>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller!);
    _controller!.forward();  // เริ่มแอนิเมชั่น
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation!,
      child: Container(
        width: 200,
        height: 200,
        color: Colors.blue,
        child: Center(child: Text('จางเข้า')),
      ),
    );
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }
}
```

---

## 🎨 Custom Widgets

### 1. StatelessWidget
**การใช้งาน:** Widget ที่ไม่เปลี่ยนแปลง

```dart
class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;

  const ProductCard({
    Key? key,
    required this.product,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // รูปภาพสินค้า
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(
                product.imageUrl,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    '฿${product.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// การใช้งาน
ProductCard(
  product: product,
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailScreen(product: product),
      ),
    );
  },
)
```

### 2. StatefulWidget
**การใช้งาน:** Widget ที่มีการเปลี่ยนแปลง state

```dart
class QuantitySelector extends StatefulWidget {
  final int initialValue;
  final Function(int) onChanged;
  final int min;
  final int max;

  const QuantitySelector({
    Key? key,
    required this.initialValue,
    required this.onChanged,
    this.min = 1,
    this.max = 99,
  }) : super(key: key);

  @override
  _QuantitySelectorState createState() => _QuantitySelectorState();
}

class _QuantitySelectorState extends State<QuantitySelector> {
  late int _quantity;

  @override
  void initState() {
    super.initState();
    _quantity = widget.initialValue;
  }

  void _increment() {
    if (_quantity < widget.max) {
      setState(() {
        _quantity++;
      });
      widget.onChanged(_quantity);
    }
  }

  void _decrement() {
    if (_quantity > widget.min) {
      setState(() {
        _quantity--;
      });
      widget.onChanged(_quantity);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildButton(Icons.remove, _decrement, _quantity <= widget.min),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          margin: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '$_quantity',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
        _buildButton(Icons.add, _increment, _quantity >= widget.max),
      ],
    );
  }

  Widget _buildButton(IconData icon, VoidCallback onPressed, bool disabled) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: disabled ? null : onPressed,
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            gradient: disabled 
                ? null 
                : LinearGradient(
                    colors: [Colors.pink.shade300, Colors.purple.shade400],
                  ),
            color: disabled ? Colors.grey.shade300 : null,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(
            icon, 
            color: disabled ? Colors.grey.shade500 : Colors.white, 
            size: 18,
          ),
        ),
      ),
    );
  }
}

// การใช้งาน
QuantitySelector(
  initialValue: 1,
  min: 1,
  max: 10,
  onChanged: (quantity) {
    print('จำนวนที่เลือก: $quantity');
  },
)
```

### 3. Custom Button Widget
**การใช้งาน:** ปุ่มที่กำหนดเองแบบ reusable

```dart
class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final List<Color>? gradientColors;
  final double? width;
  final double height;
  final double borderRadius;
  final TextStyle? textStyle;
  final Widget? icon;

  const GradientButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.gradientColors,
    this.width,
    this.height = 48,
    this.borderRadius = 24,
    this.textStyle,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = gradientColors ?? [
      Colors.pink.shade300,
      Colors.purple.shade400,
    ];

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: onPressed != null 
            ? LinearGradient(colors: colors)
            : null,
        color: onPressed == null ? Colors.grey.shade300 : null,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: onPressed != null ? [
          BoxShadow(
            color: colors.first.withOpacity(0.3),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ] : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius),
          onTap: onPressed,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  icon!,
                  SizedBox(width: 8),
                ],
                Text(
                  text,
                  style: textStyle ?? TextStyle(
                    color: onPressed != null ? Colors.white : Colors.grey.shade600,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// การใช้งาน
GradientButton(
  text: 'เพิ่มลงตะกร้า',
  onPressed: () {
    // ทำงานเมื่อกดปุ่ม
  },
  icon: Icon(Icons.shopping_cart, color: Colors.white),
  width: double.infinity,
)

GradientButton(
  text: 'ชำระเงิน',
  onPressed: null, // ปิดการใช้งาน
  gradientColors: [Colors.green.shade300, Colors.teal.shade400],
)
```

## 📱 Tips การใช้งาน

### 1. การจัดการ State
```dart
// ใช้ setState สำหรับ local state
setState(() {
  _counter++;
});

// ใช้ Provider สำหรับ global state
Provider.of<CartProvider>(context, listen: false).addItem(product);

// ใช้ Consumer สำหรับอัพเดท UI
Consumer<CartProvider>(
  builder: (context, cart, child) {
    return Text('จำนวนสินค้า: ${cart.itemCount}');
  },
)
```

### 2. การจัดการหน่วยความจำ
```dart
@override
void dispose() {
  _controller?.dispose();     // ทำลาย AnimationController
  _textController.dispose();  // ทำลาย TextEditingController
  _timer?.cancel();          // ยกเลิก Timer
  super.dispose();
}
```

### 3. การใช้ Keys
```dart
// สำหรับ Form validation
final _formKey = GlobalKey<FormState>();

Form(
  key: _formKey,
  child: Column(...),
)

// สำหรับเข้าถึง widget จากภายนอก
final _scaffoldKey = GlobalKey<ScaffoldState>();

Scaffold(
  key: _scaffoldKey,
  body: ...,
)

_scaffoldKey.currentState?.openDrawer();
```

---

📝 **หมายเหตุ:** คู่มือนี้ครอบคลุม widgets หลักที่ใช้ในแอปพลิเคชัน Flutter eCommerce พร้อมตัวอย่างการใช้งานจริง สำหรับรายละเอียดเพิ่มเติมสามารถศึกษาได้จาก [Flutter Documentation](https://docs.flutter.dev/)
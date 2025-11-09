import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider.dart';

/// CartScreen - หน้าแสดงรายการสินค้าในตะกร้า
///
/// หน้านี้แสดง:
/// - รายการสินค้าทั้งหมดในตะกร้า
/// - ปรับจำนวนสินค้าแต่ละรายการ
/// - ลบสินค้าออกจากตะกร้า
/// - ราคารวมทั้งหมด
/// - ปุ่มสั่งซื้อ (demo)
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ตะกร้าสินค้า',
          style: TextStyle(fontFamily: 'Kanit', fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          if (cartProvider.items.isEmpty) {
            return _buildEmptyCart(context);
          }

          return Column(
            children: [
              // Cart items list
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: cartProvider.items.length,
                  itemBuilder: (context, index) {
                    final cartItem = cartProvider.items[index];
                    return _buildCartItem(context, cartItem, cartProvider);
                  },
                ),
              ),

              // Total and checkout section
              _buildCheckoutSection(context, cartProvider),
            ],
          );
        },
      ),
    );
  }

  /// สร้าง UI เมื่อตะกร้าว่าง
  Widget _buildEmptyCart(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.1),
            Colors.white,
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                Icons.shopping_cart_outlined,
                size: 80,
                color: Colors.grey[400],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'ตะกร้าสินค้าว่างเปล่า',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Kanit',
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'เริ่มช้อปปิ้งและเพิ่มสินค้าลงในตะกร้ากันเถอะ!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Kanit',
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.shopping_bag),
              label: const Text(
                'เริ่มช้อปปิ้ง',
                style: TextStyle(fontFamily: 'Kanit', fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// สร้าง UI สำหรับรายการสินค้าในตะกร้า
  Widget _buildCartItem(
    BuildContext context,
    cartItem,
    CartProvider cartProvider,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            spreadRadius: 0,
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            spreadRadius: 0,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Product image with modern design
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.grey[50]!, Colors.white],
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.grey.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Image.network(
                    cartItem.product.image,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(
                          Icons.image_not_supported_rounded,
                          size: 40,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),

            // Product details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product title
                  Text(
                    cartItem.product.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Kanit',
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),

                  // Price per unit
                  Text(
                    '฿${(cartItem.product.price * 33).toStringAsFixed(0)} / ชิ้น',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      fontFamily: 'Kanit',
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Total price for this item with enhanced design
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.pink.withOpacity(0.1),
                          Colors.purple.withOpacity(0.1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.pink.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      'รวม ฿${cartItem.totalPriceInBaht.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink,
                        fontFamily: 'Kanit',
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Quantity controls and remove button
            Column(
              children: [
                // Remove button
                IconButton(
                  onPressed: () {
                    _showRemoveDialog(context, cartItem, cartProvider);
                  },
                  icon: Icon(
                    Icons.delete_outline,
                    color: Colors.red[400],
                    size: 20,
                  ),
                  tooltip: 'ลบสินค้า',
                ),

                // Quantity controls with beautiful gradient design
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.pink.shade400, Colors.purple.shade400],
                    ),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.pink.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Decrease button
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () =>
                              cartProvider.decreaseQuantity(cartItem.product),
                          borderRadius: BorderRadius.circular(25),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: const Icon(
                              Icons.remove_rounded,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      // Quantity display
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          '${cartItem.quantity}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Kanit',
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      // Increase button
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () =>
                              cartProvider.increaseQuantity(cartItem.product),
                          borderRadius: BorderRadius.circular(25),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: const Icon(
                              Icons.add_rounded,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// สร้าง UI ส่วนสรุปราคาและปุ่มสั่งซื้อ
  Widget _buildCheckoutSection(
    BuildContext context,
    CartProvider cartProvider,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Order summary
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'จำนวนสินค้า:',
                style: TextStyle(fontSize: 16, fontFamily: 'Kanit'),
              ),
              Text(
                '${cartProvider.itemCount} ชิ้น',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Kanit',
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'ราคารวม:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Kanit',
                ),
              ),
              Text(
                '฿${cartProvider.totalPriceInBaht.toStringAsFixed(0)}',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                  fontFamily: 'Kanit',
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Beautiful Checkout button
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.pink.shade400, Colors.purple.shade400],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.pink.withOpacity(0.4),
                  spreadRadius: 2,
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  _showCheckoutDialog(context, cartProvider);
                },
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.payment_rounded,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'สั่งซื้อสินค้า (฿${cartProvider.totalPriceInBaht.toStringAsFixed(0)})',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Kanit',
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// แสดง Dialog ยืนยันการลบสินค้า
  void _showRemoveDialog(
    BuildContext context,
    cartItem,
    CartProvider cartProvider,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'ลบสินค้า',
          style: TextStyle(fontFamily: 'Kanit', fontWeight: FontWeight.bold),
        ),
        content: Text(
          'คุณต้องการลบ "${cartItem.product.title}" ออกจากตะกร้าหรือไม่?',
          style: const TextStyle(fontFamily: 'Kanit'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('ยกเลิก', style: TextStyle(fontFamily: 'Kanit')),
          ),
          TextButton(
            onPressed: () {
              cartProvider.removeItem(cartItem.product);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'ลบสินค้าออกจากตะกร้าแล้ว',
                    style: TextStyle(fontFamily: 'Kanit'),
                  ),
                ),
              );
            },
            child: const Text(
              'ลบ',
              style: TextStyle(fontFamily: 'Kanit', color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  /// แสดง Dialog สั่งซื้อ
  void _showCheckoutDialog(BuildContext context, CartProvider cartProvider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'สั่งซื้อสินค้า',
          style: TextStyle(fontFamily: 'Kanit', fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'ขอบคุณสำหรับการสั่งซื้อ!',
              style: TextStyle(fontFamily: 'Kanit', fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              'จำนวนสินค้า: ${cartProvider.itemCount} ชิ้น',
              style: const TextStyle(fontFamily: 'Kanit'),
            ),
            Text(
              'ราคารวม: ฿${cartProvider.totalPriceInBaht.toStringAsFixed(0)}',
              style: TextStyle(
                fontFamily: 'Kanit',
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'นี่เป็นเพียงการสาธิต ระบบยังไม่ได้เชื่อมต่อกับระบบการชำระเงินจริง',
              style: TextStyle(
                fontFamily: 'Kanit',
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('ยกเลิก', style: TextStyle(fontFamily: 'Kanit')),
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                // Clear cart first
                cartProvider.clearCart();

                // Close dialog
                Navigator.of(context).pop();

                // Show success message
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'สั่งซื้อสำเร็จ! ขอบคุณครับ',
                      style: TextStyle(fontFamily: 'Kanit'),
                    ),
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 3),
                  ),
                );

                // Wait a bit and navigate back to home if needed
                await Future.delayed(const Duration(milliseconds: 100));
                if (context.mounted && Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                }
              } catch (e) {
                // Handle any errors
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'เกิดข้อผิดพลาด กรุณาลองใหม่',
                      style: TextStyle(fontFamily: 'Kanit'),
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: const Text(
              'ยืนยันการสั่งซื้อ',
              style: TextStyle(fontFamily: 'Kanit'),
            ),
          ),
        ],
      ),
    );
  }
}

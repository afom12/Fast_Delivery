// lib/screens/payment/payment_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/food_model.dart';
import '../../services/order_service.dart';
import '../../widgets/custom_button.dart';

class PaymentScreen extends StatelessWidget {
  PaymentScreen({Key? key}) : super(key: key);
  
  final OrderService orderService = Get.find<OrderService>();
  
  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>;
    final FoodModel food = args['food'];
    final int quantity = args['quantity'];
    final double total = args['total'];
    
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            // Back Button and Title
            Row(
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: const Icon(Icons.arrow_back_ios_new, size: 16),
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  'Payment',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Order Info
            Text(
              'Item Ordered',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(food.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        food.name,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '\$${food.price.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '$quantity items',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            const Divider(thickness: 1),
            const SizedBox(height: 24),
            
            // Details
            Text(
              'Details Transaction',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _buildDetailItem(context, food.name, '\$${(food.price * quantity).toStringAsFixed(2)}'),
            _buildDetailItem(context, 'Driver', '\$${0.50.toStringAsFixed(2)}'),
            _buildDetailItem(context, 'Tax 10%', '\$${(total * 0.1).toStringAsFixed(2)}'),
            _buildDetailItem(
              context,
              'Total',
              '\$${(total + 0.50 + (total * 0.1)).toStringAsFixed(2)}',
              isTotal: true,
            ),
            
            const SizedBox(height: 24),
            const Divider(thickness: 1),
            const SizedBox(height: 24),
            
            // Delivery
            Text(
              'Deliver to',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _buildDetailItem(context, 'Name', 'Aishfa Sheikh'),
            _buildDetailItem(context, 'Phone', '+1 234 5678 900'),
            _buildDetailItem(context, 'Address', '123 Main Street, New York, USA'),
            _buildDetailItem(context, 'House No.', '42'),
            _buildDetailItem(context, 'City', 'New York'),
            
            const SizedBox(height: 24),
            const Divider(thickness: 1),
            const SizedBox(height: 24),
            
            // Payment Method
            Text(
              'Payment Method',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/cash.png',
                    width: 40,
                    height: 40,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Cash on Delivery',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Radio(
                    value: true,
                    groupValue: true,
                    onChanged: (value) {},
                    activeColor: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Checkout Button
            CustomButton(
              text: 'Checkout Now',
              onPressed: () => _placeOrder(context, food, quantity, total),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(BuildContext context, String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: isTotal ? Colors.black : Colors.grey,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: isTotal ? Theme.of(context).primaryColor : Colors.black,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  void _placeOrder(BuildContext context, FoodModel food, int quantity, double total) async {
    try {
      await orderService.createOrder(
        food: food,
        quantity: quantity,
        total: total,
        deliveryAddress: '123 Main Street, New York, USA',
      );
      
      Get.offAllNamed('/order-success');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../services/auth_service.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class AddressScreen extends StatelessWidget {
  AddressScreen({Key? key}) : super(key: key);
  
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController houseController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final AuthService authService = Get.find<AuthService>();
  final RxString selectedLocationType = 'Home'.obs;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = Get.arguments as Map<String, dynamic>;
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back Button
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, size: 20),
                  onPressed: () => Get.back(),
                ),
              ),
              
              // Header
              const SizedBox(height: 16),
              Text(
                'Delivery Address',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Where should we deliver your food?',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              
              // User Info
              const SizedBox(height: 32),
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                          image: NetworkImage('https://randomuser.me/api/portraits/women/44.jpg'),
                          fit: BoxFit.cover,
                        ),
                        border: Border.all(
                          color: Theme.of(context).primaryColor.withOpacity(0.2),
                          width: 2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      args['name'],
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      args['email'],
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              
              // Location Type
              const SizedBox(height: 32),
              Text(
                'Location Type',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Obx(() => Row(
                children: [
                  Expanded(
                    child: _buildLocationTypeButton('Home', Icons.home_outlined),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildLocationTypeButton('Work', Icons.work_outline),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildLocationTypeButton('Other', Icons.location_on_outlined),
                  ),
                ],
              )),
              
              // Address Form
              const SizedBox(height: 24),
              CustomTextField(
                label: 'Phone Number',
                controller: phoneController,
                hintText: 'Enter your phone number',
                prefixIcon: Icons.phone_android_outlined,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              
              CustomTextField(
                label: 'Address',
                controller: addressController,
                hintText: 'Enter your full address',
                prefixIcon: Icons.location_on_outlined,
              ),
              const SizedBox(height: 16),
              
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: CustomTextField(
                      label: 'House No.',
                      controller: houseController,
                      hintText: 'House number',
                      prefixIcon: Icons.home_work_outlined,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 3,
                    child: CustomTextField(
                      label: 'City',
                      controller: cityController,
                      hintText: 'Enter your city',
                      prefixIcon: Icons.location_city_outlined,
                    ),
                  ),
                ],
              ),
              
              // Save Address Checkbox
              const SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                    value: true,
                    onChanged: (value) {},
                    activeColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  Text(
                    'Save this address for future orders',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              
              // Complete Registration Button
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  text: 'Complete Registration',
                  onPressed: () => _signUp(context, args),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLocationTypeButton(String type, IconData icon) {
    return Obx(() => GestureDetector(
      onTap: () => selectedLocationType.value = type,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: selectedLocationType.value == type 
              ? Theme.of(Get.context!).primaryColor.withOpacity(0.1)
              : Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: selectedLocationType.value == type
                ? Theme.of(Get.context!).primaryColor
                : Colors.transparent,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: selectedLocationType.value == type
                  ? Theme.of(Get.context!).primaryColor
                  : Colors.grey[600],
              size: 24,
            ),
            const SizedBox(height: 8),
            Text(
              type,
              style: TextStyle(
                color: selectedLocationType.value == type
                    ? Theme.of(Get.context!).primaryColor
                    : Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    ));
  }

  void _signUp(BuildContext context, Map<String, dynamic> args) async {
    try {
      await authService.signUp(
        name: args['name'],
        email: args['email'],
        password: args['password'],
        phone: phoneController.text,
        address: addressController.text,
        houseNumber: houseController.text,
        city: cityController.text,
        locationType: selectedLocationType.value,
      );
      Get.offAllNamed('/home');
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[400],
        colorText: Colors.white,
      );
    }
  }
}
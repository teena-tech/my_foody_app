import 'package:flutter/material.dart';
import 'package:online_swissy/checkout/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class DeliveryDetailsScreen extends StatefulWidget {
  @override
  _DeliveryDetailsScreenState createState() => _DeliveryDetailsScreenState();
}

class _DeliveryDetailsScreenState extends State<DeliveryDetailsScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for the input fields
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _addressLine1Controller = TextEditingController();
  final TextEditingController _addressLine2Controller = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Construct the address from user inputs
      final String address =
          '${_addressLine1Controller.text}, ${_addressLine2Controller.text.isNotEmpty ? _addressLine2Controller.text + ', ' : ''}${_cityController.text}, ${_zipCodeController.text}';

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CheckoutScreen(
            firstName: _firstNameController.text,
            lastName: _lastNameController.text,
            address: address,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Address Details"),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeading("Personal Information"),
              SizedBox(height: 12),
              _buildTextField("First Name", _firstNameController),
              SizedBox(height: 12),
              _buildTextField("Last Name", _lastNameController),
              SizedBox(height: 24),
              _buildSectionHeading("Address Details"),
              SizedBox(height: 12),
              _buildTextField("Address Line 1", _addressLine1Controller),
              SizedBox(height: 12),
              _buildTextField(
                  "Address Line 2 (Optional)", _addressLine2Controller),
              SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField("Zip Code", _zipCodeController,
                        isNumeric: true),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _buildTextField("City", _cityController),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Proceed to Buy",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {bool isNumeric = false}) {
    return TextFormField(
      controller: controller,
      keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
      style: TextStyle(
        fontSize: 16,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          fontStyle: FontStyle.italic, // Italic label text
          color: Colors.green[700],
        ),
        filled: true,
        fillColor: Colors.grey[100], // Light grey background
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 15),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12), // Rounded corners
          borderSide: BorderSide(
            color: Colors.green[700]!,
            width: 1.5, // Green border
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12), // Rounded corners
          borderSide: BorderSide(
            color: Colors.green[900]!,
            width: 2.0, // Darker green when focused
          ),
        ),
      ),
      validator: (value) {
        if (label.contains("Optional")) {
          return null;
        }
        if (value == null || value.trim().isEmpty) {
          return "Please enter $label";
        }
        return null;
      },
    );
  }

  // Section heading widget
  Widget _buildSectionHeading(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.green[800],
      ),
    );
  }
}

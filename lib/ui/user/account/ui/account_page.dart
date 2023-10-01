import 'package:flutter/material.dart';
import 'package:time_slot/utils/tools/assistants.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: const Text('User Account'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: height(context) * 0.07),
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(
                    'assets/user_picture.jpg'), // Add your user's picture
              ),
              const SizedBox(height: 20),
              const Text(
                'Email: user@example.com', // Replace with user's email
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              const Text(
                'Promo Code: ABC123', // Replace with user's promo code
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              const Text(
                'Market Names: Market A, Market B', // Replace with user's market names
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      );
}

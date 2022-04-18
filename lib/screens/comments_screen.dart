import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lixshop/responsive/screen_layout.dart';
import 'package:lixshop/utils/helpers/secure_storage.dart';

import '../../core/core.dart';
import '../widgets/BottomNavigationFrave.dart';
import '../widgets/widgets.dart';

class ProfileClientPage extends StatelessWidget {
  const ProfileClientPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);


    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) async {

        if (await secureStorage.readToken() == null) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const ScreenLayout()));
        }

        // print('ProfileClientPage: ${state.toString()}');
        // if (state is LoadingAuthState) {
        //   Navigator.pushReplacement(
        //       context,
        //       MaterialPageRoute(
        //           builder: (context) => const MobileScreenLayout()));
        // }
        // if (state is SuccessAuthState) {
        //   Navigator.pop(context);
        //   modalSuccess(
        //       context,
        //       'Picture Change Successfully',
        //       () => Navigator.pushReplacement(
        //           context,
        //           MaterialPageRoute(
        //               builder: (context) => const MobileScreenLayout())));
        //   Navigator.pop(context);
        // }
        // if (state is FailureAuthState) {
        //   Navigator.pushReplacement(
        //       context,
        //       MaterialPageRoute(
        //           builder: (context) => const MobileScreenLayout()));
        // }
        //
        // if (state is LogOutAuthState) {
        //   Navigator.pushReplacement(
        //       context,
        //       MaterialPageRoute(
        //           builder: (context) => const MobileScreenLayout()));
        // }
      },
      buildWhen: (previous, current) => true,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              children: [
                const SizedBox(height: 20.0),
                const SizedBox(height: 20.0),
                const SizedBox(height: 15.0),
                const TextFrave(text: 'Account', color: Colors.grey),
                const SizedBox(height: 10.0),
                ItemAccount(
                    text: 'Profile setting',
                    icon: Icons.person,
                    colorIcon: 0xff01C58C,
                    onPressed: () {}),
                ItemAccount(
                    text: 'Change Password',
                    icon: Icons.lock_rounded,
                    colorIcon: 0xff1B83F5,
                    onPressed: () {}),
                ItemAccount(
                    text: 'Add addresses',
                    icon: Icons.my_location_rounded,
                    colorIcon: 0xffFB5019,
                    onPressed: () {}),
                ItemAccount(
                    text: 'Orders',
                    icon: Icons.shopping_bag_outlined,
                    colorIcon: 0xffFBAD49,
                    onPressed: () {}),
                const ItemAccount(
                  text: 'Dark mode',
                  icon: Icons.dark_mode_rounded,
                  colorIcon: 0xff051E2F,
                ),
                const SizedBox(height: 15.0),
                const TextFrave(text: 'Personal', color: Colors.grey),
                const SizedBox(height: 10.0),
                const ItemAccount(
                  text: 'Privacy & Policy',
                  icon: Icons.policy_rounded,
                  colorIcon: 0xff6dbd63,
                ),
                const ItemAccount(
                  text: 'Security',
                  icon: Icons.lock_outline_rounded,
                  colorIcon: 0xff1F252C,
                ),
                const ItemAccount(
                  text: 'Term & Conditions',
                  icon: Icons.description_outlined,
                  colorIcon: 0xff458bff,
                ),
                const ItemAccount(
                  text: 'Help',
                  icon: Icons.help_outline,
                  colorIcon: 0xff4772e6,
                ),
                const Divider(),
                ItemAccount(
                  text: 'Sign Out',
                  icon: Icons.power_settings_new_sharp,
                  colorIcon: 0xffF02849,
                  onPressed: () {
                    authBloc.add(AuthLogoutEvent());
                  },
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationFrave(3),
        );
      },
    );
  }
}

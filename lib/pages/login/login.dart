import 'dart:async';
import 'dart:developer';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:github/constants/constants.dart' show $constants;
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class _Model {
  String token = $constants.githubConfig.accessToken;

  void save(BuildContext context) async {
    try {
      final storage = await SharedPreferences.getInstance();
      await storage.setString($constants.storageToken.githubAccessToken, token);
      // 每两小时清除一次 token
      Timer.periodic(const Duration(hours: 2), (timer) async {
        await storage.remove($constants.storageToken.githubAccessToken);
      });

      if (context.mounted) {
        // 登录完成，去首页
        context.go('/home');
      }
    } catch (e) {
      VoidCallbackIntent(() {});
    }
  }
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formRef = GlobalKey<FormState>();
  final _Model _model = _Model();
  final String _patUrl = 'https://github.com/settings/personal-access-tokens';

  Future<void> login() async {}

  Widget _buildLogo() {
    return const CircleAvatar(
      radius: 40,
      backgroundImage:
          NetworkImage('https://oss.yyge.top/test/images/github.png'),
      backgroundColor: Colors.white,
    );
  }

  Widget _buildForm() {
    return Form(
        key: _formRef,
        onChanged: () {},
        child: Column(
          children: [
            TextFormField(
              initialValue: _model.token,
              decoration: const InputDecoration(
                labelText: 'Personal Access Token: ',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '请输入';
                }
                return null;
              },
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
              onSaved: (newValue) {
                setState(() {
                  _model.token = newValue ?? '';
                });
              },
            ),
            const SizedBox(
              height: 8,
            ),
            RichText(
              text: TextSpan(
                text: '点击此处生成',
                style: const TextStyle(
                  color: Colors.blue,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () async {
                    if (await canLaunchUrl(Uri.parse(_patUrl))) {
                      await launchUrl(Uri.parse(_patUrl));
                    } else {
                      throw '无法打开链接: $_patUrl';
                    }
                  },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                onPressed: () {
                  if (_formRef.currentState!.validate()) {
                    _formRef.currentState!.save();
                    _model.save(context);
                  }
                },
                style: const ButtonStyle(
                    minimumSize: MaterialStatePropertyAll(Size.fromHeight(40))),
                child: const Text('登 录'),
              ),
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 350,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildLogo(),
              _buildForm(),
            ],
          ),
        ),
      ),
    );
  }
}

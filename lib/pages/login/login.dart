import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey.shade100,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
                child: Center(
              child: Image.network(
                'https://s3.cn-south-1.qiniucs.com/80wsnx/test/images/github.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=n4eSoB1ITSy1zcht0nQQ2XTLyYNsqCpUuOYEJ4m6%2F20231226%2Fcn-south-1%2Fs3%2Faws4_request&X-Amz-Date=20231226T025714Z&X-Amz-Expires=599&X-Amz-Signature=ce0d184be2b5e261ae0431e7adb4e310adc6cae47a6ff5b58a65ee099c012bd1&X-Amz-SignedHeaders=host',
                fit: BoxFit.contain,
                width: 120,
                height: 120,
              ),
            )),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: FilledButton(
                onPressed: () {},
                style: const ButtonStyle(
                    minimumSize: MaterialStatePropertyAll(Size.fromHeight(40)),
                    elevation: MaterialStatePropertyAll(1),
                    backgroundColor: MaterialStatePropertyAll(Colors.black)),
                child: const Text("使用 GITHUB 登录"),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
              child: const Text(
                "使用个人账户或 Github Enterprise 云账户登录 Github.com",
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: ElevatedButton(
                onPressed: () {},
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.white),
                    minimumSize: MaterialStatePropertyAll(Size.fromHeight(40)),
                    elevation: MaterialStatePropertyAll(1)),
                child: const Text(
                  "使用 GITHUB ENTERPRISE 登录",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              alignment: Alignment.center,
              child: RichText(
                  text: const TextSpan(
                text: "签名即表示您接受我们的 ",
                style: TextStyle(color: Colors.grey),
                children: [
                  TextSpan(
                      text: '使用条款',
                      style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline)),
                  TextSpan(text: ' 和 '),
                  TextSpan(
                      text: '隐私政策',
                      style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline)),
                ],
              )),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 40),
              child: RichText(
                  text: const TextSpan(
                      text: '登录时遇到问题?',
                      style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline))),
            ),
          ],
        ),
      ),
    );
  }
}

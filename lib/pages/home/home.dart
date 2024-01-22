import 'package:flutter/material.dart';
import 'package:github/models/issue_model/issue_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  Widget _buildBasicSection(String title, Widget child, {bool hasBorder = true}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: hasBorder ? BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade200))) : null,
      child: Column(
        children: [
          ListTile(
            title: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          child,
        ],
      ),
    );
  }

  Widget _buildMyWorkSection() {
    return Column(
      children: [
        _buildMyWorkItem(Icons.adjust, Colors.green, '议题'),
        _buildMyWorkItem(Icons.hub_outlined, Colors.blue, '拉取请求'),
        _buildMyWorkItem(Icons.forum_outlined, Colors.purple, '讨论'),
        _buildMyWorkItem(Icons.web_outlined, Colors.grey, '项目'),
        _buildMyWorkItem(Icons.wysiwyg_outlined, Colors.black, '仓库'),
        _buildMyWorkItem(Icons.blinds_closed_outlined, Colors.orange, '组织'),
        _buildMyWorkItem(Icons.star_border_outlined, Colors.yellow.shade700, '已加星标'),
      ],
    );
  }

  Widget _buildMyWorkItem(
    IconData iconData,
    Color leadingBgColor,
    String title,
  ) {
    return Material(
      color: Colors.white,
      child: InkWell(
        child: ListTile(
          leading: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(6),
              ),
              color: leadingBgColor,
            ),
            child: Center(
              child: Icon(
                iconData,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
          title: Text(title),
          onTap: () {},
        ),
      ),
    );
  }

  Widget _buildShortcutSection() {
    return Column(
      children: [
        _buildShortcutItem(
          Icons.remove_red_eye_outlined,
          Colors.green,
          '议题',
          '已提及',
        ),
        _buildShortcutItem(
          Icons.grid_view,
          Colors.red,
          '议题',
          '已分配',
        ),
        _buildShortcutItem(
          Icons.reviews_outlined,
          Colors.blue,
          '拉取请求',
          '已请求审核',
        ),
      ],
    );
  }

  Widget _buildShortcutItem(IconData leadingIcon, MaterialColor leadingBgColor, String title, String subtitle) {
    return Material(
      color: Colors.white,
      child: InkWell(
        child: ListTile(
          leading: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: leadingBgColor.shade100,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            child: Center(
              child: Icon(
                leadingIcon,
                color: leadingBgColor,
                size: 16,
              ),
            ),
          ),
          title: Text(title),
          subtitle: Text(subtitle),
          onTap: () {},
        ),
      ),
    );
  }

  Widget _buildRecentlySection() {
    return const Column(
      children: [],
    );
  }

  Widget _buildRecentlyItem(IssueModel item) {
    return const Material(
      color: Colors.white,
      child: InkWell(
        child: ListTile(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildBasicSection('我的工作', _buildMyWorkSection()),
            _buildBasicSection('快捷键', _buildShortcutSection()),
            _buildBasicSection('最近议题', _buildRecentlySection()),
          ],
        ),
      ),
    );
  }
}

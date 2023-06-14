import 'package:flutter/material.dart';
import 'package:weather/components/components.dart';
import 'package:weather/providers/providers.dart';
import 'package:weather/utils/dependencies.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeModel>().isDarkMode;
    return Scaffold(
      //bottomNavigationBar: const BottomCustomBar(),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              centerTitle: true,
              pinned: true,
              expandedHeight: 200,
              //leading: const ChangeTheme(),
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                //background: Container(color: Colors.pink),
                title: Text(
                  'S E T T I N G S',
                  style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: isDarkMode ? Colors.white : Colors.black),
                ),
              ),
            ),
            const SliverToBoxAdapter(
                child: ListTile(
              leading: Icon(FontAwesomeIcons.yinYang),
              title: Text('Theme'),
              trailing: ChangeTheme(),
            )),
            const SliverToBoxAdapter(
                child: ListTile(
              leading: Icon(FontAwesomeIcons.circleQuestion),
              title: Text('Help'),
              subtitle: Text('Help centre, contact us, privacy policy'),
              trailing: ChangeTheme(),
            )),
            const SliverToBoxAdapter(
                child: Text(
              'from',
              textAlign: TextAlign.center,
            )),
            const SliverToBoxAdapter(
                child: ListTile(
              leading: Icon(FontAwesomeIcons.globe),
              title: Text('App languange'),
              subtitle: Text('English'),
            ))
          ],
        ));
  }
}

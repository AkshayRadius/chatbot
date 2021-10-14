import 'package:badges/badges.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:chatbot/constant.dart';
import 'package:chatbot/view/askme.dart';
import 'package:chatbot/view/support.dart';
import 'package:flutter/material.dart';

class ChatBot extends StatefulWidget {
  ChatBot({Key? key}) : super(key: key);

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> with SingleTickerProviderStateMixin {
  final double bottomRadius = 20;

  List<Widget> tabs = [
    AskMe(),
    Support(),
  ];

  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: tabs.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final tabText = theme.textTheme.subtitle1?.copyWith(fontSize: 18);
    return SafeArea(
      child: DefaultTabController(
        length: tabs.length,
        initialIndex: 0,
        child: Scaffold(
          body: Column(
            children: [
              Container(
                width: double.infinity,
                height: size.height * .19,
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(bottomRadius),
                      bottomRight: Radius.circular(bottomRadius),
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Badge(
                            badgeColor: Colors.green,
                            badgeContent: const SizedBox(
                              height: 8,
                              width: 8,
                            ),
                            position: BadgePosition.bottomEnd(),
                            child: const CircleAvatar(
                              maxRadius: 25,
                              child: Icon(Icons.person),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: Text(
                              'user name',
                              style: theme.textTheme.headline5?.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: const Icon(
                              Icons.phone_outlined,
                              color: actionBtnColor,
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          InkWell(
                            onTap: () {},
                            child: const Icon(
                              Icons.more_vert,
                              color: actionBtnColor,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TabBar(
                        labelColor: primaryColor,
                        unselectedLabelColor: Colors.white,
                        labelStyle: tabText,
                        isScrollable: true,
                        indicator: const BubbleTabIndicator(
                          indicatorHeight: 35,
                          indicatorColor: Colors.white,
                          tabBarIndicatorSize: TabBarIndicatorSize.tab,
                          indicatorRadius: 16,
                        ),
                        tabs: [
                          Tab(
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                              child: const Text(
                                'AskMe',
                              ),
                            ),
                          ),
                          Tab(
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 25,
                              ),
                              child: const Text(
                                'Support',
                              ),
                            ),
                          )
                        ],
                        controller: _tabController,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: tabs,
                  controller: _tabController,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

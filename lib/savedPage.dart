import 'package:flutter/material.dart';

class savedPage extends StatelessWidget {
  final choices = ['PLANE', 'CAR', 'BIKE', 'BOAT', 'BUS', 'TRAIN', 'WALK'];
  @override
  Widget build(BuildContext context) {
    // 가장 간단하고 쉽게 사용할 수 있는 기본 탭바 컨트롤러. 탭바와 탭바뷰 연결.
    return DefaultTabController(
      length: choices.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('보관함'),
          bottom: TabBar(
            // map 함수는 리스트의 요소를 하나씩 전달한 결과로
            // Iterable 객체를 생성하기 때문에 toList 함수로 변환
            tabs: choices.map((String choice) {
              // text는 탭바에 표시할 내용. 지금은 아이콘 없이 문자열만 사용.
              return Tab(text: choice);
            }).toList(),
            isScrollable: true,         // 많으면 자동 스크롤
          ),
        ),
        // 탭바와 연결된 탣바뷰 생성.
        // 탭바 코드와 똑같이 map 함수로 리스트 생성
        body: TabBarView(
          children: choices.map((String choice) {
            return Center(
              child: Text(
                choice,
                style: TextStyle(fontSize: 31),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
# Today Extension 구현(위젯)

## Today Extension

- iOS에서 제공하는 ```Today Extension```은 흔히 우리가 말하고 있는 Widget(위젯)과 비슷한 기능입니다. 바탕화면에서 간단한 정보를 제공하고 클릭 이벤트시에 기능을 제공할 수 있습니다.


## JNU-tong

- JNU-tong에서는 ```Today Extension```을 다음과 같이 사용해 볼려고 합니다.

  - 시내버스 중 최신에 도착할 버스 알림
  - 즐겨찾기에 등록한 셔틀버스 정류소의 버스 알림


## Implement

### Today Extension Add

우선 ```Project/Target``` 에서 ```Today Extension```을 추가해 줍니다.

![todayExtensionAdd](/images/todayExtensionAdd.png)

<br>
그러면 아래와 같이 ```Target```에 ```Widget```이 등록이 됩니다.

![todayExtensionAddResult1](/images/todayExtensionAddResult1.png)

<br>
그리고 파일이 아래와 같이 생성됩니다.

![todayExtensionAddResult2](/images/todayExtensionAddResult2.png)

- ```MainInterface.storyboard```: 위젯의 인터페이스를 다루는 ```storyboard```
- ```TodayViewController```: 해당 위겟에 ```ViewController```
- ```info.plist```:  위젯의 설정 ```plist```

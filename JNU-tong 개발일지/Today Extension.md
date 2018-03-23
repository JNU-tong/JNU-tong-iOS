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

<br>
Widget scheme를 빌드하면 다음과 같은 결과화면을 볼수 있습니다.

![widgetResult](/images/widgetResult.jpeg)

<br>
#### widget default

- CGSize : width(320), height(110)


## Function

### 버스 시간의 업데이트 시간


## Issue

### Project Image Use

 Widget 기능중 시간과 버스의 update하는 기능이 있었습니다. 이 기능의 모양은 전에 앱에서 사용한 다음과 같은 이미지를 사용하고 싶었습니다.

 ![reset](/images/reset.png)

 하지만 해당 이미지를 스토리 보드에서 사용했을때에는 이미지가 보이지 않고, 코드로 주었을때에는 이미지가 없어 아에 프로그램이 죽어버립니다.

 그래서 이유를 찾아보니 Widget같은 경우에 프로그램에 추가할 경우 따로 ```Target```을 설정하고 있습니다. 그러니 만약 이미지를 쓰고 싶다면 ```Assets.xcassets``` 에서 추가 해야 합니다.

 ![asset](/images/asset.png)
 

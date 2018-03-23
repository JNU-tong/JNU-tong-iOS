# UserNotification을 이용한 시내버스 알람 구현

## JNU-tong push alarm

- iOS 에서 제공하는 ```UserNotification```을 이용하여 사용자가 원하는 버스시간에 알람을 등록하여 해당 시간에 ```push alarm```이 가도록 하는 기능을 구현해 보겠습니다.


## Implement

### CityBusDetailView UI

| UI 변경전 |UI 변경후|
|--------|--------|
|![alarmBefore](/images/alarmBefore.png) |![alarmAfter](/images/alarmAfter.png) |

- ```CityBusDetailView``` 안에 시간표 테이블에 알람 버튼을 설정하여,
원하는 버스, 원하는 시간에 알람을 설정 할수 있도록 하였습니다.


### Alarm Allow

- 우선 ```제대로 통한다```에서 ```push alarm``` 기능을 허용할지를 사용자에게 허락을 받아야 합니다.

- 처음 알람 버튼을 눌렀을때 ```제대로 통한다```에서 허용을 받았는지 아래와 같이 확인을 합니다.

```swift
        let isRegisteredForRemoteNotifications = UIApplication.shared.isRegisteredForRemoteNotifications
        if isRegisteredForRemoteNotifications {
            print("isResister")
        } else {
            print("no Resister")
        }
```

- 만약 알람이 허용 설정이 안됐을때는 아래와 같은 코드로 사용자에게 물어보고, 이미지와 같은 메세지 창을 띄울수 있습니다.

- 사용자가 "허용 안 함"을 선택하고 다시 알람 버튼을 눌렀을 경우, "설정" 탭에서 설정을 해달라는 알람을 추가했습니다.

``` swift
UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge],
                                                        completionHandler: {didAllow, error in
                                                            if didAllow {
                                                                print("allow")
                                                            } else {
                                                                let alert = UIAlertController(title: "알람 설정 필요",
                                                                                              message: "알람을 받기 위해서는 알람 설정이 필요합니다.\n알람 설정은 '설정'탭에서 확인할 수 있습니다.", preferredStyle: .alert)
                                                                let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                                                                alert.addAction(ok)
                                                                self.parentViewController?.present(alert, animated: true, completion: nil)
                                                            }
})
```

| 알람 설정 |"허용 안 함"시에 알람|
|--------|--------|
|![alarmRequest](/images/alarmRequest.png) |![alarmReject](/images/alarmReject.png) |

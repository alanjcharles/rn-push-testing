# rn-push-testing
Simple react native application to correct erroneous push notification tracking behavior


In order to fix the Device Mode Destination issue when implementating Push Notification tracking you will have to do the following: 

1. import the native modules for your Device Mode Destinations in `AppDelegate.m` 
https://github.com/alanjcharles/rn-push-testing/blob/main/ios/pushTest/AppDelegate.m#L17

2. Add Destinations to Analytics Configuration
https://github.com/alanjcharles/rn-push-testing/blob/main/ios/pushTest/AppDelegate.m#L27


Resulting payload (with push tracking enabled): 


```{
  "anonymousId": "5B00EE35-3598-4E2D-8D5A-692BE8C048F5",
  "context": {
    "app": {
      "build": "1",
      "name": "pushTest",
      "namespace": "org.alancharles.pushTest",
      "version": "1.0"
    },
    "device": {
      "id": "520F6985-E8D5-4809-88A3-C1938D483330",
      "manufacturer": "Apple",
      "model": "x86_64",
      "name": "iPhone",
      "type": "ios"
    },
    "ip": "97.118.45.199",
    "library": {
      "name": "analytics-react-native",
      "version": "1.5.0"
    },
    "locale": "en-US",
    "network": {
      "cellular": false,
      "wifi": true
    },
    "os": {
      "name": "iOS",
      "version": "14.5"
    },
    "screen": {
      "height": 844,
      "width": 390
    },
    "timezone": "America/Denver",
    "traits": {}
  },
  "integrations": {
    "Amplitude": false,
    "Firebase": false
  },
  "messageId": "CFF7ED8D-566A-4518-A3A3-1B683583FB2E",
  "name": "first screen",
  "originalTimestamp": "2021-09-27T21:06:22.823Z",
  "properties": {},
  "receivedAt": "2021-09-27T21:06:39.472Z",
  "sentAt": "2021-09-27T21:06:39.181Z",
  "timestamp": "2021-09-27T21:06:23.114Z",
  "type": "screen",
  "writeKey": "BRoigAmFuQv7x5YhIWlvHJeKzqT6Yn5g"
}
```

Events appear to be arriving in Firebase and Amplitude Destinations as expected as well. 

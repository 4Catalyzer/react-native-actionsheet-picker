# react-native-actionsheet-picker

A wrapper on top of [ActionSheetPicker-3.0](https://github.com/skywinder/ActionSheetPicker-3.0) for displaying string picker in an actionsheet

### Installation

```bash
npm i --save react-native-actionsheet-picker
```

You need CocoaPods to install `ActionSheetPicker-3.0`.
To integrate ActionSheetPicker-3.0 into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'ActionSheetPicker-3.0'
```

Then, run the following command:

```bash
$ pod install
```


### Add it to your iOS project

1. Run `npm install react-native-actionsheet-picker --save`
2. Open your project in XCode, right click on `Libraries` and click `Add
   Files to "Your Project Name"` [(Screenshot)](http://url.brentvatne.ca/jQp8) then [(Screenshot)](http://url.brentvatne.ca/1gqUD).
3. Add `libCJActionSheetPicker.a` to `Build Phases -> Link Binary With Libraries`
   [(Screenshot)](http://url.brentvatne.ca/17Xfe).
4. Whenever you want to use it within React code now you can: `var CountDownPicker = require('NativeModules').CJActionSheetPicker;`


## Example `ActionSheetPicker`
```javascript
var ActionSheetPicker = require('NativeModules').CJActionSheetPicker;

var ExampleApp = React.createClass({
  showPicker: function() {
    ActionSheetPicker.showPicker({
      title: 'Fruits', //optional
      selectedIndex: 1 //optional intial time,
      rows: ['apple', 'orange']
    }).then(({ cancelled, selectedIndex, selectedValue }) => {
      // console.log(selectedIndex)
    });
  },  
  render: function() {
    return (
      <TouchableHighlight
            onPress={this.showPicker}
            underlayColor="#f7f7f7">
	      <View style={styles.container}>
	        <Image source={require('image!announcement')} style={styles.image} />
	      </View>
	   </TouchableHighlight>
    );
  }
});
```


## Example `CountDownPicker`
```javascript
var CountDownPicker = require('NativeModules').CJCountDownPicker;

var ExampleApp = React.createClass({
  showPicker: function() {
    CountDownPicker.showCountDownPicker({
      title: 'show', //optional
      countDownDuration: '' //optional intial time
    }).then(({ cancelled, selectedDate }) => {
        if(cancelled) {
          AlertIOS.alert('Error', 'select a time');
        }
        //duration is in seconds.
    });
  },  
  render: function() {
    return (
      <TouchableHighlight
            onPress={this.showPicker}
            underlayColor="#f7f7f7">
	      <View style={styles.container}>
	        <Image source={require('image!announcement')} style={styles.image} />
	      </View>
	   </TouchableHighlight>
    );
  }
});
```

import ReactNative from 'react-native';

const {
  NativeModules: {
    CJActionSheetPicker,
  }
} = ReactNative;

const {
  showCountDownPicker,
  showStringPicker,
} = CJActionSheetPicker;

export { showCountDownPicker, showStringPicker };

import ReactNative from 'react-native';

const {
  NativeModules {
    CJActionSheetPicker,
  }
} = ReactNative;

async function showPicker(options) {
  return await CJActionSheetPicker.showPicker(options);
}

async function showCountDownPicker(options) {
  return await CJActionSheetPicker.showCountDownPicker(options);
}

export { showPicker, showCountDownPicker };

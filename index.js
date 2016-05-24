import ReactNative from 'react-native';

const {
  NativeModules {
    CJActionSheetPicker,
  }
} = ReactNative;

async function showPicker(options) {
  return await CJActionSheetPicker.showPicker(options);
}

async function showCountDownPickerWithOptions(options) {
  return await CJActionSheetPicker.showCountDownPickerWithOptions(options);
}

export { showPicker, showCountDownPickerWithOptions };

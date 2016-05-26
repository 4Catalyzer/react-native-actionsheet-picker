import ReactNative from 'react-native';

const {
  NativeModules: {
    CJActionSheetPicker,
  }
} = ReactNative;

async function showPicker(options) {
  return await CJActionSheetPicker.showPicker(options);
}

export default showPicker;
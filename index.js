import ReactNative from 'react-native';

const {
  NativeModules: { CJActionSheetPicker },
  processColor,
} = ReactNative;


async function showCountDownPicker({ tintColor, ...options }) {
  return await CJActionSheetPicker.showCountDownPicker({
    tintColor: processColor(tintColor),
    ...options,
  });
}

async function showStringPicker({ tintColor, selectedIndex, ...options }) {
  return await CJActionSheetPicker.showStringPicker({
    tintColor: processColor(tintColor),
    selectedIndex: selectedIndex === -1 ? 0 : selectedIndex,
    ...options,
  });
}

export { showCountDownPicker, showStringPicker };

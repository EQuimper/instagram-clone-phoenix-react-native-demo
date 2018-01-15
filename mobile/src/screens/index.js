import { Navigation } from 'react-native-navigation';

import FeedsSceen from './FeedsScreen';
import ExploreScreen from './ExploreScreen';
import { APP_NAME } from '../utils/constants';

const registerNav = fn => {
  Navigation.registerComponent(`${APP_NAME}.${fn.name}`, () => fn);
};

export const registerScreens = () => {
  registerNav(FeedsSceen);
  registerNav(ExploreScreen);
};

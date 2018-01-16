import { Navigation } from 'react-native-navigation';

import FeedsSceen from './FeedsScreen';
import ExploreScreen from './ExploreScreen';
import { APP_NAME } from '../utils/constants';
import withProvider from '../utils/withProvider';

export const registerScreens = () => {
  Navigation.registerComponent(`${APP_NAME}.FeedsScreen`, () =>
    withProvider(FeedsSceen),
  );
  Navigation.registerComponent(`${APP_NAME}.ExploreScreen`, () =>
    withProvider(ExploreScreen),
  );
};

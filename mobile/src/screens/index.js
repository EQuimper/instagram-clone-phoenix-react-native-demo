import { Navigation } from 'react-native-navigation';

import FeedsSceen from './Feeds'
import ExploreScreen from './Explore'
import { APP_NAME } from '../utils/constants'

export const registerScreens = () => {
  Navigation.registerComponent(`${APP_NAME}.FeedsScreen`, () => FeedsSceen)
  Navigation.registerComponent(`${APP_NAME}.ExploreScreen`, () => ExploreScreen)
}
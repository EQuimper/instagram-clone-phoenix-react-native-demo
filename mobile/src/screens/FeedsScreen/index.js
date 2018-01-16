import React, { Component } from 'react';
import { ScrollView } from 'react-native';

import { PhotoCard } from '../../components';

class FeedsScreen extends Component {
  state = {};
  render() {
    return (
      <ScrollView>
        <PhotoCard />
        <PhotoCard />
        <PhotoCard />
      </ScrollView>
    );
  }
}

export default FeedsScreen;

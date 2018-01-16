import React, { Component } from 'react';
import {
  ScrollView,
  ActivityIndicator,
  View,
  FlatList,
  RefreshControl,
} from 'react-native';
import gql from 'graphql-tag';
import { graphql } from 'react-apollo';

import { PhotoCard } from '../../components';

class FeedsScreen extends Component {
  state = {
    isRefreshing: false,
  };

  _keyExtractor = item => item.id;

  _refreshRequest = async () => {
    this.setState({ isRefreshing: true });
    await this.props.data.refetch();
    this.setState({ isRefreshing: false });
  };

  _renderItem = ({ item }) => <PhotoCard data={item} />;
  render() {
    console.log('====================================');
    console.log(this.props);
    console.log('====================================');
    if (this.props.data.loading) {
      return (
        <View
          style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }}
        >
          <ActivityIndicator size="large" />
        </View>
      );
    }

    return (
      <FlatList
        keyExtractor={this._keyExtractor}
        data={this.props.data.photos}
        renderItem={this._renderItem}
        refreshControl={
          <RefreshControl
            refreshing={this.state.isRefreshing}
            onRefresh={this._refreshRequest}
          />
        }
      />
    );
  }
}

const Fragments = gql`
  fragment photo on Photo {
    id
    imageUrl
    caption
  }
`;

const getPhotos = gql`
  query {
    photos {
      ...photo
    }
  }
  ${Fragments}
`;

// export default graphql(getPhotos)(FeedsScreen);
export default graphql(getPhotos)(FeedsScreen);

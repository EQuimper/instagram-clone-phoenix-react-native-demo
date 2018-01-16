import React, { Component } from 'react';
import { View, Text, StyleSheet, Image } from 'react-native';
import { iOSColors } from 'react-native-typography';
import Touchable from '@appandflow/touchable';

import { fakeAvatar } from '../utils/constants';
import { makeCircle, makeHitSlop } from '../utils/themes';

const styles = StyleSheet.create({
  root: {
    minHeight: 50,
    paddingVertical: 10,
    flexDirection: 'row',
  },
  avatarWrapper: {
    flex: 0.1,
    justifyContent: 'center',
    alignItems: 'flex-start',
  },
  inputWrapper: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
  avatar: {
    ...makeCircle(30),
  },
  smallInputText: {
    color: iOSColors.lightGray2,
  },
  input: {
    borderWidth: 1,
    borderColor: iOSColors.lightGray2,
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingVertical: 5,
    paddingHorizontal: 10,
    width: '95%',
    borderRadius: 20,
    flexDirection: 'row',
  },
});

class CommentInput extends Component {
  state = {
    isFocused: false,
  };

  _onPress = () => {
    this.setState({ isFocused: true });
  };

  render() {
    return (
      <View style={styles.root}>
        <View style={styles.avatarWrapper}>
          <Image style={[styles.avatar]} source={{ uri: fakeAvatar }} />
        </View>
        <Touchable
          onPress={this._onPress}
          feedback="opacity"
          hitSlop={makeHitSlop(20)}
          style={styles.inputWrapper}
        >
          <View style={styles.input}>
            <Text style={styles.smallInputText}>Add a comment...</Text>
          </View>
        </Touchable>
      </View>
    );
  }
}

export default CommentInput;

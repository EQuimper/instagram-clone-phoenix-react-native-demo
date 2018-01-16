import React, { Component } from 'react';
import { View, Text, StyleSheet } from 'react-native';
import Touchable from '@appandflow/touchable';
import Ionicons from 'react-native-vector-icons/Ionicons';
import EvilIcons from 'react-native-vector-icons/EvilIcons';

import { makeHitSlop } from '../../utils/themes';

const styles = StyleSheet.create({
  root: {
    height: 50,
    flexDirection: 'row',
    paddingHorizontal: 14
  },
  actionsWrapper: {
    flexDirection: 'row',
    flex: 1,
    alignItems: 'center'
  },
  bookmarkWrapper: {
    flex: 0.2,
    justifyContent: 'center',
    alignItems: 'flex-end',
  },
  actionBtn: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
  fakeView: {
    flex: 2
  }
});

class ActionBtns extends Component {
  state = {};
  render() {
    return (
      <View style={styles.root}>
        <View style={styles.actionsWrapper}>
          <Touchable style={styles.actionBtn} feedback="opacity">
            <Ionicons name="ios-heart-outline" size={30} />
          </Touchable>
          <Touchable style={styles.actionBtn} feedback="opacity">
            <EvilIcons name="comment" size={35} />
          </Touchable>
          <Touchable style={styles.actionBtn} feedback="opacity">
            <Ionicons name="ios-send-outline" size={35} />
          </Touchable>
        </View>
        <View style={styles.fakeView} />
        <Touchable
          hitSlop={makeHitSlop(20)}
          style={styles.bookmarkWrapper}
          feedback="opacity"
        >
          <Ionicons name="ios-bookmark-outline" size={30} />
        </Touchable>
      </View>
    );
  }
}

export default ActionBtns;

import React from 'react';
import { View, Text, StyleSheet, Image } from 'react-native';
import { human, systemWeights } from 'react-native-typography';
import Touchable from '@appandflow/touchable';
import MaterialCommunityIcons from 'react-native-vector-icons/MaterialCommunityIcons';

import { makeCircle, makeHitSlop } from '../../utils/themes';
import { fakeAvatar } from '../../utils/constants';

const styles = StyleSheet.create({
  root: {
    height: 60,
    backgroundColor: 'white',
    paddingHorizontal: 14,
    flexDirection: 'row',
  },
  userMetaWrapper: {
    flex: 1,
    flexDirection: 'row',
  },
  btnWrapper: {
    flex: 0.1,
    justifyContent: 'center',
    alignItems: 'center',
  },
  avatarWrapper: {
    flex: 0.25,
    justifyContent: 'center',
    alignItems: 'center',
  },
  avatar: {
    ...makeCircle(45),
  },
  userInfoWrapper: {
    justifyContent: 'center',
  },
  username: {
    ...human.subheadObject,
  },
  location: {
    ...human.footnoteObject,
    ...systemWeights.light,
  },
});

export default function Header({
  avatar = fakeAvatar,
  username = 'jonSnow',
  location = 'Quebec, Canada',
}) {
  return (
    <View style={styles.root}>
      <View style={styles.userMetaWrapper}>
        <View style={styles.avatarWrapper}>
          <Image style={styles.avatar} source={{ uri: avatar }} />
        </View>
        <View style={styles.userInfoWrapper}>
          <Text style={styles.username}>{username}</Text>
          <Text style={styles.location}>{location}</Text>
        </View>
      </View>
      <Touchable
        hitSlop={makeHitSlop(20)}
        feedback="opacity"
        style={styles.btnWrapper}
      >
        <MaterialCommunityIcons name="dots-horizontal" size={25} />
      </Touchable>
    </View>
  );
}

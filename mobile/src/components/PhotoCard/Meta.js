import React from 'react';
import { View, Text, StyleSheet } from 'react-native';
import { human, systemWeights } from 'react-native-typography';

const styles = StyleSheet.create({
  root: {
    paddingHorizontal: 14,
    minHeight: 50,
  },
  likedWrapper: {
    flex: 1,
  },
  captionWrapper: {
    flex: 1,
  },
  text: {
    ...human.footnoteObject,
    ...systemWeights.light,
  },
});

export default function Meta({ caption }) {
  return (
    <View style={styles.root}>
      <View style={styles.likedWrapper}>
        <Text style={styles.text}>
          Liked by{' '}
          <Text style={systemWeights.regular}>Daenerys Targaryen</Text> liked
          and <Text style={systemWeights.regular}>1,268 others</Text>
        </Text>
      </View>
      <View style={styles.captionWrapper}>
        <Text numberOfLines={2} style={styles.text}>
          <Text style={systemWeights.regular}>jonSnow</Text> {caption}
        </Text>
      </View>
    </View>
  );
}

const makeCircle = size => ({
  height: size,
  width: size,
  borderRadius: size / 2,
});

const makeHitSlop = size => ({
  right: size,
  left: size,
  bottom: size,
  top: size,
});

export { makeCircle, makeHitSlop };

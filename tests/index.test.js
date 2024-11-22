function helloNpm() {
  return 'hello NPM';
}
test('returns hello NPM', () => {
    expect(helloNpm()).toBe('hello NPM');  // Check if it returns the correct string
});

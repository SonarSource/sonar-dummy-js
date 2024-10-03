const helloNpm = require('../index'); // Import the function

test('returns hello NPM', () => {
    expect(helloNpm()).toBe('hello NPM');  // Check if it returns the correct string
});

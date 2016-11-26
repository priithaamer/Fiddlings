module.exports = {
  target: 'electron',
  entry: './src/renderer.js',
  output: {
    filename: 'renderer.dist.js',
    path: '.'
  },
  module: {
    rules: [
      {
        test: /\.(js|jsx)$/,
        // include: paths.appSrc,
        loader: 'babel-loader'
      }
    ]
  }
};

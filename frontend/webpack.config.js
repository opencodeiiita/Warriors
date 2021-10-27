const path = require('path')
const HtmlWebpackPlugin = require('html-webpack-plugin')
const CopyPlugin = require('copy-webpack-plugin')
const { ESBuildMinifyPlugin } = require('esbuild-loader')
const ReactRefreshWebpackPlugin = require('@pmmmwh/react-refresh-webpack-plugin')

const isDevelopment = process.env.NODE_ENV !== 'production'

module.exports = {
  entry: './src',
  devtool: isDevelopment ? 'eval' : 'source-map',
  plugins: [
    isDevelopment && new ReactRefreshWebpackPlugin(),
    new HtmlWebpackPlugin({
      template: './src/index.html',
    }),
    new CopyPlugin({
      patterns: [
        { from: 'src/_redirects', to: '' },
        {
          from: 'src/assets/images/favicon.ico',
          to: 'favicon.ico',
        },
      ],
    }),
  ].filter(Boolean),
  module: {
    rules: [
      {
        test: /\.m?jsx?$/,
        loader: 'swc-loader',
        exclude: /node_modules/,
      },
      {
        test: /\.(png|svg|jpg|gif|woff|woff2|eot|ttf|otf|ico)$/,
        use: ['file-loader'],
      },
    ],
  },
  resolve: {
    extensions: ['.jsx', '.js'],
  },
  output: {
    filename: '[name].[hash].js',
    path: path.resolve(__dirname, 'build'),
  },
  devServer: {
    historyApiFallback: true,
    host: '0.0.0.0',
    stats: 'errors-only',
    overlay: true,
    hot: true,
  },
}

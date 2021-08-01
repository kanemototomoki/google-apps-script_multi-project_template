import path from 'path'
import Gas from 'gas-webpack-plugin'
import CopyWebpackPlugin from 'copy-webpack-plugin'
import { CleanWebpackPlugin } from 'clean-webpack-plugin'

const targetDirName = process.env.npm_config_my_target_dir

const config = {
  mode: 'development',
  entry: {
    [targetDirName]: `./src/${targetDirName}/index.js`,
  },
  output: {
    path: path.resolve(__dirname, 'dist'),
    filename: '[name]/index.js',
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        use: 'babel-loader',
        exclude: /node_modules/,
      },
    ],
  },
  plugins: [
    new Gas(),
    new CleanWebpackPlugin({
      cleanOnceBeforeBuildPatterns: [`${targetDirName}/*`],
    }),
    new CopyWebpackPlugin({
      patterns: [
        {
          from: `src/${targetDirName}/*.(html|json)`,
          to: `${targetDirName}/[name].[ext]`,
        },
      ],
    }),
  ],
  resolve: {
    alias: {
      '@': path.resolve(__dirname, './src'),
    },
    extensions: ['.js'],
  },
  target: ['web', 'es5'],
}

export default config

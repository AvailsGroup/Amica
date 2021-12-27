const { environment } = require('@rails/webpacker')
const jquery = require('./plugins/jquery')
const webpack = require("webpack");

environment.plugins.append('Provide',
    new webpack.ProvidePlugin({
        $: 'jquery/src/jquery',
        jQuery: 'jquery/src/jquery'
    })
)

environment.toWebpackConfig().merge({
    resolve: {
        alias: {
            'jquery': 'jquery/src/jquery'
        }
    }
});

environment.plugins.prepend('jquery', jquery)
module.exports = environment

const { environment } = require('@rails/webpacker')

const webpack = require('webpack');

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


module.exports = environment

# Export Plugin Tester
module.exports = (testers) ->
    # Define Plugin Tester
    class MyTester extends testers.RendererTester
        # Configuration
        docpadConfig:
            logLevel: 5
            enabledPlugins:
                'docpad-plugin-persona': true
                'eco': true
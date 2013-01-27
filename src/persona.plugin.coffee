`var express = require("express"),
    app = express.createServer();

app.use(express.bodyParser())
  .use(express.cookieParser())
  .use(express.session({
      secret: "mozillapersona"
  }));

require("express-persona")(app, {
  audience: "http://localhost:8888" // Must match your browser's address bar
});`

# Export Plugin
module.exports = (BasePlugin) ->
    # Define Plugin
    class persona extends BasePlugin
        # Plugin name
        name: 'persona'


# Export Plugin
module.exports = (BasePlugin) ->
  # Requires
  balUtil = require('bal-util')
  jsdom = require('jsdom')
  express = require('express')

  app = express()
  `app.use(express.bodyParser()).use(express.cookieParser()).use(express.session({secret: "mozillapersona"}))`

  console.log('persona is starting!')
  booli = new Boolean() 

  # Personatize
  personatize = (err, booli) ->
    return (err)  if err
    if booli = true
      # Handle
      injectPersonaScript = window.document.createElement('script')
      injectPersonaScript.type = "text/javascript"
      injectPersonaScript.src = "express-persona-docpad.js"

  # Define Plugin
  class PersonaPlugin extends BasePlugin
    # Plugin name
    name: 'persona'

    # Render the document
    renderDocument: (opts) ->
      # Prepare
      {extension,file} = opts

      # Handle
      if file.type is 'document'  and  extension is 'html'
        # Create DOM from the file content
        jsdom.env(
          html: "<html><body>#{opts.content}</body></html>"
          features:
            QuerySelector: true
          done: (err,window) ->
            # Check
            return err  if err

            # Find highlightable elements
            elements = window.document.querySelectorAll('.persona-btn')

            # Check
            if elements.length is 0
              return booli = false
            
              personatize(null, booli)
              opts.content = window.document.body.innerHTML
            
            else 
              return booli = true
        )
      else
        return booli = false
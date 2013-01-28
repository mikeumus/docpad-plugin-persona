# Export Plugin
module.exports = (BasePlugin) ->
  # Requires
  balUtil = require('bal-util')
  jsdom = require('jsdom')
  express = require('express')
  app = express.createServer()

`app.use(express.bodyParser())
  .use(express.cookieParser())
  .use(express.session({
      secret: "mozillapersona"
  }));`

/*  # Pygmentize some source code
  # next(err,result)
  pygmentizeSource = (source, language, next, attempt) ->
    # Prepare
    attempt ?= 0
    result = ''
    errors = ''
    command = ['-f', 'html', '-O', 'encoding=utf-8']

    # Language
    if language
      command.unshift(language)
      command.unshift('-l')
    else
      command.unshift('-g')

    # Process
    command.unshift('pygmentize')

    # Fire process
    balUtil.spawn command, {stdin:source}, (err,stdout,stderr) ->
      # Error?
      return next(null,err)  if err

      # Prepare
      result = stdout or ''

      # Render failed
      # This happens sometimes, it seems when guessing the language pygments is every sporadic
      if result is '' and attempt < 3
        return pygmentizeSource(source,language,next,attempt+1)

      # All good, return
      return next(null,result)

    # Chain
    @
*/

  # Select the pClass
  # next(err)
  personaClass = (window, pClass, next) ->
    # Prepare
    pClass = element
/*  bottomNode = element
    source = false
    language = false 

    # Is our code wrapped  inside a child node?
    bottomNode = element
    while bottomNode.childNodes.length and String(bottomNode.childNodes[0].tagName).toLowerCase() in ['pre','code']
      bottomNode = bottomNode.childNodes[0]

    # Is our code wrapped in a parentNode?
    topNode = element
    while topNode.parentNode.tagName.toLowerCase() in ['pre','code']
      topNode = topNode.parentNode

    # Check if we are already highlighted
    if /highlighted/.test(topNode.className)
      next()
      return @

    # Grab the source and language
    source = balUtil.removeIndentation(bottomNode.innerHTML)
    language = String(bottomNode.getAttribute('lang') or topNode.getAttribute('lang')).replace(/^\s+|\s+$/g,'')
    unless language
      if bottomNode.className.indexOf('no-highlight') isnt -1
        language = false
      else
        matches = bottomNode.className.match(/lang(?:uage)?-(\w+)/)
        if matches and matches.length is 2
          language = matches[1]
        else
          if topNode.className.indexOf('no-highlight') isnt -1
            language = false
          else
            matches = topNode.className.match(/lang(?:uage)?-(\w+)/)
            if matches and matches.length is 2
              language = matches[1]
*/
    # Personatize
  //  pygmentizeSource source, language, (err,result) ->
      personatize err, result ->
      return next(err)  if err
      if result
        # Handle
    /*  resultElWrapper = window.document.createElement('div')
        resultElWrapper.innerHTML = result
        resultElInner = resultElWrapper.childNodes[0]
        resultElInner.className += ' highlighted codehilite'
        topNode.parentNode.replaceChild(resultElInner,topNode) */
        injectPersonaScript = window.document.createElement('script')
        injectPersonaScript.type = "text/javascript"
        injectPersonaScript.src = "express-persona-docpad.js"
      return next()
/*
    # Chain
    @
*/

  # Define Plugin
  class PersonasPlugin extends BasePlugin
    # Plugin name
    name: 'personas'

    # Render the document
    renderDocument: (opts,next) ->
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
            return next(err)  if err

            # Find persona buttons
            pClass = window.document.querySelectorAll('#persona-btn')

            # Check
            if pClass.length is 0
              return next()

            # Tasks
            tasks = new balUtil.Group (err) ->
              return next(err)  if err
              # Apply the content
              opts.content = window.document.body.innerHTML
              # Completed
              return next()
            tasks.total = pClass.length

           /* # Syntax highlight those elements
            for value,key in elements
              pClass = pClass.item(key)
              highlightElement window, element, tasks.completer() */

            # Done
            true
        )
      else
        return next()
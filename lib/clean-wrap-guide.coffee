EVENT = "toggleWrapGuide"

toggleWrapGuide = (editor) ->

    lines      = editor.getText().split '\n'
    length     = atom.config.settings.editor.preferredLineLength or 80
    wrapGuide  = atom.views.getView(editor).querySelector ".wrap-guide"
    exceeded   = if (lines.every (line) -> line.length < length) then false else true
    
    wrapGuide.style.opacity = if exceeded then 1 else 0
    
    # console.log if exceeded then "Show guide: #{editor.id}" else  "Hide guide: #{editor.id}"
	
wrapGuideEventExists = (editor) ->
    
    eventExist = false
    for event in getChangeEvents(editor)
        if event.eventName is EVENT then eventExist = true
    return eventExist

addWrapGuideEvent = (editor) ->
    
    editor.onDidChange -> toggleWrapGuide editor
    changeEvents = getChangeEvents(editor)
    changeEvents[changeEvents.length - 1].eventName = EVENT

getChangeEvents = (editor) ->
    
    changeEvents = editor.emitter.handlersByEventName["did-change"]
    if changeEvents then return changeEvents else return []

atom.packages.onDidActivatePackage (pkg) ->
    
    if pkg.name is "wrap-guide"
        initialEditors = atom.workspace.getTextEditors()
        activeEditor   = atom.workspace.getActiveTextEditor()
        toggleWrapGuide editor for editor in initialEditors when editor isnt activeEditor
        if activeEditor then addWrapGuideEvent activeEditor

atom.workspace.onDidChangeActiveTextEditor (editor) ->
    
    # Failsafe! The empty pane tends to be recognized by the eventlistener
    if not editor then return
    # Do once when changing pane
    toggleWrapGuide editor
    # On text-buffer change
    if !wrapGuideEventExists editor then addWrapGuideEvent editor
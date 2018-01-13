### ---------- CLEAN WRAP GUIDE ----------

The ergonomic factors of code readiablity include a preferred line length limit.
Automatic soft wrap is a nightmare because it hinders the "write first, refactor later"
mentality because it wrecks readability immediately.
An unusually long line is just a minor annoyance. A wrap guide is a visual cue 
showing you if cleanup is necessary at a later point.

The problem: having a wrap guide visible at all times is distracting visual noise.
This script toggles the visibility of the wrap guide if a line exceeds the preferred line length.
(…This is really just an exercise in publishing a package for Atom…)

###

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
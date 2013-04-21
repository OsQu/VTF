$ ->
  # Bootstrap sandbox creation
  $("#start-sandbox").click ->
    $.post("#{window.location}/sandbox").done ->
      console.log "WE DID IT!!"

  $("#destroy-sandbox").click ->
    console.log "TODO"

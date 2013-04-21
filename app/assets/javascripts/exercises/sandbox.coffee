$ ->

  showModal = (id) ->
    $("##{id}").modal(
      keyboard: true
    )

  hideModal = (id) ->
    $("##{id}").modal("hide")

  # Bootstrap sandbox creation
  $("#start-sandbox").click ->
    updateWait = (waiting) ->
      $("#wait-text").toggle(waiting)
      $("#ready-text").toggle(!waiting)

    updateWait(true)
    showModal("create-modal")
    $.post("#{window.location}/sandbox").done (body) ->
      $("#sandbox-url").attr("href", body.sandbox)
      updateWait(false)

  $("#sandbox-url").click ->
    hideModal("create-modal")

  # Bootstrap sandbox destroy
  $("#destroy-sandbox").click ->
    console.log "TODO"

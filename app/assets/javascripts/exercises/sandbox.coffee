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
    sandbox = $.post("#{window.location}/sandbox")
    sandbox.done (body) ->
      $("#sandbox-url").attr("href", body.sandbox)
      updateWait(false)
    sandbox.reject (err) ->
      alert("Error occured! Please close the overlay and try again!")

  $("#sandbox-url").click ->
    hideModal("create-modal")

  # Bootstrap sandbox destroy
  $("#destroy-sandbox").click ->
    console.log "TODO"

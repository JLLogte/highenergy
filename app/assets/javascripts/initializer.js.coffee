initialize_electrify = ->
  $('.is-electrified').he_electrify()

# This will fire on the initial page load.
$(document).ready(initialize_electrify)

# This is the handler for Turbolinks to fire the event on every page change.
$(window).bind('page:change', initialize_electrify)
initialize_electrify = ->
  $('.is-electrified').he_electrify()

  # Example of how to set/override a default for any options.  See he_electrify.js to see the default settings.
  # All defaults can be modified via this method.
  # $('.is-electrified').he_electrify(particle_number: 20, left_offset_max: 50, top_offset_max: 150)

# This will fire on the initial page load.
$(document).ready(initialize_electrify)

# This is the handler for Turbolinks to fire the event on every page change.
$(window).bind('page:change', initialize_electrify)
(($) ->
  $ ->
    $('.is-electrified').he_electrify()

    # Example of how to set/override a default for any options.  See he_electrify.js to see the default settings.
    # All defaults can be modified via this method.
    # $('.is-electrified').he_electrify(particle_number: 20, left_offset_max: 50, top_offset_max: 150)
) jQuery
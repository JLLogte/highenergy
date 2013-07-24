(($, window) ->

  # Initialize the defaults.
  plugin_name = 'he_electrify'
  document    = window.document
  debug       = false
  defaults    = 
    selector:          '.is-electrified'
    append_to:         'body'
    particle_class:    'icon-bolt' # Probably should've made defaults.partile.class, etc.
    particle_template: "<i class='#CLASS'></i>"
    particle_number:   7
    particle_colors:   ['#6164b7', '#685fb7', '#6e59b7', '#7554b7', '#7c4eb7', '#8349b7', '#8a43b7', '#913eb7', '#9839b8']
    fade_out_length:   800
    left_offset_max:   45
    top_offset_max:    45
    font_offset_max:   25
    hide_opacity:      0
    reveal_opacity:    1

  public_methods = ['electrify']

  ##########################################
  # [Class/START] Plugin (Parent)
  class Plugin
    constructor: (@element, options) ->
      @options   = $.extend {}, defaults, options
      @_defaults = defaults
      @_name     = plugin_name
      @$target   = $(@element)
      @init()

    init: ->
      @lightning_storm = new LightningStorm(@$target, @options)

    electrify: ->
      @lightning_storm.electrify()

    ##########################################
    # [Class/START] LightningStorm
    class LightningStorm
      # It's about to get cray cray.
      constructor: ($target, options) ->
        @options      = options
        @measurements = {}
        @$target      = $target
        @init()

      init: ->
        @electrify()

      electrify: ->
        # Hide initial bolt.
        @$target.fadeTo(250, @options.hide_opacity)


        particle_positions          = {}
        particle_positions.top      = @$target.offset().top
        particle_positions.left     = @$target.offset().left

        @options.particle_positions = particle_positions
        @options.particle_font_size = @$target.css('font-size')

        for number in [1..@options.particle_number]
          $new_particle                    = new Particle(@$target, number, @options)

    ##########################################
    # [Class/START] Particle
    class Particle
      # Used for the individual particles within the storm.
      constructor: ($target, number, options) ->
        @options = options
        @$target = $target
        @number  = number
        @init()

      init: ->
        Logger.debug "Particle created, positions -- top: #{@options.particle_positions.top}, left: #{@options.particle_positions.left}"
        @template = @set_template()

        Logger.debug "Set current template to: #{@template}"
        @spawn_particle()

      set_template: ->
        particle_class    = @options.particle_class
        particle_template = @options.particle_template
        particle_template = particle_template.replace('#CLASS', particle_class)

        Logger.debug "Template generated: #{particle_template}"

        particle_template

      spawn_particle: ->
        # Spawn a new particle based off of the template.
        $particle = $(@template)

        # Generate random offsets for positionings
        negative          = [true, false]
        add_negative_left = negative[Math.floor(Math.random() * negative.length)] # Should this randomally be negative?
        add_negative_top  = negative[Math.floor(Math.random() * negative.length)] # Should this randomally be negative?

        left_offset = Math.floor(Math.random() * @options.left_offset_max * 2) - @options.left_offset_max # Gives [-offset_max, offset_max] as offset possibilties
        left_offset = -(left_offset) if add_negative_left == true # Invert if random negative check was true.

        top_offset = Math.floor(Math.random() * @options.top_offset_max * 2) - @options.top_offset_max # Gives [-offset_max, offset_max] as offset possibilities
        top_offset = -(top_offset) if add_negative_top == true # Invert if random negative check was true.

        font_offset = Math.floor(Math.random() * @options.font_offset_max) # Gives [0, offset_max] as offset possibilities

        random_color = @options.particle_colors[Math.floor(Math.random() * @options.particle_colors.length)]


        Logger.debug "Top offset: #{top_offset}, Left offset: #{left_offset}"

        # Set particle's CSS.
        $particle.css
          position: 'absolute'
          top:      @options.particle_positions.top + top_offset
          left:     @options.particle_positions.left + left_offset
          fontSize: parseInt(@options.particle_font_size) + font_offset + 'px'
          color:    random_color

        # Append to the DOM (default: <body>)
        $particle.appendTo($(@options.append_to))

        # Handle animations
        $particle.animate
          top:      @options.particle_positions.top
          left:     @options.particle_positions.left
          fontSize: @options.particle_font_size
 
        $particle.fadeOut @options.fade_out_length, => 
          $(this).remove()

        if @number == @options.particle_number
          Logger.debug "Revealing initial target."
          @$target.fadeTo(@options.fade_out_length, @options.reveal_opacity)

    ##########################################
    # [Class/START] Logger
    class Logger

      @debug: (message) ->
        console.log "[Debug] #{message}" if debug == true

  # Add the plugin to jQuery (will make it available on selectors).
  # Note the indentation of this, this portion is RAN when the file is processed.
  # The above code isn't ran until the plugin is called on a selector.
  $.fn[plugin_name] = (method_or_options) ->

    @each ->
      if !$.data(@, "plugin_#{plugin_name}")
        $.data(@, "plugin_#{plugin_name}", new Plugin(@, method_or_options))
      else
        if $.inArray(method_or_options, public_methods) == 0
          $.data(@, "plugin_#{plugin_name}")[method_or_options]()

)(jQuery, window)

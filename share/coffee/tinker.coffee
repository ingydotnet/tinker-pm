# Add Ace Editor
# Run on <Enter> keypress
  # Or 5 secs after no-more-entry

$Cog.tinker = ->
  # $('table.main').colResizable
  #   liveDrag: true
  @setup()
  @$pane1 = @add_pane '.col1',
    type: 'input'
    title: 'YAML Input'
    button: 'Test'
  @$pane2 = @add_pane '.col2',
    type: 'output'
    title: 'YAML.pm Load Result'
  @$pane3 = @add_pane '.col3',
    type: 'output'
    title: 'YAML::Tiny Load Result'
  $('.col1 .input').focus()
  $('button').click =>
    @process()

$Cog.process = ->
  $('.col2 .output').text $('.col1 .input').val().toUpperCase()
  $('.col3 .output').text $('.col1 .input').val().toLowerCase()
  $('.col1 .input').focus()

$Cog.add_pane = (column, data)->
  $column = $(column)
  $pane = @render 'pane.html.tt', data
  $column.html $pane
  $column.find('.input') \
    .width($pane.width() - 5) \
    .height($pane.height() - 40)
  $(column + ' .output') \
    .width($pane.width() - 5)
#     .height($pane.height() - 20)
  $pane

$Cog.setup = ->
  window.$$$ = window
  @render = ->
    $ Jemplate.process.apply @, arguments
  window.T = @

# vim: set sw=2:

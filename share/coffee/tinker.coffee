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
  input = $('.col1 .input').val()
  console.log 123456
  callback = (response)=>
    @post_process response
  $.post '/test/',
    $.toJSON({input: input}),
    callback

$Cog.post_process = (response)->
  $('.col1 .input').focus()
  $('.col2 .output').text response.pm
  $('.col3 .output').text response.tiny

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

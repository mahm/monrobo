# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

Monrobo =
  parts:
    body:
      pos: "01body"
      file: null
      color: null
    side_l:
      pos: "02sideL"
      file: null
      color: null
    side_r:
      pos: "03sideR"
      file: null
      color: null
    crown:
      pos: "04crown"
      file: null
      color: null
    center:
      pos: "05center"
      file: null
      color: null
    ribon:
      pos: "06ribon"
      file: null
      color: null
  pushImage: (monrobo) ->
    $.ajax
      type: 'post'
      url: '/display'
      dataType: 'script'
      data: monrobo.parts

$ ->
  $('[data-part]').click ->
    self = $(this)
    eval("Monrobo.parts.#{self.data('part')}.#{self.data('type')} = self.data(self.data('type'))")
    $.beActive(self, self.data('part'))
    Monrobo.pushImage(Monrobo)

  $.beActive = (self, pos) ->
    $("[data-part=#{pos}][data-#{$(self).data('type')}]").each ->
      $(this).removeClass('active')
    self.addClass('active')
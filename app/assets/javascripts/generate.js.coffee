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
     switch self.data('part')
       when 'body'
         Monrobo.parts.body.file = self.data('file')
       when 'side_l'
         Monrobo.parts.side_l.file = self.data('file')
         console.log Monrobo.parts.side_l
       when 'side_r'
         Monrobo.parts.side_r.file = self.data('file')
       when 'crown'
         Monrobo.parts.crown.file = self.data('file')
       when 'center'
         Monrobo.parts.center.file = self.data('file')
       when 'ribon'
         Monrobo.parts.ribon.file = self.data('file')
     Monrobo.pushImage(Monrobo)

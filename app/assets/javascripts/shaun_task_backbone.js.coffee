window.ShaunTaskBackbone =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: -> 
    new ShaunTaskBackbone.Routers.Messages()
    Backbone.history.start()
$(document).ready ->
  ShaunTaskBackbone.init()

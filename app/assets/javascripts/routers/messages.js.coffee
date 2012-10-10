class ShaunTaskBackbone.Routers.Messages extends Backbone.Router
  routes:
    '':'index'

  initialize: ->
    @collection = new ShaunTaskBackbone.Collections.Messages()    
    @collection.fetch()        

  index: ->
    view = new ShaunTaskBackbone.Views.MessagesIndex(collection: @collection)
    $('#container').html(view.render().el)
  
  
    



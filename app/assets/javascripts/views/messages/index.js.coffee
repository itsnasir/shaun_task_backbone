class ShaunTaskBackbone.Views.MessagesIndex extends Backbone.View

  template: JST['messages/index']
  
  events:    
   'submit .frmMessage': 'updateMessage'
    
  initialize: ->
    @collection.on('reset', @render, this)
    pusher = new Pusher('4bdb1842956d0a5c05e0')
    pusher.connection.bind "initialized", (event) -> 
      $.blockUI({ message: "<br/><br/>Please wait.. Connecting to Pusher <br/><br/>"});
    pusher.connection.bind "connecting_in", (event) -> 
      $.blockUI({ message: "<br/><br/>Please wait.. Connecting to Pusher <br/><br/>"});
    pusher.connection.bind "connected", (event) -> 
      $.unblockUI();
    pusher.connection.bind "failed", (event) -> 
      $.unblockUI();
    channel = pusher.subscribe("test_channel")
    channel.bind "updated", (data) ->
      $('#message_content_'+data.id).val(data.content)   
    
  render: ->        
    $(@el).html(@template(messages: @collection))
    this

  updateMessage: (event) -> 
    event.preventDefault()    
    formID = $(event.currentTarget).attr('id')
    message_form = formID.split("_")    
    attributes = id: message_form[1], content: $('#message_content_'+message_form[1]).val() 
    @collection.create attributes
  
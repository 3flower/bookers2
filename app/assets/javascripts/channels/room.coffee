App.room = App.cable.subscriptions.create "RoomChannel",
  connected: ->
    # Called when the subscription is ready for use on the server
    #　通信が確率された時

  disconnected: ->
    # Called when the subscription has been terminated by the server
    # 通信が切断された時

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    # 値を受け取った時

  speak: ->
    @perform 'speak', message: message #サーバーサイドのspeakアクション

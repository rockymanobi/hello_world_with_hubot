# Description:
#   Interacts with the ASL Bathroom's status.
#
# Commands:
#   hubot UNKO MORESOU - Returns whether ASL bathroom is vacant or occupied.

module.exports = (robot) ->

  robot.respond /UNKO MORESOU/i, (msg) ->

    sendStallsStatus = ( stall )->
      msg.send "#{stall.display_name} is #{stall.status}"

    msg.http('http://test-toilet.herokuapp.com/stalls/asl1')
      .get() (err, res, body) ->
        stall = JSON.parse(body)
        sendStallsStatus stall

    msg.http('http://test-toilet.herokuapp.com/stalls/asl2')
      .get() (err, res, body) ->
        stall = JSON.parse(body)
        sendStallsStatus stall


  robot.respond /MAJIDE UNKO MORESOU|MAZIDE UNKO MORESOU/i, (msg) ->

    msg.send "OK! トイレが空いたら教えてあげるよ！"

    f = ->
      return
    asl1Timer = setTimeout(f ,10000)
    asl2Timer = setTimeout(f ,10000)

    foundVacant = false

    clearAllTimeout = ->
      clearTimeout( asl1Timer )
      clearTimeout( asl2Timer )

    ask = ( name ) ->
      msg.http("http://test-toilet.herokuapp.com/stalls/#{name}")
        .get() (err, res, body) ->
          stall = JSON.parse(body)
          if stall.status isnt "vacant"
            foundVacant = true

    hoge = ->
      msg.send "asl1あいてるかな"
      if foundVacant
        msg.send "トイレが空いたよ!!"
        clearAllTimeout()
        return
      ask('asl1')
      asl1Timer = setTimeout(hoge , 5000)
    hoge2 = ->
      msg.send "asl2あいてるかな"
      if foundVacant
        msg.send "トイレが空いたよ!!"
        clearAllTimeout()
        return
      ask('asl2')
      asl2Timer = setTimeout(hoge , 5000 )

    hoge()
    hoge2()




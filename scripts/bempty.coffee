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

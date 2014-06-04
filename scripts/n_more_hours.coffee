# Description:
#   Tweet remaining time to get out of the office
#
# Commands:
#   hubot how long do i have to be here? - Reply with pong
module.exports = (robot) ->
  robot.respond /how long do i have to be here?$/i, (msg) ->

    current = new Date()
    target = new Date( current.getFullYear() , current.getMonth() , current.getDate() ,18,0,0)
    diffSec = ( target - current ) / 1000

    hour = Math.floor( diffSec / ( 60 * 60 ) )
    min = Math.floor( diffSec % (60*60) / ( 60 ) )
    sec = Math.floor( diffSec % 60 )

    msg.send "#{hour}:#{min}:#{sec} to GO!!"


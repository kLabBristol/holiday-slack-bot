module.exports = (robot) ->

  robot.respond /holiday/i, (res) ->
    res.emote "woohoo"

  robot.respond /Holiday from (.*) to (.*)/i, (res) ->
    doorType = res.match[1]

    regex = /(\d{2})\/(\d{2})\/(\d{4})/
    from = regex.exec(res.match[1])
    to = regex.exec(res.match[2])

    if from is null or to is null
      res.reply "sorry I don't recognise that date :( "
    else
      fromDate = new Date(from[3], from[2]-1, from[1])
      toDate = new Date(to[3], to[2]-1, to[1])
      res.send res.message.user.name + ": " + " from: " + fromDate + " to: " + toDate

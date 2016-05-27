# Load in the environment variables
require('dotenv').config({path: 'process.env'});

url = process.env.HOLIDAY_SERVICE_URL
token = process.env.HOLIDAY_SERVICE_TOKEN

moment = require('moment');

getDate = (dateMonthYear) ->
  moment(dateMonthYear, "DD/MM/YYYY").format("YYYY-MM-DD");

module.exports = (robot) ->

  console.log(url)
  console.log()

  robot.hear /Holiday from (.*) to (.*)/i, (res) ->
    regex = /(\d{2})\/(\d{2})\/(\d{4})/

    try
      fromDate = getDate res.match[1]
      toDate = getDate res.match[2]
    catch
      res.reply "Sorry I don't recognise that date :( "

    messageBody = JSON.stringify({
      user: res.message.user.name,
      from: fromDate,
      to: toDate
    })

    robot.http(url)
    .header('Authorization', token)
    .header('Content-Type', 'application/json')
    .post(messageBody) (err, res2, body) ->

      if res2.statusCode isnt 201
        res.send "Encountered an error :( #{err}"
        return

      res.send("Holiday saved, have fun!")


  robot.hear /Where's my team?/i, (res) ->
    robot.http(url)
    .header('Authorization', token)
    .get() (err, res2, body) ->
      res.send "```" + body + "```"

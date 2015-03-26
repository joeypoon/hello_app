noClick = ->
  if clickCount == 0
    $('#notClicking').show()
    clearInterval counter
    clearInterval clickCounter
  else
    clickCount--
  return

resetClick = ->
  clickCount = 5
  return

randomColor = ->
  hexDec = '0123456789ABCDEF'.split('')
  color = '#'
  i = 0
  while i < 6
    color += hexDec[Math.round(Math.random() * 15)]
    i++
  color

timer = ->
  count--
  if count <= 0
    clearInterval counter
    clearInterval clickCounter
    averageScore = 0
    i = 0
    while i < score.length
      averageScore += score[i]
      i++
    $('#average').html 'Your average reaction time is ' + averageScore / score.length + ' seconds.'
    alert 'Your average reaction time is ' + averageScore / score.length + ' seconds.'
    return
  $('#average').html 'You have ' + count + ' seconds remaining.'
  return

makeShape = ->
  delay = Math.random() * 500
  randomLeft = Math.round(Math.random() * 470)
  randomTop = Math.round(Math.random() * 470)
  setTimeout (->
    $('#shape').css 'backgroundColor', randomColor()
    $('#shape').css 'display', 'block'
    if Math.random() > 0.5
      $('#shape').css 'borderRadius', '100px'
    else
      $('#shape').css 'borderRadius', '0'
    $('#shape').css 'marginLeft', randomLeft + 'px'
    $('#shape').css 'marginTop', randomTop + 'px'
    createdTime = Date.now()
    return
  ), delay
  return

$('#splashScreen').css 'margin-top', $(window).height() / 3
$('#gameCanvas').css 'margin-top', $(window).height() / 15
$('#notClicking').hide()
$('#startButton').click ->
  $('#splashScreen').hide()
  $('#gameCanvas').show()
  makeShape()
  counter = setInterval(timer, 1000)
  clickCounter = setInterval(noClick, 1000)
  return
clickCount = 5
clickCounter = undefined
createdTime = 0
clickedTime = 0
count = 30
counter = undefined
score = []
$('#shape').click ->
  clickedTime = Date.now()
  @style.display = 'none'
  $('#reactionTime').html 'Your reaction time is ' + (clickedTime - createdTime) / 1000 + ' seconds'
  score.push (clickedTime - createdTime) / 1000
  makeShape()
  resetClick()
  return
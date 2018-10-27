require './motc'

app_id  = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
app_key = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'

motc = MOTC.new(app_id, app_key)
puts motc.get('/Air/Airport?$top=30&$format=JSON')

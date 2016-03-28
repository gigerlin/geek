###
  @author Gilles Gerlinger
  Copyright 2016. All rights reserved.
###

express = require 'express'
multer  = require 'multer'
exec = require 'sync-exec'

upload = multer dest:'videos/'

geek = express()
geek.use express.static(__dirname + '/www')

storage = multer.diskStorage destination:'./videos/', filename: (req, file, cb) -> cb null, file.originalname
upload = multer storage:storage

geek.post '/geek', upload.single('videofile'), (req, res, next) ->
  if req.file
    console.log req.file
    if req.file.originalname.indexOf('.') > -1
      tmp = req.file.originalname.split '.'
      ext = tmp[tmp.length-1]
      tmp.pop()
      file = tmp.join('.')
    else 
      ext = ''
      file = req.file.originalname
    rnd = Math.random().toString().substring(2,7)
    rst = exec "./response.sh #{rnd} '#{file}'"
    console.log if rst.stderr then rst.stderr else rst.stdout
    res.writeHead 303, 'Location': "tmp-#{rnd}/response.html"
    res.end()
    rst = exec "./process.sh '#{file}' #{ext} #{rnd}", cwd:'/Users/gillesgerlinger/dev/geek'
    console.log if rst.stderr then rst.stderr else rst.stdout
  else
    res.status(404).end("no file uploaded")

geek.listen port = 4145, -> 
  console.log "Server started at #{port}", new Date(), '\n'
 
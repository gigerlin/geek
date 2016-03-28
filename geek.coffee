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
    res.writeHead 303, 'Location': 'process.html'
    res.end()
    if req.file.originalname.indexOf('.') > -1
      tmp = req.file.originalname.split '.'
      ext = tmp[tmp.length-1]
      tmp.pop()
      file = tmp.join('.')
    else 
      ext = ''
      file = req.file.originalname
    console.log ext, file
    console.log(exec('ls -la', {cwd: './'}))
    console.log "process.sh '#{file}' #{ext}"
    rst = exec "./process.sh '#{file}' #{ext}", cwd:'/Users/gillesgerlinger/dev/geek'
    console.log rst.status
    console.log rst.stdout
    console.log rst.stderr
  else
    res.status(404).end("no file uploaded")

geek.listen port = 4145, -> 
  console.log "Server started at #{port}", new Date(), '\n'
 
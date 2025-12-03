## asyncfile
import std/asyncdispatch
import std/asyncfile
import std/os


# proc main() {.async.} =
#   var file = openAsync(getTempDir() / "foobar.txt", fmReadWrite)
#   await file.write("test")
#   file.setFilePos(0)
#   let data = await file.readAll()
#   assert data == "test"
#   file.close()

# waitFor main()

## asynchttpserver
# import std/asynchttpserver

# proc main() {.async.} =
#   var server = newAsyncHttpServer()
#   proc cb(req: Request) {.async.} =
#     echo (req.reqMethod, req.url, req.headers)
#     let headers = {"Content-type": "text/plain; charset=utf-8"}
#     await req.respond(Http200, "Hello World", headers.newHttpHeaders())

#   server.listen(Port(0))
#   let port = server.getPort
#   echo "test this with: curl localhost:" & $port.uint16 & "/"
#   while true:
#     if server.shouldAcceptRequest():
#       await server.acceptRequest(cb)
#     else:
#       await sleepAsync(500)

# waitFor main()

## httpclient
# import std/httpclient
# import std/asyncdispatch

# var client = newHttpClient()
# try:
#   echo client.getContent("http://google.com")
# finally:
#   client.close()

# proc asyncProc(): Future[string] {.async.} =
#   var client = newAsyncHttpClient()
#   try:
#     return await client.getContent("http://google.com")
#   finally:
#     client.close()

# echo waitFor asyncProc()

# #run with -d:ssl
# var client = newHttpClient()
# var data = newMultipartData()
# data["output"] = "soap12"
# data["uploaded_file"] = ("test.html", "text/html", "<html><head></head><body><p>test</p></body></html>")
# try:
#   echo client.postContent("https://validator.w3.org/check", multipart = data)
# finally:
#   client.close()

# import std/httpclient
# import std/json

# let client = newHttpClient(timeout = 1000, maxRedirects = 0)
# client.headers = newHttpHeaders({"Content-Type": "application/json"})

# let body = %*{
#   "data": "some text"
# }
# try:
#   let response = client.request("https://jsonplaceholder.typicode.com/posts",
#       httpMethod = HttpPost, body = $body)
#   echo response.status
# finally:
#   client.close()

# import std/asyncdispatch
# import std/httpclient

# proc onProgressChanged(total, progress, speed: BiggestInt) {.async.} =
#   echo("Downloaded ", progress, " of ", total)
#   echo("Current rate: ", speed div 1000, "kb/s")

# proc asyncProc() {.async.} =
#   var client = newAsyncHttpClient()
#   client.onProgressChanged = onProgressChanged
#   try:
#     discard await client.getContent("https://mirror.limda.net/archlinux/iso/2025.12.01/archlinux-x86_64.iso")
#   finally:
#     client.close()

# waitFor asyncProc()

## mimetypes
import std/mimetypes

var m = newMimetypes()
assert m.getMimetype("mp4") == "video/mp4"
assert m.getExt("text/html") == "html"
assert m.getMimetype("MP4") == "video/mp4"
assert m.getMimetype("INVALID") == "text/plain"

## uri
import std/uri

let host = parseUri("https://nim-lang.org")
assert $host == "https://nim-lang.org"
assert $(host / "/blog.html") == "https://nim-lang.org/blog.html"
assert $(host / "blog2.html") == "https://nim-lang.org/blog2.html"

let res = parseUri("sftp://127.0.0.1:4343")
assert isAbsolute(res)
assert res.port == "4343"
let foo = parseUri("https://nim-lang.org/foo/bar") / "/baz"
assert foo.path == "/foo/bar/baz"
assert foo.hostname == "nim-lang.org"
assert foo.scheme == "https"

let bar = parseUri("ftp://Username:Password@Hostname")
assert bar.username == "Username"
assert bar.password == "Password"
assert bar.scheme == "ftp"

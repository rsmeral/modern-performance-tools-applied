from net.grinder.script.Grinder import grinder
from net.grinder.script import Test
from net.grinder.plugin.http import HTTPRequest

test1 = Test(1, "HTTP GET")
request1 = HTTPRequest(url = "http://server:8080")
test1.record(request1)

class TestRunner:
    def __call__(self):
        request1.GET("/echoapp/http/echo")

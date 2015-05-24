from net.grinder.script.Grinder import grinder
from net.grinder.script import Test
from cz.muni.fi.xsmeral.echoapp.ws import WsEchoEndpoint
from cz.muni.fi.xsmeral.echoapp.ws import EchoService

test1 = Test(1, "WS Invoke")
ws = EchoService().getEcho()
test1.record(ws)

class TestRunner:
    def __call__(self):
        ws.sayHello()

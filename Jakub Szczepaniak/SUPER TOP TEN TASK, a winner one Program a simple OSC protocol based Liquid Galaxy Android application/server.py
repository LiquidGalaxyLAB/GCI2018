import argparse
import os

from pythonosc import dispatcher
from pythonosc import osc_server


def query_handler(unused_addr, args):
	print("query received ~ {0}".format(args))
	file = open(os.path.join('/tmp/query.txt'), "w")
	file.write(args)
	file.close()
	print("query sent to earth ~ {0}".format(args))


if __name__ == "__main__":
	parser = argparse.ArgumentParser()
	parser.add_argument("--ip",
						default="0.0.0.0", help="The ip to listen on")
	parser.add_argument("--port",
						type=int, default=5005, help="The port to listen on")
	args = parser.parse_args()

	dispatcher = dispatcher.Dispatcher()
	dispatcher.map("/tmp/query.txt", query_handler)

	server = osc_server.ThreadingOSCUDPServer(
		(args.ip, args.port), dispatcher)
	print("Serving on {}".format(server.server_address))
	server.serve_forever()

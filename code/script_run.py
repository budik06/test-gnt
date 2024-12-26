from http.server import BaseHTTPRequestHandler, HTTPServer
import subprocess
import json

class RequestHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path == '/':
            # Run the shell script
            try:
                # Execute the shell script
                result = subprocess.run(['./script.sh'], capture_output=True, text=True, check=True)
                output = result.stdout.strip()  # Get the standard output
                status_code = 200  # Success
            except subprocess.CalledProcessError as e:
                output = e.stderr.strip()  # Get the error output
                status_code = 500  # Internal Server Error
            except Exception as e:
                output = str(e)  # General error
                status_code = 500  # Internal Server Error

            # Prepare the response
            response = {
                "status": "success" if status_code == 200 else "error",
                "output": output
            }

            # Send the response
            self.send_response(status_code)
            self.send_header('Content-type', 'application/json')
            self.end_headers()
            self.wfile.write(json.dumps(response).encode('utf-8'))
        else:
            self.send_response(404)
            self.end_headers()

def run(server_class=HTTPServer, handler_class=RequestHandler, port=80):
    server_address = ('', port)
    httpd = server_class(server_address, handler_class)
    print(f'Starting HTTP server on port {port}...')
    httpd.serve_forever()

if __name__ == "__main__":
    run()
from http.server import HTTPServer, BaseHTTPRequestHandler
import json, os, datetime

class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path == '/health':
            response = {
                "status": "healthy",
                "app": os.environ.get("APP_NAME", "unknown"),
                "version": os.environ.get("APP_VERSION", "0.0.1"),
                "timestamp": datetime.datetime.now().isoformat()
            }
            self.send_response(200)
            self.send_header('Content-Type', 'application/json')
            self.end_headers()
            self.wfile.write(json.dumps(response).encode())
        else:
            self.send_response(404)
            self.end_headers()
    def log_message(self, format, *args):
        print(f"[{datetime.datetime.now()}] {args[0]} {args[1]}")

if __name__ == '__main__':
    port = int(os.environ.get("PORT", 8000))
    print(f"Starting server on port {port}")
    HTTPServer(('0.0.0.0', port), Handler).serve_forever()
#!/usr/bin/env python3
"""
Combined HTTP server for file downloads and uploads
Serves files from current directory and accepts file uploads via POST
"""

import os
import sys
import html
import urllib.parse
import logging
from datetime import datetime
from http.server import HTTPServer, SimpleHTTPRequestHandler
from io import BytesIO


class UploadHTTPRequestHandler(SimpleHTTPRequestHandler):
    """HTTP request handler with file upload support"""

    def log_message(self, format, *args):
        """Override to log to file and console"""
        log_entry = f"{self.address_string()} - [{self.log_date_time_string()}] {format % args}"
        logging.info(log_entry)
        print(log_entry)

    def do_GET(self):
        """Handle GET requests - serve files and upload form"""
        if self.path == '/':
            self.send_upload_page()
        else:
            # Serve files normally
            SimpleHTTPRequestHandler.do_GET(self)

    def do_POST(self):
        """Handle POST requests - file uploads"""
        content_type = self.headers.get('Content-Type', '')

        if 'multipart/form-data' not in content_type:
            self.send_error(400, "Bad Request: Expected multipart/form-data")
            return

        # Parse the multipart form data
        try:
            boundary = content_type.split('boundary=')[1].encode()
            content_length = int(self.headers['Content-Length'])
            body = self.rfile.read(content_length)

            # Simple multipart parser
            parts = body.split(b'--' + boundary)

            for part in parts:
                if b'Content-Disposition' in part:
                    # Extract filename
                    if b'filename="' in part:
                        filename_start = part.find(b'filename="') + 10
                        filename_end = part.find(b'"', filename_start)
                        filename = part[filename_start:filename_end].decode('utf-8')

                        if filename:
                            # Extract file content
                            content_start = part.find(b'\r\n\r\n') + 4
                            content_end = part.rfind(b'\r\n')
                            file_content = part[content_start:content_end]

                            # Save file to current directory
                            filepath = os.path.join(os.getcwd(), filename)
                            with open(filepath, 'wb') as f:
                                f.write(file_content)

                            log_msg = f"File uploaded: {filename} ({len(file_content)} bytes) from {self.address_string()}"
                            logging.info(log_msg)
                            print(f"Uploaded: {filename} ({len(file_content)} bytes)")

            # Send success response
            self.send_response(200)
            self.send_header('Content-Type', 'text/html')
            self.end_headers()
            response = b"""
            <html>
            <head><title>Upload Success</title></head>
            <body>
            <h2>Upload Successful!</h2>
            <p><a href="/">Back to main page</a></p>
            </body>
            </html>
            """
            self.wfile.write(response)

        except Exception as e:
            error_msg = f"Upload error from {self.address_string()}: {e}"
            logging.error(error_msg)
            print(f"Upload error: {e}")
            self.send_error(500, f"Upload failed: {str(e)}")

    def send_upload_page(self):
        """Send the main page with upload form and file listing"""
        try:
            # List files in current directory
            files = []
            for item in os.listdir('.'):
                if os.path.isfile(item):
                    size = os.path.getsize(item)
                    files.append((item, size))

            files.sort()

            # Build file list HTML
            file_list_html = ""
            for filename, size in files:
                encoded_name = urllib.parse.quote(filename)
                file_list_html += f'<li><a href="{encoded_name}">{html.escape(filename)}</a> ({size:,} bytes)</li>\n'

            if not file_list_html:
                file_list_html = "<li>No files in current directory</li>"

            # Build response page
            response = f"""
            <!DOCTYPE html>
            <html>
            <head>
                <title>HTTP File Server</title>
                <style>
                    body {{
                        font-family: Arial, sans-serif;
                        max-width: 800px;
                        margin: 50px auto;
                        padding: 20px;
                    }}
                    h1 {{
                        color: #333;
                    }}
                    .upload-form {{
                        background: #f5f5f5;
                        padding: 20px;
                        border-radius: 5px;
                        margin: 20px 0;
                    }}
                    .file-list {{
                        background: #fff;
                        padding: 20px;
                        border: 1px solid #ddd;
                        border-radius: 5px;
                    }}
                    input[type="file"] {{
                        margin: 10px 0;
                    }}
                    input[type="submit"] {{
                        background: #4CAF50;
                        color: white;
                        padding: 10px 20px;
                        border: none;
                        border-radius: 4px;
                        cursor: pointer;
                    }}
                    input[type="submit"]:hover {{
                        background: #45a049;
                    }}
                    ul {{
                        list-style-type: none;
                        padding: 0;
                    }}
                    li {{
                        padding: 5px 0;
                    }}
                </style>
            </head>
            <body>
                <h1>HTTP File Server</h1>
                <p>Current directory: {html.escape(os.getcwd())}</p>

                <div class="upload-form">
                    <h2>Upload File</h2>
                    <form method="POST" enctype="multipart/form-data">
                        <input type="file" name="file" required>
                        <br>
                        <input type="submit" value="Upload">
                    </form>
                </div>

                <div class="file-list">
                    <h2>Available Files</h2>
                    <ul>
                        {file_list_html}
                    </ul>
                </div>
            </body>
            </html>
            """.encode('utf-8')

            self.send_response(200)
            self.send_header('Content-Type', 'text/html; charset=utf-8')
            self.send_header('Content-Length', str(len(response)))
            self.end_headers()
            self.wfile.write(response)

        except Exception as e:
            self.send_error(500, f"Error generating page: {str(e)}")


def run_server(port=80):
    """Start the HTTP server"""
    # Set up logging to file in current working directory
    log_file = os.path.join(os.getcwd(), 'http_server_log.txt')
    logging.basicConfig(
        filename=log_file,
        level=logging.INFO,
        format='%(asctime)s - %(levelname)s - %(message)s',
        datefmt='%Y-%m-%d %H:%M:%S'
    )

    server_address = ('', port)

    try:
        httpd = HTTPServer(server_address, UploadHTTPRequestHandler)
        startup_msg = f"Server started on port {port}, serving directory: {os.getcwd()}"
        logging.info(startup_msg)
        print(f"Server running on port {port}")
        print(f"Serving directory: {os.getcwd()}")
        print(f"Log file: {log_file}")
        print(f"Access at: http://localhost:{port}/")
        print("Press Ctrl+C to stop")
        httpd.serve_forever()
    except PermissionError:
        error_msg = f"Permission denied to bind to port {port}"
        logging.error(error_msg)
        print(f"Error: Permission denied to bind to port {port}")
        print("Port 80 requires root/administrator privileges")
        print("Run with: sudo python3 http_server.py")
        sys.exit(1)
    except KeyboardInterrupt:
        shutdown_msg = "Server stopped by user"
        logging.info(shutdown_msg)
        print("\nServer stopped")
        sys.exit(0)


if __name__ == '__main__':
    port = 80

    # Allow custom port via command line argument
    if len(sys.argv) > 1:
        try:
            port = int(sys.argv[1])
        except ValueError:
            print(f"Invalid port number: {sys.argv[1]}")
            sys.exit(1)

    run_server(port)

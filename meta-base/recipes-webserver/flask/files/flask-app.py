from flask import Flask, jsonify
import netifaces

app = Flask(__name__)

@app.route('/api/status', methods=['GET'])
def status():
    return jsonify({"status": "running", "message": "flask server is active on multiple interfaces"})

def get_network_interfaces():
    """Holt alle IP-Adressen der aktiven Schnittstellen"""
    interfaces = []
    for interface in netifaces.interfaces():
        if interface not in ["lo"]:  # Loopback-Schnittstelle ignorieren
            addresses = netifaces.ifaddresses(interface).get(netifaces.AF_INET, [])
            for addr in addresses:
                interfaces.append(addr["addr"])
    return interfaces

if __name__ == '__main__':
    interfaces = get_network_interfaces()
    # for ip in interfaces:
    #    print(f"Starting Flask on {ip}:5000")
    app.run(host='0.0.0.0', port=5000)

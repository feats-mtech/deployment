# Allow inbound traffic to the Kubernetes Load Balancer
resource "digitalocean_firewall" "app_firewall" {
  name = "app-firewall"

  droplet_ids = [] # Optional, but leave empty for Kubernetes

  inbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    source_addresses = ["0.0.0.0/0"] # Public traffic
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "443"
    source_addresses = ["0.0.0.0/0"] # Public HTTPS traffic
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "all"
    destination_addresses = ["0.0.0.0/0"]
  }
}
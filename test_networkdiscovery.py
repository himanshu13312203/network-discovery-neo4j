import sys
import os
import unittest
import ipaddress

# Add parent directory to sys.path for module discovery
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

from networkdiscovery import get_local_ip_and_netmask, get_subnet

class TestNetworkDiscovery(unittest.TestCase):
    def test_get_local_ip_and_netmask_returns_tuple(self):
        ip, netmask = get_local_ip_and_netmask()
        self.assertIsInstance(ip, str)
        self.assertIsInstance(netmask, str)
        self.assertEqual(len(ip.split(".")), 4)
        self.assertEqual(len(netmask.split(".")), 4)

    def test_get_subnet(self):
        subnet = get_subnet("192.168.1.10", "255.255.255.0")
        self.assertIsInstance(subnet, ipaddress.IPv4Network)
        self.assertEqual(str(subnet.network_address), "192.168.1.0")
        self.assertEqual(subnet.prefixlen, 24)

if __name__ == '__main__':
    unittest.main()
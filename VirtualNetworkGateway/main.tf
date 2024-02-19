# Creates GateWay Subnet and Virtual Network Gateway
# Uploads root certificate to the Gateway. Self-signed Root certificate can be found
# from .\data folder.

# Creation of the Gateway Subnet in the given Virtual Network
resource "azurerm_subnet" "gateway_subnet" {
  name                 = "GatewaySubnet"
  resource_group_name  = var.rg_name
  virtual_network_name = var.vnet_name
  address_prefixes     = [var.vnet_gateway_subnet_address_space]
}

resource "azurerm_public_ip" "public_ip" {
  name                = "${var.vnet_name}-public-ip"
  location            = var.region
  resource_group_name = var.rg_name

  allocation_method = "Dynamic"
}

#Creation of the Virtual Network Gateway. Root certificate is uploaded at the same time.
resource "azurerm_virtual_network_gateway" "vnet_gateway" {
  name                = "${var.vnet_name}GW"
  location            = var.region
  resource_group_name = var.rg_name

  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = false
  enable_bgp    = false
  sku           = "VpnGw1"

  ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.gateway_subnet.id
  }

  vpn_client_configuration {
    address_space        = [var.p2s_address_pool]
    vpn_auth_types       = ["Certificate"]
    vpn_client_protocols = ["IkeV2", "OpenVPN"]

    root_certificate {
      name = "P2S-Root-CA"

      public_cert_data = <<EOF
MIIC5zCCAc+gAwIBAgIQcin1We2QLY5EH2Ysq/zzNjANBgkqhkiG9w0BAQsFADAW
MRQwEgYDVQQDDAtQMlNSb290Q2VydDAeFw0yNDAyMTExMTU4NDNaFw0yNjAyMTEx
MjA4MTJaMBYxFDASBgNVBAMMC1AyU1Jvb3RDZXJ0MIIBIjANBgkqhkiG9w0BAQEF
AAOCAQ8AMIIBCgKCAQEAxN8Z+JqDmKc9cN+kAuKI53DHfc1quX2WbuPFgpZyG/M0
++cP7wI1y82YA+rHKELM/WV2Kzj1e1MNyCL0/3T7T/P4NHNsBZGiwARpdUouPGgC
XuVrCpSE4N6HBv1PSazUX1SrvTi5KKc9LJYKNE6FYRXf5xO9eGlHzGzTt6et5zo1
6TiXS/QeEKUnFASOuj6laszHlh+8huyrk/XKwapxymydb+ceClG774ZagSVLLQBi
wV6zOn6+hRFvccebKnrlhDTXP/2uKSq0Fv+6QUC7G6UokDiUU0jLPT3nsTNez3dO
R6wfGCaHz/39VeErsFioN13E/t96CVra7fsT+z1pWQIDAQABozEwLzAOBgNVHQ8B
Af8EBAMCAgQwHQYDVR0OBBYEFPqTCOjpJSSPLJNiAr8h5FRtSnEAMA0GCSqGSIb3
DQEBCwUAA4IBAQCp8ytXdkIkbLymyRKzbakVIvaCOWtROGEFKzL+l+HMDquQJpm1
ol/oxXDgPINx7F/jNeqgGrc0kc23mPNIzt65od3TzwDtoW8EnQPQIJvD8BVeW4mv
w94PRhMfD4BPxxWFBMQdN05VSNMSWyPxyDApy6cnAtMQaGLdalO80Kgybjsx0aNr
1tObLViVVtjmnaPED40CUJDkL//0RHxfDHMk0gr4Jol4zse0seKPJjpt/UE8LxMY
Zi8aPvBLtnZ8/zM5aYhpxGPmnJ/Yhhm9bAF/J3WFgjIuV4c+HDXa0qZBsC6ZFSuG
OHOgIDrg8GtdNUWDm01SlG0h9kIGlhd1AahG
EOF

    }
  }
  depends_on = [azurerm_subnet.gateway_subnet]
}
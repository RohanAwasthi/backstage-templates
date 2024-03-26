create_resource_group = true
location              = "South India"
resource_group_name   = "cloudifyrgmit"
tags = {
  contact_name     = "Mitali Ghoshal"
  contact_email    = "Mitali.Ghoshal@gds.ey.com"
  project          = "CLOUDIFY"
  region           = "South India"
  Application_name = "Dev"
}
vnet = {
  "vnet-1" = {
    address_space = ["10.0.0.0/16"]
    tags = {
      contact_name     = "Mitali Ghoshal"
      contact_email    = "Mitali.Ghoshal@gds.ey.com"
      project          = "CLOUDIFY"
      region           = "South India"
      Application_name = "Dev"
    }
  },
  "vnet-3" = {
    address_space = ["10.2.0.0/16"]
    tags = {
      contact_name     = "Mitali Ghoshal"
      contact_email    = "Mitali.Ghoshal@gds.ey.com"
      project          = "CLOUDIFY"
      region           = "South India"
      Application_name = "Dev"
    }
  },
  "vnet-2" = {
    address_space = ["10.1.0.0/16"]
    tags = {
      contact_name     = "Mitali Ghoshal"
      contact_email    = "Mitali.Ghoshal@gds.ey.com"
      project          = "CLOUDIFY"
      region           = "South India"
      Application_name = "Dev"
    }
  }
}
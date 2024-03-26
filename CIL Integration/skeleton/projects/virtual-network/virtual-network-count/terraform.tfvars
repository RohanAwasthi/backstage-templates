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
vnet = [{
  name          = "v-1"
  address_space = ["10.50.0.0/16"]
  tags = {
    contact_name     = "Mitali Ghoshal"
    contact_email    = "Mitali.Ghoshal@gds.ey.com"
    project          = "CLOUDIFY"
    region           = "South India"
    Application_name = "Dev"
  }
  },
  {
    name          = "v-2"
    address_space = ["10.51.0.0/16"]
    tags = {
      contact_name     = "Mitali Ghoshal"
      contact_email    = "Mitali.Ghoshal@gds.ey.com"
      project          = "CLOUDIFY"
      region           = "South India"
      Application_name = "Dev"
    }
}]
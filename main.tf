provider "google" {
  project = "gcp-20210526-001"
}

resource "google_compute_instance" "default" {
  name        = "test"
  description = "我是 test 機器"
  machine_type = "n2-standard-8"
  zone = "asia-east1-b"
  tags = ["test"]
  
  labels = {
    env  = "test"
  }

  deletion_protection = "true" 

  boot_disk {
    device_name = "gitlab-test"
    initialize_params {
      image = "debian-cloud/debian-10-buster-v20210512"
      type = "pd-balanced"
      size = "50"
    }
  }

  network_interface {
    network = "projects/rd-gateway/global/networks/rd-common"
    subnetwork = "projects/rd-gateway/regions/asia-east1/subnetworks/rd-common-asia-east1-pid-cicd"     

    access_config {
      nat_ip = ""
    }

  }

  service_account {
    email  = "676962704505-compute@developer.gserviceaccount.com"
    scopes = ["storage-rw", "logging-write", "monitoring-write", "service-control", "service-management", "trace"]
  }
}
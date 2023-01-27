resource "checkly_check" "browser_check" {
  name                      = "Webserver check"
  type                      = "API"
  activated                 = true
  should_fail               = false
  frequency                 = 10
  double_check              = true
  use_global_alert_settings = true

  locations = [
    "eu-west-1",
    "eu-west-2"
  ]

  tags = ["aws", "terraform"]

  request {
    url              = "http://${aws_instance.webserver.public_dns}"
    follow_redirects = true
    body_type        = "JSON"
    method           = "GET"

    assertion {
      source     = "STATUS_CODE"
      comparison = "EQUALS"
      target     = "200"
    }
  }
}

resource "checkly_check" "elasticache_check" {
  name                      = "Elasticache check"
  type                      = "API"
  activated                 = true
  should_fail               = false
  frequency                 = 10
  double_check              = true
  use_global_alert_settings = true

  private_locations = [
    "new-location"
  ]

  tags = ["aws", "terraform", "private"]

  request {
    url              = "http://${aws_instance.checkly.private_ip}:8080/healthz"
    follow_redirects = true
    body_type        = "JSON"
    method           = "GET"

    assertion {
      source     = "STATUS_CODE"
      comparison = "EQUALS"
      target     = "200"
    }

    assertion {
      source     = "JSON_BODY"
      property   = "$.results[1].found"
      comparison = "EQUALS"
      target     = "PONG"
    }

  }
}

resource "checkly_check" "rds_check" {
  name                      = "RDS check"
  type                      = "API"
  activated                 = true
  should_fail               = false
  frequency                 = 10
  double_check              = true
  use_global_alert_settings = true

  private_locations = [
    "new-location"
  ]

  tags = ["aws", "terraform", "private"]

  request {
    url              = "http://${aws_instance.checkly.private_ip}:8080/healthz"
    follow_redirects = true
    body_type        = "JSON"
    method           = "GET"

    assertion {
      source     = "STATUS_CODE"
      comparison = "EQUALS"
      target     = "200"
    }

    assertion {
      source     = "JSON_BODY"
      property   = "$.results[3].found"
      comparison = "EQUALS"
      target     = "1"
    }
  }
}

resource "checkly_dashboard" "dashboard_1" {
  custom_url      = "aws-checkly-private-location"
  custom_domain   = "www.gordonmurray.com"
  header          = "AWS Infrastructure dashboard"
  refresh_rate    = 60
  paginate        = false
  pagination_rate = 30
  hide_tags       = false
  width           = "FULL"
  tags = [
    "private"
  ]
}
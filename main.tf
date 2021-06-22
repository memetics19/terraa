provider "aws" {
  region = "ap-south-1"
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_ses_domain_identity" "domain" {
  domain = "example.com"
}
resource "aws_ses_email_identity" "email" {
  email = "email@example.com"
}

resource "aws_ses_domain_mail_from" "example" {
  domain = aws_ses_domain_identity.domain.domain
  mail_from_domain = "bounce.${aws_ses_domain_identity.domain.domain}"
}

resource "aws_route53_record" "ses_verification_record" {
  zone_id =  var.zone_id
  name    = var.ses_name
  type    = var.record_type
  ttl     = var.ses_ttl
  records = [aws_ses_domain_identity.domain.verification_token]
}

resource "aws_sns_topic" "user_topic" {
  name = "user-updates-topic"
    delivery_policy = <<JSON
  {
  "http": {
    "defaultHealthyRetryPolicy": {
      "minDelayTarget"    : 20,
      "maxDelayTarget"    : 600,
      "numRetries"        : 5,
      "backoffFunction"   : "exponential"
    },
    "disableSubscriptionOverrides": false
  }
}
JSON
}

resource "aws_sns_topic_subscription" "email_target" {
  topic_arn = aws_sns_topic.user_topic.arn
  protocol  = "email"
  endpoint  = "example@gmail.com"
}








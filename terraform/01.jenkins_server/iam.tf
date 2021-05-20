// create user group
resource "aws_iam_group" "group" {
  name = "app-admin"
  path = "/"
}

// create user app-admin
resource "aws_iam_user" "iamuser" {
    name = "sa-admin"
    path = "/"
}

// associating the newly created user to the group
resource "aws_iam_group_membership" "app-admin-membership" {
    name = "app-admin-membership"
    users = [
        "${aws_iam_user.iamuser.name}",
    ]
    group = "${aws_iam_group.group.name}"
}

// attaching the user policy
resource "aws_iam_policy_attachment" "admin-policy-attachment2" {
    name = "admin-policy-attachment2"
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
    groups = ["${aws_iam_group.group.id}"]
}

resource "aws_iam_policy_attachment" "admin-policy-attachment3" {
    name = "admin-policy-attachment3"
    policy_arn = "arn:aws:iam::aws:policy/AmazonRoute53FullAccess"
    groups = ["${aws_iam_group.group.id}"]
}

resource "aws_iam_policy_attachment" "admin-policy-attachment4" {
    name = "admin-policy-attachment4"
    policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
    groups = ["${aws_iam_group.group.id}"]
}

resource "aws_iam_group_policy" "bg-participant-policy" {
    name = "bg-participant-policy"
    group = "${aws_iam_group.group.id}"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
                "cloudformation:CreateUploadBucket",
                "cloudformation:ListExports",
                "cloudformation:CancelUpdateStack",
                "cloudformation:UpdateTerminationProtection",
                "cloudformation:DescribeStackResource",
                "cloudformation:CreateStack",
                "cloudformation:CreateChangeSet",
                "cloudformation:DeleteChangeSet",
                "cloudformation:ContinueUpdateRollback",
                "cloudformation:EstimateTemplateCost",
                "cloudformation:DescribeStackEvents",
                "cloudformation:UpdateStack",
                "cloudformation:DescribeAccountLimits",
                "cloudformation:DescribeChangeSet",
                "cloudformation:ExecuteChangeSet",
                "cloudformation:ListStackResources",
                "cloudformation:SetStackPolicy",
                "cloudformation:ListStacks",
                "cloudformation:ListImports",
                "cloudformation:DescribeStackResources",
                "cloudformation:SignalResource",
                "cloudformation:GetTemplateSummary",
                "cloudformation:DescribeStacks",
                "cloudformation:PreviewStackUpdate",
                "cloudformation:GetStackPolicy",
                "cloudformation:CreateStack",
                "cloudformation:GetTemplate",
                "cloudformation:DeleteStack",
                "cloudformation:ValidateTemplate",
                "cloudformation:ListChangeSets"
            ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

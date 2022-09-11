resource "aws_iam_user" "dev" {
  name = "developer"
  path = "/"

  tags = {
    tag-key = "Developer"
  }
}

resource "aws_iam_access_key" "dev" {
  user = aws_iam_user.dev.name
}

resource "aws_iam_user_policy" "dev_rw" {
  name = "dynamodb-full-access"
  user = aws_iam_user.dev.name

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "ListAndDescribe",
            "Effect": "Allow",
            "Action": [
                "dynamodb:List*",
                "dynamodb:DescribeReservedCapacity*",
                "dynamodb:DescribeLimits",
                "dynamodb:DescribeTimeToLive"
            ],
            "Resource": "*"
        },
        {
            "Sid": "SpecificTable",
            "Effect": "Allow",
            "Action": [
                "dynamodb:BatchGet*",
                "dynamodb:DescribeStream",
                "dynamodb:DescribeTable",
                "dynamodb:Get*",
                "dynamodb:Query",
                "dynamodb:Scan",
                "dynamodb:BatchWrite*",
                "dynamodb:CreateTable",
                "dynamodb:Delete*",
                "dynamodb:Update*",
                "dynamodb:PutItem"
            ],
            "Resource": "arn:aws:dynamodb:*:*:table/Parsley"
        }
    ]
}
EOF
}

#######################################################################################

resource "aws_iam_user" "manager" {
  name = "product-manager"
  path = "/"

  tags = {
    tag-key = "product-manager"
  }
}

resource "aws_iam_access_key" "manager" {
  user = aws_iam_user.manager.name
}

resource "aws_iam_user_policy" "manager_ro" {
  name = "dynamodb-ro-access-specific-key"
  user = aws_iam_user.manager.name

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "ListAndDescribe",
            "Effect": "Allow",
            "Action": [
                "dynamodb:List*",
                "dynamodb:DescribeReservedCapacity*",
                "dynamodb:DescribeLimits",
                "dynamodb:DescribeTimeToLive"
            ],
            "Resource": "*"
        },
        {
            "Sid": "ReadOnlyAccessToUserItems",
            "Effect": "Allow",
            "Action": [
                "dynamodb:Get*",
                "dynamodb:BatchGet*",
                "dynamodb:Query",
                "dynamodb:DescribeStream",
                "dynamodb:DescribeTable"                
            ],
            "Resource": [
                "arn:aws:dynamodb:*:*:table/Parsley"
            ],
            "Condition": {
                "ForAllValues:StringEquals": {
                    "dynamodb:LeadingKeys": [
                        "Parsley-2"
                    ]
                }
            }
        }
    ]
}

EOF
}


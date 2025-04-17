# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the "Software"), to deal in
# the Software without restriction, including without limitation the rights to
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
# the Software, and to permit persons to whom the Software is furnished to do so.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
# FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
# COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
# IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# AWS Control Tower Controls (sometimes called Guardrails) Terraform Module

data "aws_organizations_organization" "organization" {}

# Get OUs data resources up to five levels of OUs deep under a root (maximum nesting quota limit)
data "aws_organizations_organizational_units" "root" {
  parent_id = data.aws_organizations_organization.organization.roots[0].id
}

data "aws_organizations_organizational_units" "ous_depth_1" {
  for_each  = toset([for x in data.aws_organizations_organizational_units.root.children : x.id])
  parent_id = each.key
  depends_on = [
    data.aws_organizations_organizational_units.root
  ]
}

data "aws_organizations_organizational_units" "ous_depth_2" {
  for_each  = toset([for y in flatten([for x in data.aws_organizations_organizational_units.ous_depth_1 : x.children]) : y.id])
  parent_id = each.key
  depends_on = [
    data.aws_organizations_organizational_units.ous_depth_1
  ]
}

data "aws_organizations_organizational_units" "ous_depth_3" {
  for_each  = toset([for y in flatten([for x in data.aws_organizations_organizational_units.ous_depth_2 : x.children]) : y.id])
  parent_id = each.key
  depends_on = [
    data.aws_organizations_organizational_units.ous_depth_2
  ]
}

data "aws_organizations_organizational_units" "ous_depth_4" {
  for_each  = toset([for y in flatten([for x in data.aws_organizations_organizational_units.ous_depth_3 : x.children]) : y.id])
  parent_id = each.key
  depends_on = [
    data.aws_organizations_organizational_units.ous_depth_3
  ]
}


locals {

  # Combine both types of controls
  normalized_controls = concat(
    # Convert simple controls to the complex format
    [
      for group in var.controls : {
        control_names = [
          for control in group.control_names : {
            (control) = {}
          }
        ]
        organizational_unit_ids = group.organizational_unit_ids
      }
    ],
    var.controls_with_params
  )

  # Extract Guardrails configuration
  guardrails_list = flatten([
    for control_group in local.normalized_controls : [
      for control in control_group.control_names : [
        for ou_id in control_group.organizational_unit_ids : {
          control_id = keys(control)[0]
          ou_id      = ou_id
          parameters = try(
            # Get parameters if they exist, filter out empty lists
            {
              for k, v in values(control)[0].parameters :
              k => v
              if length(v) > 0
            },
            null
          )
          # parameters  = try(values(control)[0].parameters, null)
          tags = try(values(control)[0].tags, null)
        }
      ]
    ]
  ])

  ous_depth_1 = [for x in data.aws_organizations_organizational_units.root.children : x]
  ous_depth_2 = flatten([for x in data.aws_organizations_organizational_units.ous_depth_1 : x.children if length(x.children) != 0])
  ous_depth_3 = flatten([for x in data.aws_organizations_organizational_units.ous_depth_2 : x.children if length(x.children) != 0])
  ous_depth_4 = flatten([for x in data.aws_organizations_organizational_units.ous_depth_3 : x.children if length(x.children) != 0])
  ous_depth_5 = flatten([for x in data.aws_organizations_organizational_units.ous_depth_4 : x.children if length(x.children) != 0])

  # Compute map from OU id to OU arn for the whole organization
  ous_id_to_arn_map = { for ou in concat(local.ous_depth_1, local.ous_depth_2, local.ous_depth_3, local.ous_depth_4, local.ous_depth_5) :
    ou.id => ou.arn
  }
}

resource "aws_controltower_control" "guardrails" {
  for_each = { for item in local.guardrails_list : "${item.control_id}:${item.ou_id}" => item }

  control_identifier = "arn:aws:controlcatalog:::control/${each.value.control_id}"
  target_identifier  = local.ous_id_to_arn_map[each.value.ou_id]

  dynamic "parameters" {
    for_each = each.value.parameters != null ? each.value.parameters : {}
    content {
      key   = parameters.key
      value = jsonencode(parameters.value)
    }
  }

}

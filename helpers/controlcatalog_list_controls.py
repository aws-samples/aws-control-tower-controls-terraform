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

from typing import Any, Dict, List, Tuple, Union

import boto3
import pandas as pd


def flatten_dict(
    d: Dict[str, Any], parent_key: str = "", sep: str = "_"
) -> Dict[str, Union[str, int, float, bool, None]]:
    """
    Flatten a nested dictionary into a single level dictionary.

    Args:
        d: The nested dictionary to flatten
        parent_key: The parent key for nested values
        sep: Separator to use between nested keys

    Returns:
        A flattened dictionary with concatenated keys
    """
    items: List[Tuple[str, Union[str, int, float, bool, None]]] = []

    for k, v in d.items():
        new_key: str = f"{parent_key}{sep}{k}" if parent_key else k

        if isinstance(v, dict):
            items.extend(flatten_dict(v, new_key, sep=sep).items())
        else:
            items.append((new_key, v))

    return dict(items)


def get_control_tower_controls() -> pd.DataFrame:
    # Create AWS Control Catalog client
    client = boto3.client("controlcatalog")

    paginator = client.get_paginator("list_controls")

    flatten_controls = []
    # Paginate through all controls
    for page in paginator.paginate():
        for control in page["Controls"]:
            flat_data = flatten_dict(control)
            # Convert to DataFrame
            flatten_controls.append(flat_data)

    return pd.DataFrame(flatten_controls)


if __name__ == "__main__":
    # Get all controls
    df = get_control_tower_controls()
    # Define the CSV file name
    CSV_FILE = "controlcatalog_list_controls.csv"

    # Export DataFrame to CSV
    df.to_csv(CSV_FILE, index=False)

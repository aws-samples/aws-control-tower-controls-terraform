# Extract Controls Using Control Catalog API

[The Control Catalog](https://docs.aws.amazon.com/controlcatalog/latest/userguide/what-is-controlcatalog.html) is a part of AWS Control Tower, which lists controls for several AWS services. It is a consolidated catalog of AWS controls. AWS Control Catalog is available through the console and through the AWS Control Catalog application programming interface (API).
For more information, see the [AWS Control Catalog API Reference](https://docs.aws.amazon.com/controlcatalog/latest/APIReference/Welcome.html).

The provide helper Python script allows to export all controls using the AWS Control Catalog API to a csv file for a compherensive view of all available controls.

To use the helper script:

1. Assume the IAM role that has permissions to use the AWS control Catalog API. For more information about assuming an IAM role in the AWS CLI, see [Use an IAM role in the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-role.html).

2. If you are using Linux or MacOS:
    1.	Enter the following command to create a virtual environment.
        ```
        $ python3 -m venv .venv
        ```
    2.	After the virtual environment is created, enter the following command to activate it.
        ```
        $ source .venv/bin/activate
        ```
3. If you are using Windows:
    1.	Enter the following command to activate a virtual environment.
        ```
        % .venv\Scripts\activate.bat
        ```

4. After the virtual environment is activated, enter the following command to install the dependencies.
    ```
    $ pip install -r helpers/requirements.txt
    ```

5. From the helpers folder execute the scrip to export AWS controls to a csv file.
    ```
    $ python3 controlcatalog_list_controls.py
    ```
An example of exported controls is provided in the helpers folder [here](controlcatalog_list_controls.csv).

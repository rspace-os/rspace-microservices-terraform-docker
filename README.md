This project contains Terraform configuration file to deploy add-on services for RSpace.

It performs the same tasks described in [RSpace HelpDocs](https://researchspace.helpdocs.io/article/5k7qib0n3t-installation-of-rspace-add-on-services)
.

Docker must already be installed on the server that will run the containers.

To use, customise `main.tf` to install and launch the Docker containers you require.

You must also supply an access token for ResearchSpace Dockerhub, which will be supplied
on request by ResearchSpace.

This can be saved as an environment variable that Terraform can re-use.

    export TF_VAR_dockerhub_pw=XXXXXX 
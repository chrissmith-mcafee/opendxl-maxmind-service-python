# Base image from Python 2.7 (slim)
FROM python:2.7-slim

VOLUME ["/opt/dxlmaxmindservice-config"]

# Install required packages
RUN pip install "requests"
RUN pip install "maxminddb"
RUN pip install "dxlbootstrap"
RUN pip install "dxlclient"

# Build service
COPY . /tmp/build
WORKDIR /tmp/build
RUN python ./setup.py bdist_wheel

# Install service
RUN pip install dist/*.whl

# Cleanup build
RUN rm -rf /tmp/build

################### INSTALLATION END #######################
#
# Run the application.
#
# NOTE: The configuration files for the application must be
#       mapped to the path: /opt/dxlmaxmindservice-config
#
# For example, specify a "-v" argument to the run command
# to mount a directory on the host as a data volume:
#
#   -v /host/dir/to/config:/opt/dxlmaxmindservice-config
#
CMD ["python", "-m", "dxlmaxmindservice", "/opt/dxlmaxmindservice-config"]

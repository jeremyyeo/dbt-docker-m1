FROM python:3.9

# Update and install system packages
# https://github.com/davidgasquez/dbt-docker/blob/master/Dockerfile
RUN apt-get update -y && \
  apt-get install --no-install-recommends -y -q \
  git libpq-dev python-dev vim && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install dbt
RUN pip install -U pip
RUN pip install dbt==0.21.0

# Set environment variables
ENV DBT_DIR /dbt

# Set working directory
WORKDIR $DBT_DIR

# Run dbt
CMD ["dbt"]

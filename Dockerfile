##### build stage ##############################################################

ARG TARGET_ARCHITECTURE
ARG BASE=7.0.7ec3
ARG REGISTRY=ghcr.io/epics-containers

FROM  ${REGISTRY}/epics-base-${TARGET_ARCHITECTURE}-developer:${BASE} AS developer

# Get latest ibek while in development. Will come from epics-base when stable
COPY requirements.txt requirements.txt
RUN pip install --upgrade -r requirements.txt

# The devcontainer mounts the project root to /epics/ioc-adsimdetector. Using
# the same location here makes devcontainer/runtime differences transparent.
WORKDIR /epics/ioc-ts99i-ps-01/ibek-support

# copy the global ibek files
COPY ibek-support/_global/ _global

COPY ibek-support/iocStats/ iocStats
RUN iocStats/install.sh 3.1.16

# non-generic specifics for ts99i-ps-01 --- TODO genericize
RUN apt-get update && apt-get install -y libxml2-dev libssl-dev

# compile the IOC instance
COPY ioc/ /epics/ioc-ts99i-ps-01/ioc
RUN cd /epics/ioc-ts99i-ps-01/ioc && make
# TODO remove when OPC UA is a proper support module
RUN ln -s /epics/ioc-ts99i-ps-01/ioc /epics/ioc

##### runtime preparation stage ################################################

FROM developer AS runtime_prep

# get the products from the build stage and reduce to runtime assets only
RUN ibek ioc extract-runtime-assets /assets

##### runtime stage ############################################################

FROM ${REGISTRY}/epics-base-${TARGET_ARCHITECTURE}-runtime:${BASE} AS runtime

# get runtime assets from the preparation stage
COPY --from=runtime_prep /assets /

# install runtime system dependencies, collected from install.sh script
RUN ibek support apt-install --runtime
ENV TARGET_ARCHITECTURE ${TARGET_ARCHITECTURE}

# non-generic specifics for ts99i-ps-01 --- TODO genericize
RUN apt-get update && apt-get install -y libxml2 libssl-dev

# TODO remove these 2 when OPC UA is a proper support module
RUN unlinkg epics/ioc
COPY --from=developer /epics/ioc-ts99i-ps-01/ioc /epics/ioc

ENTRYPOINT ["/bin/bash", "-c", "${IOC}/start.sh"]

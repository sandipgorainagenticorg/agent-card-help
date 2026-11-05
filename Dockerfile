# syntax=docker/dockerfile:1
# The runtime image holds graph.py, server.py and every dependency. This image adds only
# the agent's configuration. Point AGENT_BUILDER_RUNTIME_IMAGE at your registry in CI.
ARG AGENT_BUILDER_RUNTIME_IMAGE=agent-builder-runtime:1.0.0
FROM ${AGENT_BUILDER_RUNTIME_IMAGE}

COPY agent.yaml /agent/agent.yaml
COPY prompts /agent/prompts

# Fails the build if agent.yaml, a prompt or a skill is not valid for this runtime, or if
# the contract tests fail. No model or tool is called.
RUN agent-builder check /agent && agent-builder test /agent

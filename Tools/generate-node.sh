#! /bin/bash

read -p 'UsecaseName: ' NODE_NAME

BASE_DIR=$(cd `dirname $0`; pwd)
NODE_GENERATION_DIR=("${BASE_DIR}/NodeGeneration")
NODE_DEST_DIR=("${BASE_DIR}/../Nodes/${NODE_NAME}")
COMPONENTS_DIR=("${BASE_DIR}/../Components")
TEMPLATES_DIR=("${NODE_GENERATION_DIR}/Templates")

mkdir -p $NODE_DEST_DIR
NODE_FILES_PATH="${NODE_DEST_DIR}/${NODE_NAME}"

eval "echo \"$(cat "${TEMPLATES_DIR}/Events.swift")\"" > "${NODE_FILES_PATH}Event.swift"
eval "echo \"$(cat "${TEMPLATES_DIR}/Presenter.swift")\"" > "${NODE_FILES_PATH}Presenter.swift"
eval "echo \"$(cat "${TEMPLATES_DIR}/Router.swift")\"" > "${NODE_FILES_PATH}Router.swift"
eval "echo \"$(cat "${TEMPLATES_DIR}/Renderer.swift")\"" > "${NODE_FILES_PATH}Renderer.swift"
eval "echo \"$(cat "${TEMPLATES_DIR}/Presenting.swift")\"" > "${NODE_FILES_PATH}Presenting.swift"
eval "echo \"$(cat "${TEMPLATES_DIR}/ViewState.swift")\"" > "${NODE_FILES_PATH}ViewState.swift"

echo "---> Successfully created ${NODE_NAME}"

eval "echo \"$(cat "${TEMPLATES_DIR}/Component.swift")\"" > "${COMPONENTS_DIR}/${NODE_NAME}Component.swift"

echo "---> Successfully created ${NODE_NAME}Component"

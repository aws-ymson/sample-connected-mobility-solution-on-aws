# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0

# ========================================================
# AWS CONFIGURATION
# ========================================================
DEFAULTS.AWS_ACCOUNT_ID := $(shell aws sts get-caller-identity --query "Account" --output text)
DEFAULTS.AWS_REGION := $(shell aws configure get region --output text)

export AWS_ACCOUNT_ID ?= ${DEFAULTS.AWS_ACCOUNT_ID}
export AWS_REGION ?= ${DEFAULTS.AWS_REGION}

# ========================================================
# SOLUTION METADATA
# ========================================================
export SOLUTION_NAME ?= connected-mobility-solution-on-aws
export SOLUTION_DESCRIPTION ?= Accelerate development and deployment of connected vehicle assets with purpose-built, deployment-ready accelerators, and an Automotive Cloud Developer Portal
export SOLUTION_VERSION ?= v2.1.6
export SOLUTION_AUTHOR = AWS Industrial Solutions Team
export SOLUTION_ID = SO0241
# Path is relative to this file's location, moving this file requires updating this path.
export SOLUTION_PATH := $(abspath $(dir $(lastword $(MAKEFILE_LIST)))/../)
export APPLICATION_TYPE = AWS-Solutions

# ========================================================
# ENVIRONMENT CONFIGURATION
# ========================================================
DEFAULTS.NODE_VERSION := $(shell cat .nvmrc 2> /dev/null)
DEFAULTS.PYTHON_VERSION := $(shell cat .python-version)

export NODE_VERSION ?= ${DEFAULTS.NODE_VERSION}
export PYTHON_VERSION ?= ${DEFAULTS.PYTHON_VERSION}

export PYTHON_MINIMUM_VERSION_SUPPORTED = 3.12
export PIPENV_IGNORE_VIRTUALENVS = 1
export PIPENV_VENV_IN_PROJECT = 1
export PIPENV_DEV = 1
export LANG = en_US.UTF-8

# ========================================================
# VARIABLES
# ========================================================
export REGIONAL_ASSET_BUCKET_BASE_NAME ?= acdp-assets-${AWS_ACCOUNT_ID}
export REGIONAL_ASSET_BUCKET_NAME ?= ${REGIONAL_ASSET_BUCKET_BASE_NAME}-${AWS_REGION}
export REGIONAL_PUBLIC_ASSET_BUCKET_BASE_NAME ?= acdp-public-assets-${AWS_ACCOUNT_ID}
export REGIONAL_PUBLIC_ASSET_BUCKET_NAME ?= ${REGIONAL_PUBLIC_ASSET_BUCKET_BASE_NAME}-${AWS_REGION}
export GLOBAL_ASSET_BUCKET_NAME ?= ${REGIONAL_ASSET_BUCKET_NAME}
export GLOBAL_ASSET_BUCKET_REGION = $(shell BUCKET=${GLOBAL_ASSET_BUCKET_NAME} ${SOLUTION_PATH}/deployment/determine-bucket-region.sh)
export REGIONAL_ASSET_BUCKET_REGION = $(shell BUCKET=${REGIONAL_ASSET_BUCKET_NAME} ${SOLUTION_PATH}/deployment/determine-bucket-region.sh)

# Using a ?= here fails to update the variable when this file is imported from each module makefile during a makefile chain
export S3_ASSET_KEY_PREFIX = ${SOLUTION_NAME}/${SOLUTION_VERSION}/${MODULE_NAME}

# Used by CDK apps
export S3_ASSET_BUCKET_BASE_NAME ?= ${REGIONAL_ASSET_BUCKET_BASE_NAME}

export LOG_BUCKET_RETENTION_DAYS ?= 90

# ==================================================================================
# PRINT COLORS
# 	To use: printf "%b<text>%b" "${<COLOR>}" "${NC}"
#   printf is recommended over echo if wanting color because of more multi-platform support.
#   https://en.wikipedia.org/wiki/ANSI_escape_code#Colors
#
# COLOR USAGE
# 	MAGENTA: Start, Progress, etc.
# 	RED: Failure, Stop, Cancel, Error, etc.
# 	GREEN: Success, Finished, Done, etc.
# 	YELLOW: Relevant extra prints or notes
# 	CYAN: Emphasis within a print or note. Links, commands, paths, etc. Typically combined with YELLOW
#	NC: No Color. Only use to end color, otherwise use nothing.
# ==================================================================================
export MAGENTA = \033[0;35m
export RED = \033[0;31m
export GREEN = \033[0;32m
export YELLOW = \033[0;33m
export CYAN = \033[0;36m
export NC = \033[00m

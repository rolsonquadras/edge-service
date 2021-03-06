#
# Copyright SecureKey Technologies Inc. All Rights Reserved.
#
# SPDX-License-Identifier: Apache-2.0
#

@all
@comparator_rest
Feature: Comparator_REST API

  @comparator_healthcheck
  Scenario: Comparator healthcheck
    When an HTTP GET is sent to "https://localhost:8065/healthcheck"
    Then the JSON path "status" of the response equals "success"

  @comparator_e2e
  Scenario: Comparator
    Then Check comparator config is created
    When Create a new vault using the vault server "https://localhost:9099"
    Then Save a document with the following id "M3aS9xwj8ybCwHkEiCJJR2" with data "data1"
    Then Save a document with the following id "M3aS9xwj8ybCwHkEiCJJR3" with data "data1"
    Then Save a document with the following id "M3aS9xwj8ybCwHkEiCJJR4" with data "data2"
    And Check that a document with id "M3aS9xwj8ybCwHkEiCJJR2" is stored
    And Check that a document with id "M3aS9xwj8ybCwHkEiCJJR3" is stored
    And Check that a document with id "M3aS9xwj8ybCwHkEiCJJR4" is stored
    Then Create vault authorization with duration "100"
    Then Create comparator authorization for doc "M3aS9xwj8ybCwHkEiCJJR3"
    Then Extract doc from auth token received from comparator authorization and validate data equal "data1"
    Then Compare two docs with doc1 id "M3aS9xwj8ybCwHkEiCJJR2" and ref doc with compare result "true"
    Then Compare two docs with doc1 id "M3aS9xwj8ybCwHkEiCJJR4" and ref doc with compare result "false"

*** Settings ***
Documentation     Setup dan teardown berlaku untuk semua test di folder ini.
...               Satu browser baru per test supaya hasil tidak bergantung urutan.
Resource          ../resources/common.resource
Test Setup        Open Test Browser
Test Teardown     Close Test Browser

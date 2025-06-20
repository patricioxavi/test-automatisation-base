Feature: Test de API súper simple

  Background:
    * configure ssl = true
    * def baseUrlPublic = 'https://httpbin.org/get'
    * def baseUrlCharacters = 'http://bp-se-test-cabcd9b246a5.herokuapp.com/ptovar/api/characters'
    * def requests = read('karate-requests.json')

  Scenario: Verificar que un endpoint público responde 200
    Given url 'https://httpbin.org/get'
    When method get
    Then status 200

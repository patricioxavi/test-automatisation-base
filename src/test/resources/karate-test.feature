Feature: Test de API súper simple

  Background:
    * configure ssl = true
    * def baseUrlCharacters = 'http://bp-se-test-cabcd9b246a5.herokuapp.com/ptovar/api/characters'
    * def requests = read('karate-requests.json')



  Scenario: Verificar que el endpoint de personajes responde correctamente
    Given url baseUrlCharacters
    When method get
    Then status 200
    And match response == '#[]'
    And match response[0] contains { id: '#number', name: '#string', alterego: '#string', description: '#string', powers: '#[]' }

  Scenario: Obtener personaje por ID
    Given url baseUrlCharacters + '/5'
    When method get
    Then status 200
    And match response contains requests.getCharacterById

  Scenario: Manejar caso donde el personaje no existe
    Given url baseUrlCharacters + '/9999'
    When method get
    Then status 404

  Scenario: Manejar caso de creación de personaje
    Given url baseUrlCharacters
    And request requests.createCharacter
    When method post
    Then status 201



  Scenario: Manejar caso de error al crear un personaje con nombre existente
    Given url baseUrlCharacters
    And request requests.createCharacterDuplicateName
    When method post
    Then status 400
    And match response == { error: 'Character name already exists' }

  Scenario: Manejar caso de error al crear un personaje con datos faltantes
    Given url baseUrlCharacters
    And request requests.createCharacterMissingData
    When method post
    Then status 400
    And match response == { name: 'Name is required' }

  Scenario: Actualizar datos de un personaje
    Given url baseUrlCharacters + '/5'
    And request requests.updateCharacter
    When method put
    Then status 200
    And match response contains requests.updateCharacterResponse

  Scenario: Manejar caso donde el personaje a actualizar no existe
    Given url baseUrlCharacters + '/9999'
    And request requests.updateCharacterNonExistent
    When method put
    Then status 404
    And match response == { error: 'Character not found' }

  Scenario: Eliminar un personaje por ID
    Given url baseUrlCharacters + '/10'
    When method delete
    Then status 204

  Scenario: Manejar caso donde el personaje a eliminar no existe
    Given url baseUrlCharacters + '/9999'
    When method delete
    Then status 404
    And match response == { error: 'Character not found' }


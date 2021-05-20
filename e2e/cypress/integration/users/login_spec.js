describe('Login', function() {
  beforeEach(() => {
    cy.app('clean')
    cy.appScenario('basic')
  })

  it('Open login page if user not signed in', function() {
    cy.visit('/')
    cy.contains('Sign In')
  })

  it('Test login functionality with wrong user name', function() {
    cy.login('asd', 'T3$tAdmin')
    cy.get('#flash_alert').contains('Invalid Login or password.')
  })

  it('Test login functionality with wrong password', function() {
    cy.login('admin', 'asasd')
    cy.get('#flash_alert').contains('Invalid Login or password.')
  })

  it('Test login functionality for admin', function() {
    cy.login('admin', 'T3$tAdmin')
    cy.get('#flash_notice').contains('Signed in successfully.')
    cy.logout()
  })
})
